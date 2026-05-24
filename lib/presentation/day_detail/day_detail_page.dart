import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/injection.dart';
import '../../core/l10n/app_localizations_extension.dart';
import '../l10n/moon_phase_l10n.dart';
import '../widgets/moon_phase_icon.dart';
import 'bloc/day_detail_bloc.dart';
import 'bloc/day_detail_event.dart';
import 'bloc/day_detail_state.dart';

class DayDetailPage extends StatelessWidget {
  final DateTime date;

  const DayDetailPage({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DayDetailBloc>()..add(DayDetailLoadRequested(date)),
      child: _DayDetailView(date: date),
    );
  }
}

class _DayDetailView extends StatelessWidget {
  final DateTime date;

  const _DayDetailView({required this.date});

  @override
  Widget build(BuildContext context) {
    final formatted =
        '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
    return Scaffold(
      appBar: AppBar(title: Text(formatted)),
      body: BlocBuilder<DayDetailBloc, DayDetailState>(
        builder: (context, state) => switch (state) {
          DayDetailInitial() || DayDetailLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
          DayDetailLoaded(:final moonDay) => Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: MoonPhaseIcon(
                    phase: moonDay.phase,
                    illumination: moonDay.illumination,
                    size: 220,
                  ),
                ),
                const SizedBox(height: 32),
                _InfoRow(
                  label: context.S.dayDetailLabelPhase,
                  value: moonDay.phase.localizedLabel(context),
                ),
                const Divider(),
                _InfoRow(
                  label: context.S.dayDetailLabelIllumination,
                  value: '${(moonDay.illumination * 100).round()}%',
                ),
                const Divider(),
                _InfoRow(
                  label: context.S.dayDetailLabelMoonAge,
                  value: context.S.dayDetailMoonAgeDays(
                    moonDay.ageInDays.toStringAsFixed(1),
                  ),
                ),
                const Divider(),
                _InfoRow(
                  label: context.S.dayDetailLabelLunarDay,
                  value: context.S.dayDetailLunarDayOf30(
                    moonDay.ageInDays.floor() + 1,
                  ),
                ),
              ],
            ),
          ),
          DayDetailError(:final message) => Center(
            child: Text(context.S.errorMessage(message)),
          ),
        },
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.titleMedium),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
