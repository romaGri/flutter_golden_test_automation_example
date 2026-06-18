import 'package:alchemist/alchemist.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_golden_test_automation_example/core/di/injection.dart';
import 'package:flutter_golden_test_automation_example/core/theme/app_theme.dart';
import 'package:flutter_golden_test_automation_example/l10n/app_localizations.dart';
import 'package:flutter_golden_test_automation_example/presentation/moon_tips/cubit/moon_tips_cubit.dart';
import 'package:flutter_golden_test_automation_example/presentation/moon_tips/cubit/moon_tips_state.dart';
import 'package:flutter_golden_test_automation_example/presentation/moon_tips/moon_tips_page.dart';

class MockMoonTipsCubit extends MockCubit<MoonTipsState>
    implements MoonTipsCubit {}

void main() {
  const tips = [
    'New Moon: best time for new beginnings and setting intentions.',
    'Waxing Crescent: take the first steps toward your goals.',
    'First Quarter: push through obstacles and make decisions.',
    'Full Moon: peak energy — celebrate progress and release what no longer serves you.',
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

  group('MoonTipsPage', () {
    late MockMoonTipsCubit mockCubit;

    setUp(() {
      mockCubit = MockMoonTipsCubit();
      if (sl.isRegistered<MoonTipsCubit>()) sl.unregister<MoonTipsCubit>();
      sl.registerFactory<MoonTipsCubit>(() => mockCubit);
    });

    tearDown(() {
      if (sl.isRegistered<MoonTipsCubit>()) sl.unregister<MoonTipsCubit>();
    });

    goldenTest(
      'renders loading state',
      fileName: 'pages/moon_tips_page_loading',
      pumpBeforeTest: (tester) => tester.pump(),
      builder: () {
        when(() => mockCubit.state).thenReturn(const MoonTipsLoading());
        when(
          () => mockCubit.stream,
        ).thenAnswer((_) => Stream<MoonTipsState>.empty());
        return GoldenTestGroup(
          children: [
            GoldenTestScenario(
              name: 'light theme',
              child: wrapScenario(const MoonTipsPage()),
            ),
            GoldenTestScenario(
              name: 'dark theme',
              child: wrapScenario(const MoonTipsPage(), theme: AppTheme.dark),
            ),
          ],
        );
      },
    );

    goldenTest(
      'renders loaded state',
      fileName: 'pages/moon_tips_page_loaded',
      builder: () {
        when(() => mockCubit.state).thenReturn(const MoonTipsLoaded(tips));
        when(
          () => mockCubit.stream,
        ).thenAnswer((_) => Stream.value(const MoonTipsLoaded(tips)));
        return GoldenTestGroup(
          children: [
            GoldenTestScenario(
              name: 'light theme',
              child: wrapScenario(const MoonTipsPage()),
            ),
            GoldenTestScenario(
              name: 'dark theme',
              child: wrapScenario(const MoonTipsPage(), theme: AppTheme.dark),
            ),
          ],
        );
      },
    );

    goldenTest(
      'renders error state',
      fileName: 'pages/moon_tips_page_error',
      builder: () {
        when(
          () => mockCubit.state,
        ).thenReturn(const MoonTipsError('Something went wrong'));
        when(
          () => mockCubit.stream,
        ).thenAnswer((_) => Stream<MoonTipsState>.empty());
        return GoldenTestGroup(
          children: [
            GoldenTestScenario(
              name: 'light theme',
              child: wrapScenario(const MoonTipsPage()),
            ),
            GoldenTestScenario(
              name: 'dark theme',
              child: wrapScenario(const MoonTipsPage(), theme: AppTheme.dark),
            ),
          ],
        );
      },
    );
  });
}
