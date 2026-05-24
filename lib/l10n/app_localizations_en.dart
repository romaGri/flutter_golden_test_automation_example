// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Moon Calendar';

  @override
  String get pageHomeTitle => 'Moon Calendar';

  @override
  String get pageCalendarTitle => 'Calendar';

  @override
  String get pageSettingsTitle => 'Settings';

  @override
  String get tooltipCalendar => 'Calendar';

  @override
  String get tooltipSettings => 'Settings';

  @override
  String get settingsDarkMode => 'Dark mode';

  @override
  String get settingsDarkModeSubtitle => 'Switch between light and dark theme';

  @override
  String homeDayOf30(int day) {
    return 'Day $day of 30';
  }

  @override
  String homeIllumination(int percent) {
    return 'Illumination: $percent%';
  }

  @override
  String errorMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get dayDetailLabelPhase => 'Phase';

  @override
  String get dayDetailLabelIllumination => 'Illumination';

  @override
  String get dayDetailLabelMoonAge => 'Moon age';

  @override
  String get dayDetailLabelLunarDay => 'Lunar day';

  @override
  String dayDetailMoonAgeDays(String days) {
    return '$days days';
  }

  @override
  String dayDetailLunarDayOf30(int day) {
    return '$day of 30';
  }

  @override
  String get calendarMonthJanuary => 'January';

  @override
  String get calendarMonthFebruary => 'February';

  @override
  String get calendarMonthMarch => 'March';

  @override
  String get calendarMonthApril => 'April';

  @override
  String get calendarMonthMay => 'May';

  @override
  String get calendarMonthJune => 'June';

  @override
  String get calendarMonthJuly => 'July';

  @override
  String get calendarMonthAugust => 'August';

  @override
  String get calendarMonthSeptember => 'September';

  @override
  String get calendarMonthOctober => 'October';

  @override
  String get calendarMonthNovember => 'November';

  @override
  String get calendarMonthDecember => 'December';

  @override
  String get calendarWeekdayMon => 'Mo';

  @override
  String get calendarWeekdayTue => 'Tu';

  @override
  String get calendarWeekdayWed => 'We';

  @override
  String get calendarWeekdayThu => 'Th';

  @override
  String get calendarWeekdayFri => 'Fr';

  @override
  String get calendarWeekdaySat => 'Sa';

  @override
  String get calendarWeekdaySun => 'Su';

  @override
  String get moonPhaseNewMoon => 'New Moon';

  @override
  String get moonPhaseWaxingCrescent => 'Waxing Crescent';

  @override
  String get moonPhaseFirstQuarter => 'First Quarter';

  @override
  String get moonPhaseWaxingGibbous => 'Waxing Gibbous';

  @override
  String get moonPhaseFullMoon => 'Full Moon';

  @override
  String get moonPhaseWaningGibbous => 'Waning Gibbous';

  @override
  String get moonPhaseLastQuarter => 'Last Quarter';

  @override
  String get moonPhaseWaningCrescent => 'Waning Crescent';
}
