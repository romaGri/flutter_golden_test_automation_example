import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/moon_phase.dart';
import 'moon_rituals_state.dart';

class MoonRitualsCubit extends Cubit<MoonRitualsState> {
  MoonRitualsCubit() : super(const MoonRitualsInitial());

  static const _rituals = [
    MoonRitual(
      phase: MoonPhase.newMoon,
      illumination: 0.0,
      title: 'New Moon',
      doList: [
        'Set clear intentions and write them down',
        'Start a new project or habit',
        'Meditate on what you want to manifest',
      ],
      avoidList: [
        'Making major decisions under pressure',
        'Spreading energy too thin',
        'Focusing on what you lack',
      ],
    ),
    MoonRitual(
      phase: MoonPhase.waxingCrescent,
      illumination: 0.25,
      title: 'Waxing Crescent',
      doList: [
        'Take the first concrete steps toward your goals',
        'Gather resources and information',
        'Build momentum with small daily actions',
      ],
      avoidList: [
        'Second-guessing your intentions',
        'Taking on too many tasks at once',
        'Skipping rest when energy dips',
      ],
    ),
    MoonRitual(
      phase: MoonPhase.firstQuarter,
      illumination: 0.5,
      title: 'First Quarter',
      doList: [
        'Push through challenges and obstacles',
        'Make confident decisions',
        'Take bold action on your plans',
      ],
      avoidList: [
        'Giving up when resistance appears',
        'Procrastinating on tough choices',
        'Ignoring your body\'s signals',
      ],
    ),
    MoonRitual(
      phase: MoonPhase.waxingGibbous,
      illumination: 0.75,
      title: 'Waxing Gibbous',
      doList: [
        'Refine and adjust your approach',
        'Be patient — results are almost here',
        'Visualize successful outcomes',
      ],
      avoidList: [
        'Rushing to completion prematurely',
        'Abandoning plans that just need tweaking',
        'Neglecting gratitude for progress made',
      ],
    ),
    MoonRitual(
      phase: MoonPhase.fullMoon,
      illumination: 1.0,
      title: 'Full Moon',
      doList: [
        'Celebrate your achievements',
        'Release what no longer serves you',
        'Connect with others and share energy',
      ],
      avoidList: [
        'Starting new major projects',
        'Making impulsive emotional decisions',
        'Over-exerting your energy',
      ],
    ),
    MoonRitual(
      phase: MoonPhase.waningGibbous,
      illumination: 0.75,
      title: 'Waning Gibbous',
      doList: [
        'Share your knowledge and wisdom',
        'Express gratitude for what you have',
        'Teach, mentor, or give back',
      ],
      avoidList: [
        'Holding onto grudges',
        'Accumulating new possessions',
        'Isolating yourself from community',
      ],
    ),
    MoonRitual(
      phase: MoonPhase.lastQuarter,
      illumination: 0.5,
      title: 'Last Quarter',
      doList: [
        'Forgive yourself and others',
        'Clear out physical and mental clutter',
        'Reflect on lessons learned',
      ],
      avoidList: [
        'Starting new commitments',
        'Forcing outcomes that aren\'t ready',
        'Dwelling on past mistakes',
      ],
    ),
    MoonRitual(
      phase: MoonPhase.waningCrescent,
      illumination: 0.25,
      title: 'Waning Crescent',
      doList: [
        'Rest and restore your energy',
        'Spend time in quiet reflection',
        'Prepare your space for the new cycle',
      ],
      avoidList: [
        'Overworking or pushing hard',
        'Ignoring your need for sleep',
        'Resisting the natural slowdown',
      ],
    ),
  ];

  void loadRituals() {
    emit(const MoonRitualsLoading());
    emit(const MoonRitualsLoaded(_rituals));
  }
}
