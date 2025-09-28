import 'package:dave_portfolio/features/landing_page/landing_page_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LandingPagePortfolio(),
    ),
  ],
);
