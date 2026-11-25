import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/theme.dart';
import '../../models/chat_model.dart';
import '../../services/auth_service.dart';
import '../../services/community_service.dart';
import '../../services/local_storage_service.dart';
import '../../services/moderation_service.dart';
import '../../widgets/message_bubble.dart';
import '../../widgets/report_dialog.dart';
import '../profile/member_profile_screen.dart';

/// A live chat room. Long-press a message to copy, report, block or delete.
class ChatRoomScreen extends ConsumerStatefulWidget {
  final String roomId;

  const ChatRoomScreen({super.key, required this.roomId});

  @override
  ConsumerState<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends ConsumerState<ChatRoomScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  StreamSubscription<List<ChatMessageModel>>? _sub;

  late final ChatRoomModel? _room = CommunityService.roomById(widget.roomId);
  List<ChatMessageModel> _messages = [];
  bool _isLoading = true;
  bool _isSending = false;
  String? _error;

  String? get _uid => ref.read(authServiceProvider).currentUserId;

  @override
  void initState() {
    super.initState();
    if (_room != null) _listen();
  }

  void _listen() {
    _sub?.cancel();
    _sub = ref.read(communityServiceProvider).watchMessages(widget.roomId).listen(
      (messages) {
        if (!mounted) return;
        final blocked = ref.read(currentUserProvider)?.blockedUserIds ?? const [];
        final atBottom = !_scrollController.hasClients ||
            _scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 80;
        setState(() {
          _messages = messages.where((m) => !blocked.contains(m.senderId)).toList();
          _isLoading = false;
          _error = null;
        });
        if (atBottom) _scrollToBottom();
      },
      onError: (Object e) {
        if (!mounted) return;
        setState(() {
          _isLoading = false;
          _error = 'Could not load messages. Check your internet connection.';
        });
      },
    );
  }

  @override
  void dispose() {
    _sub?.cancel();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _toast(String message, {bool error = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: error ? Colors.red : null),
    );
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    final user = ref.read(currentUserProvider);
    final room = _room;
    if (text.isEmpty || user == null || room == null || _isSending) return;
    if (text.length > CommunityService.maxMessageLength) {
      _toast('Messages can be up to ${CommunityService.maxMessageLength} characters.', error: true);
      return;
    }

    setState(() => _isSending = true);
    try {
      final moderation = await ref.read(moderationServiceProvider).moderateMessage(
            message: text,
            senderId: user.id,
            roomId: room.id,
          );
      if (!moderation.isAllowed) {
        _toast('Your message was blocked: ${moderation.reason}', error: true);
        return;
      }
      await ref.read(communityServiceProvider).sendMessage(
            roomId: room.id,
            sender: user,
            content: text,
            flagged: moderation.isFlagged,
          );
      _messageController.clear();
      _scrollToBottom();
    } catch (e) {
      _toast('Could not send your message. Check your connection.', error: true);
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  Future<void> _showMessageActions(ChatMessageModel message) async {
    final mine = message.senderId == _uid;
    final action = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.copy),
              title: const Text('Copy'),
              onTap: () => Navigator.pop(context, 'copy'),
            ),
            if (mine)
              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: const Text('Delete message'),
                onTap: () => Navigator.pop(context, 'delete'),
              )
            else ...[
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: Text('View ${message.senderName ?? 'profile'}'),
                onTap: () => Navigator.pop(context, 'profile'),
              ),
              ListTile(
                leading: const Icon(Icons.flag_outlined),
                title: const Text('Report message'),
                onTap: () => Navigator.pop(context, 'report'),
              ),
              ListTile(
                leading: const Icon(Icons.block),
                title: Text('Block ${message.senderName ?? 'this person'}'),
                onTap: () => Navigator.pop(context, 'block'),
              ),
            ],
          ],
        ),
      ),
    );
    if (!mounted || action == null) return;
    final community = ref.read(communityServiceProvider);
    switch (action) {
      case 'copy':
        await Clipboard.setData(ClipboardData(text: message.content));
        _toast('Message copied');
      case 'delete':
        try {
          await community.deleteMessage(widget.roomId, message.id);
        } catch (_) {
          _toast('Could not delete the message.', error: true);
        }
      case 'report':
        final reporter = _uid;
        if (reporter == null) return;
        final reason = await showReportDialog(context);
        if (reason == null) return;
        try {
          await community.report(
            reporterId: reporter,
            contentPath: CommunityService.messagePath(widget.roomId, message.id),
            authorId: message.senderId,
            reason: reason,
            excerpt: message.content,
          );
          _toast('Thank you. The message was reported to the admin.');
        } catch (_) {
          _toast('Could not send the report.', error: true);
        }
      case 'block':
        await _block(message);
      case 'profile':
        context.pushMemberProfile(message.senderId);
    }
  }

  /// Hides everything from this person in the blog and chat, on this device.
  /// Unblock in Settings > Blocked Users.
  Future<void> _block(ChatMessageModel message) async {
    final user = ref.read(currentUserProvider);
    if (user == null) return;
    await ref.read(localStorageServiceProvider).updateUser(user.id, {
      'blockedUserIds': {...user.blockedUserIds, message.senderId}.toList(),
    });
    setState(() => _messages.removeWhere((m) => m.senderId == message.senderId));
    _toast('${message.senderName ?? 'They'} is blocked. You can unblock in Settings.');
  }

  @override
  Widget build(BuildContext context) {
    final room = _room;
    return Scaffold(
      appBar: AppBar(title: Text(room?.name ?? 'Chat')),
      body: room == null
          ? _buildNotFound(context)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (room.description != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppTheme.md, vertical: AppTheme.sm),
                    color: Theme.of(context).colorScheme.surface,
                    child: Text(
                      room.description!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade700),
                    ),
                  ),
                Expanded(child: _buildMessages(context)),
                _buildInput(context),
              ],
            ),
    );
  }

  Widget _buildNotFound(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.chat_outlined, size: 64, color: Colors.grey),
          const SizedBox(height: AppTheme.md),
          Text('Chat room not found', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppTheme.lg),
          ElevatedButton(onPressed: () => context.go('/chat'), child: const Text('Back to Chat')),
        ],
      ),
    );
  }

  Widget _buildMessages(BuildContext context) {
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_error!, textAlign: TextAlign.center),
            const SizedBox(height: AppTheme.md),
            FilledButton(
              onPressed: () {
                setState(() => _isLoading = true);
                _listen();
              },
              child: const Text('Try again'),
            ),
          ],
        ),
      );
    }
    if (_messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.chat_outlined, size: 64, color: Colors.grey),
            const SizedBox(height: AppTheme.md),
            Text('No messages yet', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppTheme.sm),
            Text(
              'Be the first to start the conversation!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      );
    }
    final uid = _uid;
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(AppTheme.md),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        return GestureDetector(
          onLongPress: () => _showMessageActions(message),
          child: MessageBubble(message: message, isCurrentUser: message.senderId == uid),
        );
      },
    );
  }

  Widget _buildInput(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.all(AppTheme.md),
        color: Theme.of(context).colorScheme.surface,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  border: OutlineInputBorder(borderRadius: AppTheme.mediumBorderRadius),
                  contentPadding: const EdgeInsets.symmetric(horizontal: AppTheme.md, vertical: 12),
                ),
                maxLines: 4,
                minLines: 1,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
            const SizedBox(width: AppTheme.sm),
            IconButton(
              icon: _isSending
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.send),
              tooltip: 'Send',
              onPressed: _isSending ? null : _sendMessage,
              style: IconButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(AppTheme.md),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
