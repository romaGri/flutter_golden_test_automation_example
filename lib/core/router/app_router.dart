import 'package:go_router/go_router.dart';

import '../../presentation/calendar/calendar_page.dart';
import '../../presentation/day_detail/day_detail_page.dart';
import '../../presentation/home/home_page.dart';
import '../../presentation/settings/settings_page.dart';

abstract class AppRoutes {
  static const home = '/';
  static const calendar = '/calendar';
  static const dayDetail = '/day/:date';
  static const settings = '/settings';

  static String dayDetailPath(DateTime date) =>
      '/day/${date.toIso8601String().split('T').first}';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (_, _) => const HomePage(),
      routes: [
        GoRoute(
          path: AppRoutes.calendar,
          builder: (_, _) => const CalendarPage(),
        ),
        GoRoute(
          path: AppRoutes.dayDetail,
          builder: (context, state) {
            final dateStr = state.pathParameters['date']!;
            return DayDetailPage(date: DateTime.parse(dateStr));
          },
        ),
        GoRoute(
          path: AppRoutes.settings,
          builder: (_, _) => const SettingsPage(),
        ),
      ],
    ),
  ],
);
