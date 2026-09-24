import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../screens/splash_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/auth/forgot_password_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/bible/bible_screen.dart';
import '../screens/blog/blog_screen.dart';
import '../screens/chat/chat_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/daily_verse/daily_verse_screen.dart';
import '../screens/faith_journey/faith_journey_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/premium/premium_screen.dart';
import '../screens/blog/create_post_screen.dart';
import '../screens/chat/chat_room_screen.dart';
import '../screens/bible/verse_detail_screen.dart';
import '../screens/bible/book_screen.dart';
import '../screens/blog/post_detail_screen.dart';
import '../screens/auth/welcome_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      // Public routes
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/welcome',
        name: 'welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgotPassword',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      
      // Authenticated routes
      ShellRoute(
        builder: (context, state, child) => _MainShell(child: child),
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                path: 'daily-verse',
                name: 'dailyVerse',
                builder: (context, state) => const DailyVerseScreen(),
              ),
              GoRoute(
                path: 'faith-journey',
                name: 'faithJourney',
                builder: (context, state) => const FaithJourneyScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/bible',
            name: 'bible',
            builder: (context, state) => const BibleScreen(),
            routes: [
              GoRoute(
                path: 'book/:book',
                name: 'bibleBook',
                builder: (context, state) {
                  final book = state.pathParams['book']!;
                  return BookScreen(book: book);
                },
              ),
              GoRoute(
                path: 'verse/:id',
                name: 'verseDetail',
                builder: (context, state) {
                  final verseId = state.pathParams['id']!;
                  return VerseDetailScreen(verseId: verseId);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/blog',
            name: 'blog',
            builder: (context, state) => const BlogScreen(),
            routes: [
              GoRoute(
                path: 'post/:id',
                name: 'postDetail',
                builder: (context, state) {
                  final postId = state.pathParams['id']!;
                  return PostDetailScreen(postId: postId);
                },
              ),
              GoRoute(
                path: 'create',
                name: 'createPost',
                builder: (context, state) => const CreatePostScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/chat',
            name: 'chat',
            builder: (context, state) => const ChatScreen(),
            routes: [
              GoRoute(
                path: 'room/:id',
                name: 'chatRoom',
                builder: (context, state) {
                  final roomId = state.pathParams['id']!;
                  return ChatRoomScreen(roomId: roomId);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      
      // Settings and Premium routes
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/premium',
        name: 'premium',
        builder: (context, state) => const PremiumScreen(),
      ),
    ],
    
    // Redirect logic
    redirect: (context, state) async {
      final isLoggedIn = await _isLoggedIn(context);
      final isSplash = state.location == '/';
      final isAuthPage = state.location.startsWith('/login') ||
          state.location.startsWith('/signup') ||
          state.location.startsWith('/forgot-password') ||
          state.location == '/welcome';
      
      // Allow splash screen
      if (isSplash) return null;
      
      // If not logged in and not on auth page, redirect to welcome
      if (!isLoggedIn && !isAuthPage) {
        return '/welcome';
      }
      
      // If logged in and on auth page, redirect to home
      if (isLoggedIn && isAuthPage) {
        return '/home';
      }
      
      return null;
    },
    
    // Handle errors
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Page not found'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );

  // Main shell with bottom navigation
  static Widget _MainShell({required Widget child}) {
    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: _BottomNavigationBar(child: child),
        );
      },
      child: child,
    );
  }

  // Check if user is logged in
  static Future<bool> _isLoggedIn(BuildContext context) async {
    final authService = context.read<AuthService>();
    return authService.currentUserId != null;
  }
}

class _BottomNavigationBar extends ConsumerWidget {
  final Widget child;

  const _BottomNavigationBar({required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).location;
    
    return BottomNavigationBar(
      currentIndex: _getCurrentIndex(location),
      onTap: (index) => _onItemTapped(context, index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_outlined),
          activeIcon: Icon(Icons.menu_book),
          label: 'Bible',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.article_outlined),
          activeIcon: Icon(Icons.article),
          label: 'Blog',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_outlined),
          activeIcon: Icon(Icons.chat),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }

  int _getCurrentIndex(String location) {
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/bible')) return 1;
    if (location.startsWith('/blog')) return 2;
    if (location.startsWith('/chat')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0;
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/bible');
        break;
      case 2:
        context.go('/blog');
        break;
      case 3:
        context.go('/chat');
        break;
      case 4:
        context.go('/profile');
        break;
    }
  }
}

// Extension for easy navigation
extension GoRouterExtensions on BuildContext {
  void goHome() => go('/home');
  void goBible() => go('/bible');
  void goBlog() => go('/blog');
  void goChat() => go('/chat');
  void goProfile() => go('/profile');
  void goSettings() => go('/settings');
  void goPremium() => go('/premium');
  void goDailyVerse() => go('/home/daily-verse');
  void goFaithJourney() => go('/home/faith-journey');
  void goLogin() => go('/login');
  void goSignup() => go('/signup');
  void goWelcome() => go('/welcome');
  
  void pushBibleBook(String book) => go('/bible/book/$book');
  void pushVerseDetail(String verseId) => go('/bible/verse/$verseId');
  void pushPostDetail(String postId) => go('/blog/post/$postId');
  void pushCreatePost() => go('/blog/create');
  void pushChatRoom(String roomId) => go('/chat/room/$roomId');
}
