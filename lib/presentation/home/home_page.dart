import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/injection.dart';
import '../../core/l10n/app_localizations_extension.dart';
import '../../core/router/app_router.dart';
import '../l10n/moon_phase_l10n.dart';
import '../widgets/moon_phase_icon.dart';
import 'bloc/home_bloc.dart';
import 'bloc/home_event.dart';
import 'bloc/home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeBloc>()..add(const HomeMoonLoadRequested()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.S.pageHomeTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            tooltip: context.S.tooltipCalendar,
            onPressed: () => context.go(AppRoutes.calendar),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: context.S.tooltipSettings,
            onPressed: () => context.go(AppRoutes.settings),
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) => switch (state) {
          HomeInitial() ||
          HomeLoading() => const Center(child: CircularProgressIndicator()),
          HomeLoaded(:final moonDay) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MoonPhaseIcon(
                  phase: moonDay.phase,
                  illumination: moonDay.illumination,
                  size: 200,
                ),
                const SizedBox(height: 24),
                Text(
                  moonDay.phase.localizedLabel(context),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  context.S.homeDayOf30(moonDay.ageInDays.floor() + 1),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  context.S.homeIllumination(
                    (moonDay.illumination * 100).round(),
                  ),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          HomeError(:final message) => Center(
            child: Text(context.S.errorMessage(message)),
          ),
        },
      ),
    );
  }
}
