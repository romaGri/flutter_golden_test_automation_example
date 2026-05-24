import 'package:alchemist/alchemist.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_golden_test_automation_example/core/di/injection.dart';
import 'package:flutter_golden_test_automation_example/core/theme/app_theme.dart';
import 'package:flutter_golden_test_automation_example/domain/entities/moon_calendar.dart';
import 'package:flutter_golden_test_automation_example/domain/entities/moon_day.dart';
import 'package:flutter_golden_test_automation_example/domain/entities/moon_phase.dart';
import 'package:flutter_golden_test_automation_example/l10n/app_localizations.dart';
import 'package:flutter_golden_test_automation_example/presentation/calendar/bloc/calendar_bloc.dart';
import 'package:flutter_golden_test_automation_example/presentation/calendar/bloc/calendar_event.dart';
import 'package:flutter_golden_test_automation_example/presentation/calendar/bloc/calendar_state.dart';
import 'package:flutter_golden_test_automation_example/presentation/calendar/calendar_page.dart';

class MockCalendarBloc extends MockBloc<CalendarEvent, CalendarState>
    implements CalendarBloc {}

void main() {
  final days = List.generate(
    31,
    (i) => MoonDay(
      date: DateTime(2025, 1, i + 1),
      phase: MoonPhase.values[i % MoonPhase.values.length],
      illumination: (i % 10) / 10.0,
      ageInDays: (i.toDouble() * 29.53 / 31),
    ),
  );
  final calendar = MoonCalendar(year: 2025, month: 1, days: days);

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

  group('CalendarPage', () {
    late MockCalendarBloc mockBloc;

    setUp(() {
      mockBloc = MockCalendarBloc();
      if (sl.isRegistered<CalendarBloc>()) sl.unregister<CalendarBloc>();
      sl.registerFactory<CalendarBloc>(() => mockBloc);
    });

    tearDown(() {
      if (sl.isRegistered<CalendarBloc>()) sl.unregister<CalendarBloc>();
    });

    goldenTest(
      'renders loading state',
      fileName: 'pages/calendar_page_loading',
      pumpBeforeTest: (tester) => tester.pump(),
      builder: () {
        when(() => mockBloc.state).thenReturn(const CalendarLoading());
        when(
          () => mockBloc.stream,
        ).thenAnswer((_) => Stream<CalendarState>.empty());
        return GoldenTestGroup(
          children: [
            GoldenTestScenario(
              name: 'light theme',
              child: wrapScenario(const CalendarPage()),
            ),
            GoldenTestScenario(
              name: 'dark theme',
              child: wrapScenario(const CalendarPage(), theme: AppTheme.dark),
            ),
          ],
        );
      },
    );

    goldenTest(
      'renders loaded state',
      fileName: 'pages/calendar_page_loaded',
      builder: () {
        when(() => mockBloc.state).thenReturn(CalendarLoaded(calendar));
        when(
          () => mockBloc.stream,
        ).thenAnswer((_) => Stream.value(CalendarLoaded(calendar)));
        return GoldenTestGroup(
          children: [
            GoldenTestScenario(
              name: 'light theme',
              child: wrapScenario(const CalendarPage()),
            ),
            GoldenTestScenario(
              name: 'dark theme',
              child: wrapScenario(const CalendarPage(), theme: AppTheme.dark),
            ),
          ],
        );
      },
    );

    goldenTest(
      'renders error state',
      fileName: 'pages/calendar_page_error',
      builder: () {
        when(
          () => mockBloc.state,
        ).thenReturn(const CalendarError('Something went wrong'));
        when(
          () => mockBloc.stream,
        ).thenAnswer((_) => Stream<CalendarState>.empty());
        return GoldenTestGroup(
          children: [
            GoldenTestScenario(
              name: 'light theme',
              child: wrapScenario(const CalendarPage()),
            ),
            GoldenTestScenario(
              name: 'dark theme',
              child: wrapScenario(const CalendarPage(), theme: AppTheme.dark),
            ),
          ],
        );
      },
    );
  });
}
