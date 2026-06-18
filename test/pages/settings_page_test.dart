import 'package:alchemist/alchemist.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_golden_test_automation_example/core/theme/app_theme.dart';
import 'package:flutter_golden_test_automation_example/l10n/app_localizations.dart';
import 'package:flutter_golden_test_automation_example/presentation/settings/cubit/settings_cubit.dart';
import 'package:flutter_golden_test_automation_example/presentation/settings/cubit/settings_state.dart';
import 'package:flutter_golden_test_automation_example/presentation/settings/settings_page.dart';

class MockSettingsCubit extends MockCubit<SettingsState>
    implements SettingsCubit {}

void main() {
  Widget wrapScenario(MockSettingsCubit cubit, ThemeData theme) => SizedBox(
    width: 390,
    height: 844,
    child: MaterialApp(
      theme: theme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<SettingsCubit>.value(
        value: cubit,
        child: const SettingsPage(),
      ),
    ),
  );

  group('SettingsPage', () {
    late MockSettingsCubit mockCubit;

    setUp(() {
      mockCubit = MockSettingsCubit();
    });

    goldenTest(
      'renders light theme state',
      fileName: 'pages/settings_page_light',
      builder: () {
        when(
          () => mockCubit.state,
        ).thenReturn(const SettingsState(themeMode: ThemeMode.light));
        when(() => mockCubit.stream).thenAnswer(
          (_) => Stream.value(const SettingsState(themeMode: ThemeMode.light)),
        );
        return GoldenTestGroup(
          children: [
            GoldenTestScenario(
              name: 'light theme',
              child: wrapScenario(mockCubit, AppTheme.light),
            ),
          ],
        );
      },
    );

    goldenTest(
      'renders dark theme state',
      fileName: 'pages/settings_page_dark',
      builder: () {
        when(
          () => mockCubit.state,
        ).thenReturn(const SettingsState(themeMode: ThemeMode.dark));
        when(() => mockCubit.stream).thenAnswer(
          (_) => Stream.value(const SettingsState(themeMode: ThemeMode.dark)),
        );
        return GoldenTestGroup(
          children: [
            GoldenTestScenario(
              name: 'dark theme',
              child: wrapScenario(mockCubit, AppTheme.dark),
            ),
          ],
        );
      },
    );
  });
}
