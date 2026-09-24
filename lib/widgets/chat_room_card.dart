import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../config/theme.dart';
import '../models/chat_model.dart';

class ChatRoomCard extends StatelessWidget {
  final ChatRoomModel room;
  final VoidCallback? onTap;

  const ChatRoomCard({
    super.key,
    required this.room,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: AppTheme.mediumBorderRadius,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppTheme.mediumBorderRadius,
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.md),
          child: Row(
            children: [
              // Room icon/avatar
              Container(
                padding: const EdgeInsets.all(AppTheme.md),
                decoration: BoxDecoration(
                  color: _getRoomColor(room.type),
                  borderRadius: AppTheme.mediumBorderRadius,
                ),
                child: Icon(_getRoomIcon(room.type), color: Colors.white),
              ),
              
              const SizedBox(width: AppTheme.md),
              
              // Room info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      room.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    
                    const SizedBox(height: AppTheme.xs),
                    
                    // Last message preview
                    if (room.lastMessageContent != null)
                      Text(
                        '${room.lastMessageSenderId}: ${room.lastMessageContent!}' ,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    
                    const SizedBox(height: AppTheme.xs),
                    
                    // Room metadata
                    Row(
                      children: [
                        Text(
                          '${room.memberIds.length} members',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        
                        if (room.lastMessageAt != null)
                          Padding(
                            padding: const EdgeInsets.only(left: AppTheme.sm),
                            child: Text(
                              DateFormat('hh:mm a').format(room.lastMessageAt!),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Unread count badge
              if (room.unreadCount > 0)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${room.unreadCount}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getRoomColor(ChatRoomType type) {
    switch (type) {
      case ChatRoomType.general:
        return Colors.blue;
      case ChatRoomType.prayerGroup:
        return Colors.purple;
      case ChatRoomType.bibleStudy:
        return Colors.green;
      case ChatRoomType.testimonies:
        return Colors.amber;
      case ChatRoomType.private:
        return Colors.grey;
    }
  }

  IconData _getRoomIcon(ChatRoomType type) {
    switch (type) {
      case ChatRoomType.general:
        return Icons.chat;
      case ChatRoomType.prayerGroup:
        return Icons.groups;
      case ChatRoomType.bibleStudy:
        return Icons.menu_book;
      case ChatRoomType.testimonies:
        return Icons.mic;
      case ChatRoomType.private:
        return Icons.lock;
    }
  }
}
