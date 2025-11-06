import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ncss_code_club/features/about/presentation/views/about_view.dart';
import 'package:ncss_code_club/features/home/presentation/views/home_view.dart';

class AppRouter {
  static const String home = '/';
  static const String about = '/about';
  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: const HomeView(),
        ),
      ),
      GoRoute(
        path: about,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: const AboutView(),
        ),
      ),
    ],
  );
}

CustomTransitionPage buildPageWithFadeTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}
