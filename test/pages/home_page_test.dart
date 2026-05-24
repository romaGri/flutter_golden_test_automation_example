import 'package:alchemist/alchemist.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_golden_test_automation_example/core/di/injection.dart';
import 'package:flutter_golden_test_automation_example/core/theme/app_theme.dart';
import 'package:flutter_golden_test_automation_example/domain/entities/moon_day.dart';
import 'package:flutter_golden_test_automation_example/domain/entities/moon_phase.dart';
import 'package:flutter_golden_test_automation_example/l10n/app_localizations.dart';
import 'package:flutter_golden_test_automation_example/presentation/home/bloc/home_bloc.dart';
import 'package:flutter_golden_test_automation_example/presentation/home/bloc/home_event.dart';
import 'package:flutter_golden_test_automation_example/presentation/home/bloc/home_state.dart';
import 'package:flutter_golden_test_automation_example/presentation/home/home_page.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

void main() {
  final moonDay = MoonDay(
    date: DateTime(2025, 1, 6),
    phase: MoonPhase.newMoon,
    illumination: 0.0,
    ageInDays: 0.0,
  );

  Widget wrapScenario(Widget child, {ThemeData? theme}) => SizedBox(
    width: 390,
    height: 844,
    child: MaterialApp(
      theme: theme ?? AppTheme.light,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: child,
    ),
  );

  group('HomePage', () {
    late MockHomeBloc mockBloc;

    setUp(() {
      mockBloc = MockHomeBloc();
      if (sl.isRegistered<HomeBloc>()) sl.unregister<HomeBloc>();
      sl.registerFactory<HomeBloc>(() => mockBloc);
    });

    tearDown(() {
      if (sl.isRegistered<HomeBloc>()) sl.unregister<HomeBloc>();
    });

    goldenTest(
      'renders loading state',
      fileName: 'pages/home_page_loading',
      pumpBeforeTest: (tester) => tester.pump(),
      builder: () {
        when(() => mockBloc.state).thenReturn(const HomeLoading());
        when(() => mockBloc.stream)
            .thenAnswer((_) => Stream<HomeState>.empty());
        return GoldenTestGroup(
          children: [
            GoldenTestScenario(
              name: 'light theme',
              child: wrapScenario(const HomePage()),
            ),
            GoldenTestScenario(
              name: 'dark theme',
              child: wrapScenario(const HomePage(), theme: AppTheme.dark),
            ),
          ],
        );
      },
    );

    goldenTest(
      'renders loaded state',
      fileName: 'pages/home_page_loaded',
      builder: () {
        when(() => mockBloc.state).thenReturn(HomeLoaded(moonDay));
        when(() => mockBloc.stream)
            .thenAnswer((_) => Stream.value(HomeLoaded(moonDay)));
        return GoldenTestGroup(
          children: [
            GoldenTestScenario(
              name: 'light theme',
              child: wrapScenario(const HomePage()),
            ),
            GoldenTestScenario(
              name: 'dark theme',
              child: wrapScenario(const HomePage(), theme: AppTheme.dark),
            ),
          ],
        );
      },
    );

    goldenTest(
      'renders error state',
      fileName: 'pages/home_page_error',
      builder: () {
        when(() => mockBloc.state)
            .thenReturn(const HomeError('Something went wrong'));
        when(() => mockBloc.stream)
            .thenAnswer((_) => Stream<HomeState>.empty());
        return GoldenTestGroup(
          children: [
            GoldenTestScenario(
              name: 'light theme',
              child: wrapScenario(const HomePage()),
            ),
            GoldenTestScenario(
              name: 'dark theme',
              child: wrapScenario(const HomePage(), theme: AppTheme.dark),
            ),
          ],
        );
      },
    );
  });
}
