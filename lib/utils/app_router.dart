import 'package:go_router/go_router.dart';
import 'package:ncss_code_club/views/about_view.dart';
import 'package:ncss_code_club/views/home_view.dart';

class AppRouter {
  static const String home = '/';
  static const String about = '/about';
  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(path: home, builder: (context, state) => const HomeView()),
      GoRoute(path: about, builder: (context, state) => const AboutView()),
    ],
  );
}
