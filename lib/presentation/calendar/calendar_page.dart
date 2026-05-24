import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/injection.dart';
import '../../core/l10n/app_localizations_extension.dart';
import '../../core/router/app_router.dart';
import '../../domain/entities/moon_calendar.dart';
import '../../domain/entities/moon_day.dart';
import '../widgets/moon_phase_icon.dart';
import 'bloc/calendar_bloc.dart';
import 'bloc/calendar_event.dart';
import 'bloc/calendar_state.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return BlocProvider(
      create: (_) =>
          sl<CalendarBloc>()
            ..add(CalendarMonthLoadRequested(year: now.year, month: now.month)),
      child: const _CalendarView(),
    );
  }
}

class _CalendarView extends StatelessWidget {
  const _CalendarView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.S;
    final weekdays = [
      l10n.calendarWeekdayMon,
      l10n.calendarWeekdayTue,
      l10n.calendarWeekdayWed,
      l10n.calendarWeekdayThu,
      l10n.calendarWeekdayFri,
      l10n.calendarWeekdaySat,
      l10n.calendarWeekdaySun,
    ];
    return Scaffold(
      appBar: AppBar(title: Text(l10n.pageCalendarTitle)),
      body: BlocBuilder<CalendarBloc, CalendarState>(
        builder: (context, state) => switch (state) {
          CalendarInitial() ||
          CalendarLoading() => const Center(child: CircularProgressIndicator()),
          CalendarLoaded(:final calendar) => Column(
            children: [
              _MonthHeader(calendar: calendar),
              _WeekdayRow(weekdays: weekdays),
              Expanded(child: _CalendarGrid(calendar: calendar)),
            ],
          ),
          CalendarError(:final message) => Center(
            child: Text(context.S.errorMessage(message)),
          ),
        },
      ),
    );
  }
}

class _MonthHeader extends StatelessWidget {
  final MoonCalendar calendar;

  const _MonthHeader({required this.calendar});

  String _monthName(BuildContext context, int month) {
    final l10n = context.S;
    return [
      l10n.calendarMonthJanuary,
      l10n.calendarMonthFebruary,
      l10n.calendarMonthMarch,
      l10n.calendarMonthApril,
      l10n.calendarMonthMay,
      l10n.calendarMonthJune,
      l10n.calendarMonthJuly,
      l10n.calendarMonthAugust,
      l10n.calendarMonthSeptember,
      l10n.calendarMonthOctober,
      l10n.calendarMonthNovember,
      l10n.calendarMonthDecember,
    ][month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => context.read<CalendarBloc>().add(
              const CalendarPreviousMonthRequested(),
            ),
          ),
          Text(
            '${_monthName(context, calendar.month)} ${calendar.year}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () => context.read<CalendarBloc>().add(
              const CalendarNextMonthRequested(),
            ),
          ),
        ],
      ),
    );
  }
}

class _WeekdayRow extends StatelessWidget {
  final List<String> weekdays;

  const _WeekdayRow({required this.weekdays});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: weekdays
          .map(
            (d) => Expanded(
              child: Center(
                child: Text(
                  d,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _CalendarGrid extends StatelessWidget {
  final MoonCalendar calendar;

  const _CalendarGrid({required this.calendar});

  @override
  Widget build(BuildContext context) {
    // weekday of the 1st day (1=Mon..7=Sun in ISO)
    final firstWeekday = DateTime(calendar.year, calendar.month, 1).weekday;
    final leadingBlanks = firstWeekday - 1;
    final totalCells = leadingBlanks + calendar.days.length;
    final rowCount = (totalCells / 7).ceil();

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 0.8,
      ),
      itemCount: rowCount * 7,
      itemBuilder: (context, index) {
        final dayIndex = index - leadingBlanks;
        if (dayIndex < 0 || dayIndex >= calendar.days.length) {
          return const SizedBox.shrink();
        }
        return _DayCell(moonDay: calendar.days[dayIndex]);
      },
    );
  }
}

class _DayCell extends StatelessWidget {
  final MoonDay moonDay;

  const _DayCell({required this.moonDay});

  @override
  Widget build(BuildContext context) {
    final isToday = _isToday(moonDay.date);
    return InkWell(
      onTap: () => context.push(AppRoutes.dayDetailPath(moonDay.date)),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MoonPhaseIcon(
              phase: moonDay.phase,
              illumination: moonDay.illumination,
              size: 28,
            ),
            const SizedBox(height: 2),
            Container(
              width: 22,
              height: 22,
              decoration: isToday
                  ? BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    )
                  : null,
              child: Center(
                child: Text(
                  '${moonDay.date.day}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isToday
                        ? Theme.of(context).colorScheme.onPrimary
                        : null,
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}
