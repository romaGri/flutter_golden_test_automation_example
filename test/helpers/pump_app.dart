import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_golden_test_automation_example/core/theme/app_theme.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget, {ThemeData? theme}) =>
      pumpWidget(
        MaterialApp(
          theme: theme ?? AppTheme.light,
          home: widget,
        ),
      );
}
