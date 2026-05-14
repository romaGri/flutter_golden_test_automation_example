import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/settings_cubit.dart';
import 'cubit/settings_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final isDark = state.themeMode == ThemeMode.dark;
          return ListView(
            children: [
              SwitchListTile(
                title: const Text('Dark mode'),
                subtitle: const Text('Switch between light and dark theme'),
                value: isDark,
                onChanged: (_) =>
                    context.read<SettingsCubit>().toggleTheme(),
              ),
            ],
          );
        },
      ),
    );
  }
}
