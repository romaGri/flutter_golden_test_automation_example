import 'package:alchemist/alchemist.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_golden_test_automation_example/core/di/injection.dart';
import 'package:flutter_golden_test_automation_example/core/theme/app_theme.dart';
import 'package:flutter_golden_test_automation_example/domain/entities/moon_phase.dart';
import 'package:flutter_golden_test_automation_example/l10n/app_localizations.dart';
import 'package:flutter_golden_test_automation_example/presentation/moon_rituals/cubit/moon_rituals_cubit.dart';
import 'package:flutter_golden_test_automation_example/presentation/moon_rituals/cubit/moon_rituals_state.dart';
import 'package:flutter_golden_test_automation_example/presentation/moon_rituals/moon_rituals_page.dart';

class MockMoonRitualsCubit extends MockCubit<MoonRitualsState>
    implements MoonRitualsCubit {}

void main() {
  const rituals = [
    MoonRitual(
      phase: MoonPhase.newMoon,
      illumination: 0.0,
      title: 'New Moon',
      doList: [
        'Set clear intentions and write them down',
        'Start a new project or habit',
        'Meditate on what you want to manifest',
      ],
      avoidList: [
        'Making major decisions under pressure',
        'Spreading energy too thin',
        'Focusing on what you lack',
      ],
    ),
    MoonRitual(
      phase: MoonPhase.fullMoon,
      illumination: 1.0,
      title: 'Full Moon',
      doList: [
        'Celebrate your achievements',
        'Release what no longer serves you',
        'Connect with others and share energy',
      ],
      avoidList: [
        'Starting new major projects',
        'Making impulsive emotional decisions',
        'Over-exerting your energy',
      ],
    ),
  ];

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

  group('MoonRitualsPage', () {
    late MockMoonRitualsCubit mockCubit;

    setUp(() {
      mockCubit = MockMoonRitualsCubit();
      if (sl.isRegistered<MoonRitualsCubit>()) {
        sl.unregister<MoonRitualsCubit>();
      }
      sl.registerFactory<MoonRitualsCubit>(() => mockCubit);
    });

    tearDown(() {
      if (sl.isRegistered<MoonRitualsCubit>()) {
        sl.unregister<MoonRitualsCubit>();
      }
    });

    goldenTest(
      'renders loading state',
      fileName: 'pages/moon_rituals_page_loading',
      pumpBeforeTest: (tester) => tester.pump(),
      builder: () {
        when(() => mockCubit.state).thenReturn(const MoonRitualsLoading());
        when(
          () => mockCubit.stream,
        ).thenAnswer((_) => Stream<MoonRitualsState>.empty());
        return GoldenTestGroup(
          children: [
            GoldenTestScenario(
              name: 'light theme',
              child: wrapScenario(const MoonRitualsPage()),
            ),
            GoldenTestScenario(
              name: 'dark theme',
              child: wrapScenario(
                const MoonRitualsPage(),
                theme: AppTheme.dark,
              ),
            ),
          ],
        );
      },
    );

    goldenTest(
      'renders loaded state',
      fileName: 'pages/moon_rituals_page_loaded',
      builder: () {
        when(
          () => mockCubit.state,
        ).thenReturn(const MoonRitualsLoaded(rituals));
        when(
          () => mockCubit.stream,
        ).thenAnswer((_) => Stream.value(const MoonRitualsLoaded(rituals)));
        return GoldenTestGroup(
          children: [
            GoldenTestScenario(
              name: 'light theme',
              child: wrapScenario(const MoonRitualsPage()),
            ),
            GoldenTestScenario(
              name: 'dark theme',
              child: wrapScenario(
                const MoonRitualsPage(),
                theme: AppTheme.dark,
              ),
            ),
          ],
        );
      },
    );

    goldenTest(
      'renders error state',
      fileName: 'pages/moon_rituals_page_error',
      builder: () {
        when(
          () => mockCubit.state,
        ).thenReturn(const MoonRitualsError('Something went wrong'));
        when(
          () => mockCubit.stream,
        ).thenAnswer((_) => Stream<MoonRitualsState>.empty());
        return GoldenTestGroup(
          children: [
            GoldenTestScenario(
              name: 'light theme',
              child: wrapScenario(const MoonRitualsPage()),
            ),
            GoldenTestScenario(
              name: 'dark theme',
              child: wrapScenario(
                const MoonRitualsPage(),
                theme: AppTheme.dark,
              ),
            ),
          ],
        );
      },
    );
  });
}
