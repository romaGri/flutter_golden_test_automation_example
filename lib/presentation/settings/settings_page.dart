import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/l10n/app_localizations_extension.dart';
import 'cubit/settings_cubit.dart';
import 'cubit/settings_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.S.pageSettingsTitle)),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final isDark = state.themeMode == ThemeMode.dark;
          return ListView(
            children: [
              SwitchListTile(
                title: Text(context.S.settingsDarkMode),
                subtitle: Text(context.S.settingsDarkModeSubtitle),
                value: isDark,
                onChanged: (_) => context.read<SettingsCubit>().toggleTheme(),
              ),
            ],
          );
        },
      ),
    );
  }
}
