import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Moon Calendar'**
  String get appTitle;

  /// No description provided for @pageHomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Moon Calendar'**
  String get pageHomeTitle;

  /// No description provided for @pageCalendarTitle.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get pageCalendarTitle;

  /// No description provided for @pageSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get pageSettingsTitle;

  /// No description provided for @tooltipCalendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get tooltipCalendar;

  /// No description provided for @tooltipSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get tooltipSettings;

  /// No description provided for @settingsDarkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get settingsDarkMode;

  /// No description provided for @settingsDarkModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Switch between light and dark theme'**
  String get settingsDarkModeSubtitle;

  /// No description provided for @homeDayOf30.
  ///
  /// In en, this message translates to:
  /// **'Day {day} of 30'**
  String homeDayOf30(int day);

  /// No description provided for @homeIllumination.
  ///
  /// In en, this message translates to:
  /// **'Illumination: {percent}%'**
  String homeIllumination(int percent);

  /// No description provided for @errorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String errorMessage(String message);

  /// No description provided for @dayDetailLabelPhase.
  ///
  /// In en, this message translates to:
  /// **'Phase'**
  String get dayDetailLabelPhase;

  /// No description provided for @dayDetailLabelIllumination.
  ///
  /// In en, this message translates to:
  /// **'Illumination'**
  String get dayDetailLabelIllumination;

  /// No description provided for @dayDetailLabelMoonAge.
  ///
  /// In en, this message translates to:
  /// **'Moon age'**
  String get dayDetailLabelMoonAge;

  /// No description provided for @dayDetailLabelLunarDay.
  ///
  /// In en, this message translates to:
  /// **'Lunar day'**
  String get dayDetailLabelLunarDay;

  /// No description provided for @dayDetailMoonAgeDays.
  ///
  /// In en, this message translates to:
  /// **'{days} days'**
  String dayDetailMoonAgeDays(String days);

  /// No description provided for @dayDetailLunarDayOf30.
  ///
  /// In en, this message translates to:
  /// **'{day} of 30'**
  String dayDetailLunarDayOf30(int day);

  /// No description provided for @calendarMonthJanuary.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get calendarMonthJanuary;

  /// No description provided for @calendarMonthFebruary.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get calendarMonthFebruary;

  /// No description provided for @calendarMonthMarch.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get calendarMonthMarch;

  /// No description provided for @calendarMonthApril.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get calendarMonthApril;

  /// No description provided for @calendarMonthMay.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get calendarMonthMay;

  /// No description provided for @calendarMonthJune.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get calendarMonthJune;

  /// No description provided for @calendarMonthJuly.
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get calendarMonthJuly;

  /// No description provided for @calendarMonthAugust.
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get calendarMonthAugust;

  /// No description provided for @calendarMonthSeptember.
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get calendarMonthSeptember;

  /// No description provided for @calendarMonthOctober.
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get calendarMonthOctober;

  /// No description provided for @calendarMonthNovember.
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get calendarMonthNovember;

  /// No description provided for @calendarMonthDecember.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get calendarMonthDecember;

  /// No description provided for @calendarWeekdayMon.
  ///
  /// In en, this message translates to:
  /// **'Mo'**
  String get calendarWeekdayMon;

  /// No description provided for @calendarWeekdayTue.
  ///
  /// In en, this message translates to:
  /// **'Tu'**
  String get calendarWeekdayTue;

  /// No description provided for @calendarWeekdayWed.
  ///
  /// In en, this message translates to:
  /// **'We'**
  String get calendarWeekdayWed;

  /// No description provided for @calendarWeekdayThu.
  ///
  /// In en, this message translates to:
  /// **'Th'**
  String get calendarWeekdayThu;

  /// No description provided for @calendarWeekdayFri.
  ///
  /// In en, this message translates to:
  /// **'Fr'**
  String get calendarWeekdayFri;

  /// No description provided for @calendarWeekdaySat.
  ///
  /// In en, this message translates to:
  /// **'Sa'**
  String get calendarWeekdaySat;

  /// No description provided for @calendarWeekdaySun.
  ///
  /// In en, this message translates to:
  /// **'Su'**
  String get calendarWeekdaySun;

  /// No description provided for @moonPhaseNewMoon.
  ///
  /// In en, this message translates to:
  /// **'New Moon'**
  String get moonPhaseNewMoon;

  /// No description provided for @moonPhaseWaxingCrescent.
  ///
  /// In en, this message translates to:
  /// **'Waxing Crescent'**
  String get moonPhaseWaxingCrescent;

  /// No description provided for @moonPhaseFirstQuarter.
  ///
  /// In en, this message translates to:
  /// **'First Quarter'**
  String get moonPhaseFirstQuarter;

  /// No description provided for @moonPhaseWaxingGibbous.
  ///
  /// In en, this message translates to:
  /// **'Waxing Gibbous'**
  String get moonPhaseWaxingGibbous;

  /// No description provided for @moonPhaseFullMoon.
  ///
  /// In en, this message translates to:
  /// **'Full Moon'**
  String get moonPhaseFullMoon;

  /// No description provided for @moonPhaseWaningGibbous.
  ///
  /// In en, this message translates to:
  /// **'Waning Gibbous'**
  String get moonPhaseWaningGibbous;

  /// No description provided for @moonPhaseLastQuarter.
  ///
  /// In en, this message translates to:
  /// **'Last Quarter'**
  String get moonPhaseLastQuarter;

  /// No description provided for @moonPhaseWaningCrescent.
  ///
  /// In en, this message translates to:
  /// **'Waning Crescent'**
  String get moonPhaseWaningCrescent;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
