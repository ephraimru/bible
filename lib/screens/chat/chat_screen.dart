import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/theme.dart';
import '../../models/chat_model.dart';
import '../../models/user_model.dart';
import '../../services/auth_service.dart';
import '../../services/database_service.dart';
import '../widgets/chat_room_card.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  List<ChatRoomModel> _rooms = [];
  bool _isLoading = true;
  ChatRoomModel? _generalRoom;

  @override
  void initState() {
    super.initState();
    _loadRooms();
  }

  Future<void> _loadRooms() async {
    try {
      final rooms = await ref.read(databaseServiceProvider).getChatRooms();
      final generalRoom = await ref.read(databaseServiceProvider).getGeneralChatRoom();
      
      setState(() {
        _rooms = rooms;
        _generalRoom = generalRoom;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gospel Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Open search
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _buildChatContent(context),
    );
  }

  Widget _buildChatContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // General chat room (always at top)
        if (_generalRoom != null)
          _buildGeneralRoomCard(context),
        
        // Room categories
        _buildRoomCategories(context),
        
        // All rooms list
        _buildRoomsList(context),
      ],
    );
  }

  Widget _buildGeneralRoomCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppTheme.md),
      decoration: BoxDecoration(
        borderRadius: AppTheme.largeBorderRadius,
        gradient: AppTheme.primaryGradient,
      ),
      child: ClipRRect(
        borderRadius: AppTheme.largeBorderRadius,
        child: Stack(
          children: [
            // Background
            Container(
              height: 120,
              color: Colors.blue,
              child: Center(
                child: Icon(
                  Icons.chat,
                  size: 48,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
            
            // Content
            Container(
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: const EdgeInsets.all(AppTheme.lg),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _generalRoom!.name,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Main gospel discussion room',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.white.withOpacity(0.8),
                              ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                    onPressed: () => context.pushChatRoom(_generalRoom!.id),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomCategories(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.md),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildCategoryChip(context, ChatRoomType.general, 'All'),
            const SizedBox(width: AppTheme.sm),
            _buildCategoryChip(context, ChatRoomType.prayerGroup, 'Prayer'),
            const SizedBox(width: AppTheme.sm),
            _buildCategoryChip(context, ChatRoomType.bibleStudy, 'Bible Study'),
            const SizedBox(width: AppTheme.sm),
            _buildCategoryChip(context, ChatRoomType.testimonies, 'Testimonies'),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(BuildContext context, ChatRoomType type, String label) {
    return FilterChip(
      label: Text(label),
      selected: false, // Will be implemented with filtering
      onSelected: (selected) {
        // Filter rooms by category
      },
      shape: RoundedRectangleBorder(
        borderRadius: AppTheme.mediumBorderRadius,
      ),
    );
  }

  Widget _buildRoomsList(BuildContext context) {
    final filteredRooms = _rooms.where((room) => room.id != _generalRoom?.id).toList();
    
    if (filteredRooms.isEmpty) {
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
                'No chat rooms available',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppTheme.sm),
              Text(
                'Join the general discussion or create a new room',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }
    
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.md),
        itemCount: filteredRooms.length,
        itemBuilder: (context, index) {
          final room = filteredRooms[index];
          return ChatRoomCard(
            room: room,
            onTap: () => context.pushChatRoom(room.id),
          );
        },
      ),
    );
  }
}
