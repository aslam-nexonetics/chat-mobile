import 'package:chat_mobile/core/constents/collection_types.dart';
import 'package:chat_mobile/core/constents/route_constants.dart';
import 'package:chat_mobile/fetures/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_mobile/fetures/auth/presentation/bloc/auth_state.dart';
import 'package:chat_mobile/fetures/auth/presentation/pages/login_page.dart';
import 'package:chat_mobile/fetures/auth/presentation/pages/registration_page.dart';
import 'package:chat_mobile/fetures/auth/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'collection_router.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteConstants.splash,
    debugLogDiagnostics: true,
    redirect: _redirect,
    refreshListenable: GoRouterRefreshStream([
      // This will listen to auth state changes
      // You'll need to implement GoRouterRefreshStream or use a different approach
    ]),
    routes: [
      // Auth Routes
      GoRoute(
        path: RouteConstants.splash,
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: RouteConstants.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RouteConstants.register,
        name: 'register',
        builder: (context, state) => const RegistrationPage(),
      ),
      GoRoute(
        path: RouteConstants.forgotPassword,
        name: 'forgotPassword',
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: RouteConstants.resetPassword,
        name: 'resetPassword',
        builder: (context, state) => const ResetPasswordPage(),
      ),
      GoRoute(
        path: RouteConstants.verifyEmail,
        name: 'verifyEmail',
        builder: (context, state) => const VerifyEmailPage(),
      ),
      GoRoute(
        path: RouteConstants.onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),

      // // Main App Shell with Bottom Navigation
      // ShellRoute(
      //   navigatorKey: _shellNavigatorKey,
      //   builder: (context, state, child) {
      //     return MainShellPage(child: child);
      //   },
      //   routes: [
      //     // Home Route
      //     GoRoute(
      //       path: RouteConstants.home,
      //       name: 'home',
      //       pageBuilder:
      //           (context, state) => const NoTransitionPage(child: HomePage()),
      //     ),

      //     // Collections Route
      //     GoRoute(
      //       path: RouteConstants.collections,
      //       name: 'collections',
      //       pageBuilder:
      //           (context, state) =>
      //               const NoTransitionPage(child: CollectionsPage()),
      //     ),

      //     // Profile Route
      //     GoRoute(
      //       path: RouteConstants.profile,
      //       name: 'profile',
      //       pageBuilder:
      //           (context, state) =>
      //               const NoTransitionPage(child: ProfilePage()),
      //       routes: [
      //         GoRoute(
      //           path: '/edit',
      //           name: 'editProfile',
      //           builder: (context, state) => const EditProfilePage(),
      //         ),
      //         GoRoute(
      //           path: '/change-password',
      //           name: 'changePassword',
      //           builder: (context, state) => const ChangePasswordPage(),
      //         ),
      //         GoRoute(
      //           path: '/settings',
      //           name: 'accountSettings',
      //           builder: (context, state) => const AccountSettingsPage(),
      //         ),
      //       ],
      //     ),

      //     // Settings Route
      //     GoRoute(
      //       path: RouteConstants.settings,
      //       name: 'settings',
      //       pageBuilder:
      //           (context, state) =>
      //               const NoTransitionPage(child: SettingsPage()),
      //     ),

      //     // Notifications Route
      //     GoRoute(
      //       path: RouteConstants.notifications,
      //       name: 'notifications',
      //       pageBuilder:
      //           (context, state) =>
      //               const NoTransitionPage(child: NotificationsPage()),
      //     ),
      //   ],
      // ),

      // Collection Routes
      // GoRoute(
      //   path: '/collection/:id',
      //   name: 'collection',
      //   builder: (context, state) {
      //     final collectionId = state.pathParameters['id']!;
      //     return CollectionWrapperPage(collectionId: collectionId);
      //   },
      //   routes: [
      //     // Collection home routes will be handled by CollectionRouter
      //     GoRoute(
      //       path: '/home',
      //       name: 'collectionHome',
      //       builder: (context, state) {
      //         final collectionId = state.pathParameters['id']!;
      //         return CollectionRouter.buildCollectionHome(
      //           context,
      //           collectionId,
      //           state.extra as CollectionType?,
      //         );
      //       },
      //     ),
      //     GoRoute(
      //       path: '/chat',
      //       name: 'collectionChat',
      //       builder: (context, state) {
      //         final collectionId = state.pathParameters['id']!;
      //         return CollectionRouter.buildCollectionChat(
      //           context,
      //           collectionId,
      //           state.extra as CollectionType?,
      //         );
      //       },
      //       routes: [
      //         GoRoute(
      //           path: '/:chatId',
      //           name: 'chatRoom',
      //           builder: (context, state) {
      //             final collectionId = state.pathParameters['id']!;
      //             final chatId = state.pathParameters['chatId']!;
      //             return ChatRoomPage(
      //               collectionId: collectionId,
      //               chatId: chatId,
      //             );
      //           },
      //         ),
      //       ],
      //     ),
      //     GoRoute(
      //       path: '/profile',
      //       name: 'collectionProfile',
      //       builder: (context, state) {
      //         final collectionId = state.pathParameters['id']!;
      //         return CollectionRouter.buildCollectionProfile(
      //           context,
      //           collectionId,
      //           state.extra as CollectionType?,
      //         );
      //       },
      //     ),
      //     GoRoute(
      //       path: '/members',
      //       name: 'collectionMembers',
      //       builder: (context, state) {
      //         final collectionId = state.pathParameters['id']!;
      //         return CollectionMembersPage(collectionId: collectionId);
      //       },
      //     ),
      //     GoRoute(
      //       path: '/settings',
      //       name: 'collectionSettings',
      //       builder: (context, state) {
      //         final collectionId = state.pathParameters['id']!;
      //         return CollectionSettingsPage(collectionId: collectionId);
      //       },
      //     ),
      //   ],
      // ),

      // Call Routes
      GoRoute(
        path: '/call/voice/:callId',
        name: 'voiceCall',
        builder: (context, state) {
          final callId = state.pathParameters['callId']!;
          final collectionId = state.uri.queryParameters['collectionId'];
          return VoiceCallPage(callId: callId, collectionId: collectionId);
        },
      ),
      GoRoute(
        path: '/call/video/:callId',
        name: 'videoCall',
        builder: (context, state) {
          final callId = state.pathParameters['callId']!;
          final collectionId = state.uri.queryParameters['collectionId'];
          return VideoCallPage(callId: callId, collectionId: collectionId);
        },
      ),
      GoRoute(
        path: '/call/incoming/:callId',
        name: 'incomingCall',
        builder: (context, state) {
          final callId = state.pathParameters['callId']!;
          return IncomingCallPage(callId: callId);
        },
      ),

      // Media Routes
      GoRoute(
        path: '/media/:mediaId',
        name: 'mediaViewer',
        builder: (context, state) {
          final mediaId = state.pathParameters['mediaId']!;
          final mediaType = state.uri.queryParameters['type'] ?? 'image';
          return MediaViewerPage(mediaId: mediaId, mediaType: mediaType);
        },
      ),

      // Search Routes
      GoRoute(
        path: RouteConstants.search,
        name: 'search',
        builder: (context, state) => const SearchPage(),
        routes: [
          GoRoute(
            path: '/results',
            name: 'searchResults',
            builder: (context, state) {
              final query = state.uri.queryParameters['q'] ?? '';
              return SearchResultsPage(query: query);
            },
          ),
        ],
      ),

      // Error Routes
      GoRoute(
        path: RouteConstants.error,
        name: 'error',
        builder: (context, state) {
          final error = state.extra as String?;
          return ErrorPage(error: error);
        },
      ),
      GoRoute(
        path: RouteConstants.notFound,
        name: 'notFound',
        builder: (context, state) => const NotFoundPage(),
      ),
      GoRoute(
        path: RouteConstants.offline,
        name: 'offline',
        builder: (context, state) => const OfflinePage(),
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(error: state.error?.toString()),
  );

  /// Redirect logic for authentication and route protection
  static String? _redirect(BuildContext context, GoRouterState state) {
    final authBloc = context.read<AuthBloc>();
    final authState = authBloc.state;

    final isLoggedIn = authState is AuthAuthenticated;
    final isLoading = authState is AuthLoading;
    final isOnSplash = state.matchedLocation == RouteConstants.splash;
    final isOnAuthPage = [
      RouteConstants.login,
      RouteConstants.register,
      RouteConstants.forgotPassword,
    ].contains(state.matchedLocation);

    // Show splash during loading unless we're already on splash
    if (isLoading && !isOnSplash) {
      return RouteConstants.splash;
    }

    // If not loading and not logged in, go to login unless on auth pages
    if (!isLoading && !isLoggedIn && !isOnAuthPage) {
      return RouteConstants.login;
    }

    // If logged in and on auth pages, go to home
    if (isLoggedIn && isOnAuthPage) {
      return RouteConstants.home;
    }

    return null;
  }

  /// Navigate to a specific route
  static void go(String route) {
    _router.go(route);
  }

  /// Push a new route onto the stack
  static void push(String route) {
    _router.push(route);
  }

  /// Pop the current route
  static void pop() {
    _router.pop();
  }

  /// Navigate to collection home
  static void goToCollectionHome(String collectionId, CollectionType type) {
    _router.go('/collection/$collectionId/home', extra: type);
  }

  /// Navigate to collection chat
  static void goToCollectionChat(String collectionId, CollectionType type) {
    _router.go('/collection/$collectionId/chat', extra: type);
  }

  /// Navigate to collection profile
  static void goToCollectionProfile(String collectionId, CollectionType type) {
    _router.go('/collection/$collectionId/profile', extra: type);
  }

  /// Navigate to chat room
  static void goToChatRoom(String collectionId, String chatId) {
    _router.go('/collection/$collectionId/chat/$chatId');
  }

  /// Navigate to voice call
  static void goToVoiceCall(String callId, {String? collectionId}) {
    final uri = Uri(
      path: '/call/voice/$callId',
      queryParameters:
          collectionId != null ? {'collectionId': collectionId} : null,
    );
    _router.go(uri.toString());
  }

  /// Navigate to video call
  static void goToVideoCall(String callId, {String? collectionId}) {
    final uri = Uri(
      path: '/call/video/$callId',
      queryParameters:
          collectionId != null ? {'collectionId': collectionId} : null,
    );
    _router.go(uri.toString());
  }

  /// Navigate to media viewer
  static void goToMediaViewer(String mediaId, String mediaType) {
    final uri = Uri(
      path: '/media/$mediaId',
      queryParameters: {'type': mediaType},
    );
    _router.go(uri.toString());
  }

  /// Navigate to search results
  static void goToSearchResults(String query) {
    final uri = Uri(path: '/search/results', queryParameters: {'q': query});
    _router.go(uri.toString());
  }

  /// Check if current route is a collection route
  static bool isCollectionRoute(String route) {
    return route.startsWith('/collection/');
  }

  /// Get collection ID from current route
  static String? getCollectionIdFromRoute(String route) {
    final regex = RegExp(r'/collection/([^/]+)');
    final match = regex.firstMatch(route);
    return match?.group(1);
  }

  /// Get current route name
  static String? getCurrentRouteName(BuildContext context) {
    final routerDelegate = GoRouter.of(context);
    return routerDelegate
        .routerDelegate
        .currentConfiguration
        .matches
        .last
        .matchedLocation;
  }

  /// Check if user can access route
  static bool canAccessRoute(String route, BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    final isLoggedIn = authBloc.state is AuthAuthenticated;
    // final isLoggedIn = false;

    // Public routes
    final publicRoutes = [
      RouteConstants.splash,
      RouteConstants.login,
      RouteConstants.register,
      RouteConstants.forgotPassword,
      RouteConstants.resetPassword,
      RouteConstants.verifyEmail,
    ];

    if (publicRoutes.contains(route)) {
      return true;
    }

    // Protected routes require authentication
    return isLoggedIn;
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(List<Listenable> streams) {
    for (final stream in streams) {
      stream.addListener(notifyListeners);
    }
  }

  @override
  void dispose() {
    // Clean up listeners
    super.dispose();
  }
}

// Placeholder pages - these should be replaced with actual implementations
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class MainShellPage extends StatelessWidget {
  final Widget child;
  const MainShellPage({super.key, required this.child});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class CollectionWrapperPage extends StatelessWidget {
  final String collectionId;
  const CollectionWrapperPage({super.key, required this.collectionId});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class ChatRoomPage extends StatelessWidget {
  final String collectionId;
  final String chatId;
  const ChatRoomPage({
    super.key,
    required this.collectionId,
    required this.chatId,
  });
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class CollectionMembersPage extends StatelessWidget {
  final String collectionId;
  const CollectionMembersPage({super.key, required this.collectionId});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class CollectionSettingsPage extends StatelessWidget {
  final String collectionId;
  const CollectionSettingsPage({super.key, required this.collectionId});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class VoiceCallPage extends StatelessWidget {
  final String callId;
  final String? collectionId;
  const VoiceCallPage({super.key, required this.callId, this.collectionId});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class VideoCallPage extends StatelessWidget {
  final String callId;
  final String? collectionId;
  const VideoCallPage({super.key, required this.callId, this.collectionId});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class IncomingCallPage extends StatelessWidget {
  final String callId;
  const IncomingCallPage({super.key, required this.callId});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class MediaViewerPage extends StatelessWidget {
  final String mediaId;
  final String mediaType;
  const MediaViewerPage({
    super.key,
    required this.mediaId,
    required this.mediaType,
  });
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class SearchResultsPage extends StatelessWidget {
  final String query;
  const SearchResultsPage({super.key, required this.query});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class ErrorPage extends StatelessWidget {
  final String? error;
  const ErrorPage({super.key, this.error});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class OfflinePage extends StatelessWidget {
  const OfflinePage({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder();
}
