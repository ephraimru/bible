import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../config/theme.dart';
import '../models/chat_model.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessageModel message;
  final bool isCurrentUser;
  final VoidCallback? onLike;
  final VoidCallback? onFlag;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    this.onLike,
    this.onFlag,
  });

  @override
  Widget build(BuildContext context) {
    final alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    final color = isCurrentUser 
        ? AppTheme.primaryColor 
        : Theme.of(context).colorScheme.surface;
    final textColor = isCurrentUser ? Colors.white : Colors.black;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.sm),
      child: Align(
        alignment: alignment,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.8,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: _getBorderRadius(isCurrentUser),
              boxShadow: AppTheme.lightShadow,
            ),
            padding: const EdgeInsets.all(AppTheme.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Sender info (for non-current user)
                if (!isCurrentUser)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppTheme.xs),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (message.senderPhotoUrl != null)
                          CircleAvatar(
                            radius: 12,
                            backgroundImage: NetworkImage(message.senderPhotoUrl!),
                          )
                        else
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: AppTheme.primaryColor,
                            child: Text(
                              message.senderName?.isNotEmpty ?? false
                                  ? message.senderName![0].toUpperCase()
                                  : 'U',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        const SizedBox(width: AppTheme.xs),
                        Text(
                          message.senderName ?? 'Anonymous',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: textColor.withOpacity(0.8),
                              ),
                        ),
                      ],
                    ),
                  ),
                
                // Message content
                Text(
                  message.content,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: textColor,
                      ),
                ),
                
                // Message metadata
                Padding(
                  padding: const EdgeInsets.only(top: AppTheme.xs),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        DateFormat('hh:mm a').format(message.createdAt ?? DateTime.now()),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: textColor.withOpacity(0.6),
                            ),
                      ),
                      
                      const SizedBox(width: AppTheme.sm),
                      
                      // Message status indicators
                      if (message.moderationStatus == ModerationStatus.flagged)
                        Icon(
                          Icons.flag,
                          size: 14,
                          color: Colors.red,
                        ),
                      
                      if (message.likes > 0)
                        Row(
                          children: [
                            const Icon(Icons.favorite, size: 14, color: Colors.red),
                            const SizedBox(width: 4),
                            Text('${message.likes}'),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BorderRadius _getBorderRadius(bool isCurrentUser) {
    if (isCurrentUser) {
      return const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(4),
      );
    } else {
      return const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
        bottomLeft: Radius.circular(4),
        bottomRight: Radius.circular(16),
      );
    }
  }
}
