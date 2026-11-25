import 'dart:async';

import 'package:flutter/foundation.dart';
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
import '../screens/profile/member_profile_screen.dart';
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

/// Re-runs the router's redirect whenever the auth state changes.
class _AuthRefresh extends ChangeNotifier {
  _AuthRefresh(Stream<UserModel?> stream) {
    _sub = stream.listen((_) => notifyListeners());
  }
  late final StreamSubscription<UserModel?> _sub;
  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}

const _authPaths = {'/welcome', '/login', '/signup', '/forgot-password'};

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.read(authServiceProvider);
  final refresh = _AuthRefresh(auth.authStateChanges);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: kDebugMode,
    refreshListenable: refresh,
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
                  final book = state.pathParameters['book']!;
                  final chapter = int.tryParse(state.uri.queryParameters['chapter'] ?? '') ?? 1;
                  return BookScreen(key: ValueKey('$book/$chapter'), book: book, initialChapter: chapter);
                },
              ),
              GoRoute(
                path: 'verse/:id',
                name: 'verseDetail',
                builder: (context, state) {
                  final verseId = state.pathParameters['id']!;
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
                  final postId = state.pathParameters['id']!;
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
                  final roomId = state.pathParameters['id']!;
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
          GoRoute(
            path: '/member/:uid',
            name: 'member',
            builder: (context, state) => MemberProfileScreen(
              key: ValueKey(state.pathParameters['uid']),
              uid: state.pathParameters['uid']!,
            ),
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
    
    redirect: (context, state) {
      final location = state.matchedLocation;
      // The splash screen decides where to go once the Bible has loaded.
      if (location == '/') return null;

      final isLoggedIn = auth.isLoggedIn;
      final isAuthPage = _authPaths.contains(location);
      if (!isLoggedIn && !isAuthPage) return '/welcome';
      if (isLoggedIn && isAuthPage) return '/home';
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

});

/// Scaffold with the bottom navigation bar shared by the main tabs.
class _MainShell extends StatelessWidget {
  const _MainShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const _BottomNavigationBar(),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar();

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    
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
  
  void pushBibleBook(String book, {int? chapter}) => go(
      '/bible/book/${Uri.encodeComponent(book)}${chapter != null ? '?chapter=$chapter' : ''}');
  void pushVerseDetail(String verseId) => go('/bible/verse/${Uri.encodeComponent(verseId)}');
  void pushPostDetail(String postId) => go('/blog/post/$postId');
  void pushCreatePost() => go('/blog/create');
  void pushChatRoom(String roomId) => go('/chat/room/$roomId');
}
