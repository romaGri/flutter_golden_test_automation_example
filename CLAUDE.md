.# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
flutter run                          # run app (picks available device)
flutter run -d macos                 # run on macOS
flutter analyze                      # lint
dart format lib/ test/               # format
flutter test                         # all tests
flutter test test/path/to_test.dart  # single file
flutter test --update-goldens        # regenerate golden baselines
```

## Architecture

Lunar calendar app — example project for an article on automating Flutter golden tests. Stack: go_router + flutter_bloc + clean architecture + get_it DI.

```
lib/
├── main.dart                        # configureDependencies() → runApp(App())
├── app.dart                         # MaterialApp.router, SettingsCubit above router
├── core/
│   ├── di/injection.dart            # GetIt sl, configureDependencies()
│   ├── router/app_router.dart       # GoRouter + AppRoutes constants
│   ├── theme/app_theme.dart         # AppTheme.light / AppTheme.dark
│   └── utils/moon_calculator.dart   # pure static lunar math
├── domain/
│   ├── entities/                    # MoonPhase (enum), MoonDay, MoonCalendar
│   │                                # moon_phase_extensions.dart → .label
│   ├── repositories/moon_repository.dart   # abstract
│   └── usecases/                    # GetTodayMoon, GetDayMoon, GetMonthCalendar
├── data/
│   ├── datasources/moon_local_datasource.dart   # calls MoonCalculator
│   └── repositories/moon_repository_impl.dart
└── presentation/
    ├── widgets/moon_phase_icon.dart  # shared CustomPainter widget
    ├── home/                         # HomeBloc, HomePage
    ├── calendar/                     # CalendarBloc, CalendarPage
    ├── day_detail/                   # DayDetailBloc, DayDetailPage
    └── settings/                     # SettingsCubit, SettingsPage
```

**Routes:** `/` → Home, `/calendar` → Calendar, `/day/:date` → DayDetail, `/settings` → Settings  
**Date path format:** `AppRoutes.dayDetailPath(date)` → `/day/2025-05-06`

### DI conventions

- `MoonRepository`, datasource, use cases → `registerLazySingleton`
- `HomeBloc`, `CalendarBloc`, `DayDetailBloc` → `registerFactory` (fresh instance per page)
- `SettingsCubit` → `registerLazySingleton` (global theme, lives above `MaterialApp`)

Each page provides its own BLoC: `BlocProvider(create: (_) => sl<HomeBloc>()..add(...))`.

### MoonCalculator

Pure static methods, no external deps — deterministic for any `DateTime`.

- `calculateDay(date)` → `MoonDay`
- `getMoonAge(date)` → days since new moon (0..29.53)
- `getIllumination(date)` → 0.0..1.0 (cosine formula)
- `getPhase(date)` → `MoonPhase` (8 equal buckets of synodic month)

Reference new moon: 2000-01-06 (JD 2451550.1), synodic month = 29.53058867 days.

### MoonPhaseIcon

`presentation/widgets/moon_phase_icon.dart` — `CustomPainter` that draws the lit/shadow portions using `Path.combine`:
- Crescent: `PathOperation.union` (shadow semicircle ∪ terminator ellipse)
- Gibbous: `PathOperation.difference` (shadow semicircle − terminator ellipse)
- Clips to moon circle via `canvas.clipPath`. Theme-aware colors.

### BLoC state pattern

All BLoCs use `sealed class` states extending `Equatable`:
`Initial → Loading → Loaded(data) | Error(message)`  
Events use `sealed class` without Equatable (no equality needed).

### Golden Tests

- Baselines in `test/goldens/`
- `MoonCalculator` is deterministic → pass fixed `DateTime` directly, no mocking needed
- Goldens are platform-specific — CI must match the platform used to generate baselines

### Linting

`package:flutter_lints/flutter.yaml` (standard Flutter rules).
