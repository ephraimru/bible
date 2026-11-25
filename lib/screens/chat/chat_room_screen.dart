import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../config/theme.dart';
import '../../models/chat_model.dart';
import '../../models/user_model.dart';
import '../../services/auth_service.dart';
import '../../services/database_service.dart';
import '../../services/moderation_service.dart';
import '../../widgets/message_bubble.dart';

class ChatRoomScreen extends ConsumerStatefulWidget {
  final String roomId;

  const ChatRoomScreen({super.key, required this.roomId});

  @override
  ConsumerState<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends ConsumerState<ChatRoomScreen> {
  ChatRoomModel? _room;
  List<ChatMessageModel> _messages = [];
  bool _isLoading = true;
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _loadRoom();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadRoom() async {
    try {
      final room = await ref.read(localStorageServiceProvider).getChatRoom(widget.roomId);
      if (room != null) {
        setState(() {
          _room = room;
        });
        
        await _loadMessages();
        
        // Join room
        final userId = ref.read(localAuthServiceProvider).currentUserId;
        if (userId != null) {
          await ref.read(localStorageServiceProvider).joinChatRoom(room.id, userId);
        }
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadMessages() async {
    try {
      final messages = await ref.read(localStorageServiceProvider).getRecentChatMessages(
            widget.roomId,
            limit: 50,
          );
      
      setState(() {
        _messages = messages.reversed.toList();
        _isLoading = false;
      });
      
      // Scroll to bottom
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    
    final userId = ref.read(localAuthServiceProvider).currentUserId;
    if (userId == null || _room == null) return;
    
    setState(() {
      _isSending = true;
    });
    
    try {
      // Moderate message
      final moderationResult = await ref.read(moderationServiceProvider).moderateMessage(
            message: text,
            senderId: userId,
            roomId: _room!.id,
          );
      
      if (!moderationResult.isAllowed) {
        // Show error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Your message was blocked: ${moderationResult.reason}'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      
      // Get user info
      final user = ref.read(localCurrentUserProvider).value;
      
      // Create message
      final message = ChatMessageModel(
        id: '',
        roomId: _room!.id,
        senderId: userId,
        senderName: user?.displayName ?? 'Anonymous',
        senderPhotoUrl: user?.photoUrl,
        type: MessageType.text,
        content: text,
        moderationStatus: moderationResult.isFlagged 
            ? ModerationStatus.flagged 
            : ModerationStatus.approved,
        toxicityScore: moderationResult.toxicityScore,
        offensiveScore: moderationResult.offensiveScore,
        politicalScore: moderationResult.politicalScore,
        requiresReview: moderationResult.requiresReview,
        createdAt: DateTime.now(),
      );
      
      await ref.read(localStorageServiceProvider).createChatMessage(message);
      
      // Clear message input
      _messageController.clear();
      
      // Add message to local list
      setState(() {
        _messages.add(message);
      });
      
      // Scroll to bottom
      _scrollToBottom();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send message: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isSending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_room?.name ?? 'Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // Show room info
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _room == null
              ? _buildErrorView(context)
              : _buildChatRoomView(context),
    );
  }

  Widget _buildErrorView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.chat_outlined,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: AppTheme.md),
          Text(
            'Chat room not found',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppTheme.sm),
          Text(
            'The chat room you are looking for could not be found',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
          const SizedBox(height: AppTheme.lg),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Go Back'),
          ),
        ],
      ),
    );
  }

  Widget _buildChatRoomView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Room info banner
        _buildRoomInfoBanner(context),
        
        // Messages list
        _buildMessagesList(context),
        
        // Message input
        _buildMessageInput(context),
      ],
    );
  }

  Widget _buildRoomInfoBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.md),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            _room!.name,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.sm),
          Text(
            _room!.description ?? '',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.sm),
          Text(
            '${_room!.memberIds.length} members',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesList(BuildContext context) {
    if (_messages.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.chat_outlined,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: AppTheme.md),
              Text(
                'No messages yet',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppTheme.sm),
              Text(
                'Be the first to start the conversation!',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ],
          ),
        ),
      );
    }
    
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(AppTheme.md),
        reverse: false,
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          final message = _messages[index];
          final userId = ref.read(localAuthServiceProvider).currentUserId;
          final isCurrentUser = message.senderId == userId;
          
          return MessageBubble(
            message: message,
            isCurrentUser: isCurrentUser,
            onLike: () async {
              // Like message
            },
            onFlag: () async {
              // Flag message for moderation
              await ref.read(moderationServiceProvider).flagChatMessage(
                    roomId: _room!.id,
                    messageId: message.id,
                    reportedBy: userId ?? '',
                    reason: 'Inappropriate content',
                  );
            },
          );
        },
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.md),
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        children: [
          // Message input
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: AppTheme.mediumBorderRadius,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.md,
                  vertical: AppTheme.md,
                ),
              ),
              maxLines: 3,
              minLines: 1,
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          
          const SizedBox(width: AppTheme.md),
          
          // Send button
          IconButton(
            icon: _isSending
                ? const CircularProgressIndicator()
                : const Icon(Icons.send),
            onPressed: _isSending ? null : _sendMessage,
            style: IconButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(AppTheme.md),
            ),
          ),
        ],
      ),
    );
  }
}

// Message type extension for display
extension on MessageType {
  String get displayName {
    switch (this) {
      case MessageType.text:
        return 'Text';
      case MessageType.image:
        return 'Image';
      case MessageType.voice:
        return 'Voice';
      case MessageType.verseReference:
        return 'Verse';
      case MessageType.prayerRequest:
        return 'Prayer';
    }
  }
}
