import 'package:go_router/go_router.dart';
import '../../features/bell/presentation/screens/dashboard_screen.dart';
import '../../features/bell/presentation/screens/schedules_screen.dart';
import 'route_names.dart';

final appRouter = GoRouter(
  initialLocation: RouteNames.dashboard,
  routes: [
    GoRoute(
      path: RouteNames.dashboard,
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: RouteNames.schedules,
      builder: (context, state) => const SchedulesScreen(),
    ),
  ],
);
