import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/injection.dart';
import '../widgets/moon_phase_icon.dart';
import 'cubit/moon_rituals_cubit.dart';
import 'cubit/moon_rituals_state.dart';

class MoonRitualsPage extends StatelessWidget {
  const MoonRitualsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MoonRitualsCubit>()..loadRituals(),
      child: const _MoonRitualsView(),
    );
  }
}

class _MoonRitualsView extends StatelessWidget {
  const _MoonRitualsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Moon Rituals')),
      body: BlocBuilder<MoonRitualsCubit, MoonRitualsState>(
        builder: (context, state) => switch (state) {
          MoonRitualsInitial() ||
          MoonRitualsLoading() => const Center(child: CircularProgressIndicator()),
          MoonRitualsLoaded(:final rituals) => ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: rituals.length,
            itemBuilder: (_, index) => _RitualCard(ritual: rituals[index]),
          ),
          MoonRitualsError(:final message) =>
            Center(child: Text('Error: $message')),
        },
      ),
    );
  }
}

class _RitualCard extends StatelessWidget {
  final MoonRitual ritual;

  const _RitualCard({required this.ritual});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                MoonPhaseIcon(phase: ritual.phase, illumination: ritual.illumination, size: 48),
                const SizedBox(width: 12),
                Text(
                  ritual.title,
                  style: theme.textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _Section(
              icon: Icons.check_circle_outline,
              color: Colors.green,
              label: 'Do',
              items: ritual.doList,
            ),
            const SizedBox(height: 12),
            _Section(
              icon: Icons.cancel_outlined,
              color: Colors.red,
              label: 'Avoid',
              items: ritual.avoidList,
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final List<String> items;

  const _Section({
    required this.icon,
    required this.color,
    required this.label,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 6),
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(color: color),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 4),
            child: Text('• $item', style: Theme.of(context).textTheme.bodyMedium),
          ),
        ),
      ],
    );
  }
}
