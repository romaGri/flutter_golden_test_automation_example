import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/injection.dart';
import 'cubit/moon_tips_cubit.dart';
import 'cubit/moon_tips_state.dart';

class MoonTipsPage extends StatelessWidget {
  const MoonTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MoonTipsCubit>()..loadTips(),
      child: const _MoonTipsView(),
    );
  }
}

class _MoonTipsView extends StatelessWidget {
  const _MoonTipsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Moon Tips')),
      body: BlocBuilder<MoonTipsCubit, MoonTipsState>(
        builder: (context, state) => switch (state) {
          MoonTipsInitial() ||
          MoonTipsLoading() => const Center(child: CircularProgressIndicator()),
          MoonTipsLoaded(:final tips) => ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: tips.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (_, index) => ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text(tips[index]),
            ),
          ),
          MoonTipsError(:final message) =>
            Center(child: Text('Error: $message')),
        },
      ),
    );
  }
}
