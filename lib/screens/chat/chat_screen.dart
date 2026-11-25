import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/router.dart';
import '../../config/theme.dart';
import '../../models/chat_model.dart';
import '../../services/community_service.dart';
import '../../widgets/chat_room_card.dart';

/// The list of chat rooms, each showing its latest message live.
class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final community = ref.read(communityServiceProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Gospel Chat')),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.md),
        children: [
          Text(
            'Keep conversations kind and centred on the Gospel. '
            'Messages are checked automatically, and you can report anything inappropriate.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade700),
          ),
          const SizedBox(height: AppTheme.md),
          for (final room in CommunityService.rooms)
            StreamBuilder<ChatMessageModel?>(
              stream: community.watchLastMessage(room.id),
              builder: (context, snapshot) {
                final last = snapshot.data;
                final shown = last == null
                    ? room
                    : room.copyWith(
                        lastMessageContent: '${last.senderName ?? 'Someone'}: ${last.content}',
                        lastMessageAt: last.createdAt,
                        lastMessageSenderId: last.senderId,
                      );
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppTheme.sm),
                  child: ChatRoomCard(
                    room: shown,
                    onTap: () => context.pushChatRoom(room.id),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
