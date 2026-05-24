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
import 'package:flutter_golden_test_automation_example/presentation/day_detail/bloc/day_detail_bloc.dart';
import 'package:flutter_golden_test_automation_example/presentation/day_detail/bloc/day_detail_event.dart';
import 'package:flutter_golden_test_automation_example/presentation/day_detail/bloc/day_detail_state.dart';
import 'package:flutter_golden_test_automation_example/presentation/day_detail/day_detail_page.dart';

class MockDayDetailBloc extends MockBloc<DayDetailEvent, DayDetailState>
    implements DayDetailBloc {}

void main() {
  final fixedDate = DateTime(2025, 1, 6);
  final moonDay = MoonDay(
    date: fixedDate,
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

  group('DayDetailPage', () {
    late MockDayDetailBloc mockBloc;

    setUp(() {
      mockBloc = MockDayDetailBloc();
      if (sl.isRegistered<DayDetailBloc>()) sl.unregister<DayDetailBloc>();
      sl.registerFactory<DayDetailBloc>(() => mockBloc);
    });

    tearDown(() {
      if (sl.isRegistered<DayDetailBloc>()) sl.unregister<DayDetailBloc>();
    });

    goldenTest(
      'renders loading state',
      fileName: 'pages/day_detail_page_loading',
      pumpBeforeTest: (tester) => tester.pump(),
      builder: () {
        when(() => mockBloc.state).thenReturn(const DayDetailLoading());
        when(
          () => mockBloc.stream,
        ).thenAnswer((_) => Stream<DayDetailState>.empty());
        return GoldenTestGroup(
          children: [
            GoldenTestScenario(
              name: 'light theme',
              child: wrapScenario(DayDetailPage(date: fixedDate)),
            ),
            GoldenTestScenario(
              name: 'dark theme',
              child: wrapScenario(
                DayDetailPage(date: fixedDate),
                theme: AppTheme.dark,
              ),
            ),
          ],
        );
      },
    );

    goldenTest(
      'renders loaded state',
      fileName: 'pages/day_detail_page_loaded',
      builder: () {
        when(() => mockBloc.state).thenReturn(DayDetailLoaded(moonDay));
        when(
          () => mockBloc.stream,
        ).thenAnswer((_) => Stream.value(DayDetailLoaded(moonDay)));
        return GoldenTestGroup(
          children: [
            GoldenTestScenario(
              name: 'light theme',
              child: wrapScenario(DayDetailPage(date: fixedDate)),
            ),
            GoldenTestScenario(
              name: 'dark theme',
              child: wrapScenario(
                DayDetailPage(date: fixedDate),
                theme: AppTheme.dark,
              ),
            ),
          ],
        );
      },
    );

    goldenTest(
      'renders error state',
      fileName: 'pages/day_detail_page_error',
      builder: () {
        when(
          () => mockBloc.state,
        ).thenReturn(const DayDetailError('Something went wrong'));
        when(
          () => mockBloc.stream,
        ).thenAnswer((_) => Stream<DayDetailState>.empty());
        return GoldenTestGroup(
          children: [
            GoldenTestScenario(
              name: 'light theme',
              child: wrapScenario(DayDetailPage(date: fixedDate)),
            ),
            GoldenTestScenario(
              name: 'dark theme',
              child: wrapScenario(
                DayDetailPage(date: fixedDate),
                theme: AppTheme.dark,
              ),
            ),
          ],
        );
      },
    );
  });
}
