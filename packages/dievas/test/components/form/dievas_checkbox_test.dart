import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _harness(Widget child) => DievasScope(
  lightTheme: DievasLightThemeData(),
  darkTheme: DievasDarkThemeData(),
  child: MaterialApp(home: Scaffold(body: child)),
);

void main() {
  group('DievasCheckbox', () {
    testWidgets('renders without throwing — unchecked', (tester) async {
      await tester.pumpWidget(_harness(const DievasCheckbox(value: DievasCheckboxValue.unchecked, onChanged: null)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders checked state', (tester) async {
      await tester.pumpWidget(_harness(DievasCheckbox(value: DievasCheckboxValue.checked, onChanged: (_) {})));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders indeterminate state', (tester) async {
      await tester.pumpWidget(_harness(DievasCheckbox(value: DievasCheckboxValue.indeterminate, onChanged: (_) {})));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders with label', (tester) async {
      await tester.pumpWidget(_harness(const DievasCheckbox(value: DievasCheckboxValue.checked, onChanged: null, label: 'Accept terms')));
      expect(tester.takeException(), isNull);
      expect(find.text('Accept terms'), findsOneWidget);
    });

    testWidgets('fires onChanged on tap', (tester) async {
      DievasCheckboxValue? result;
      await tester.pumpWidget(
        _harness(DievasCheckbox(value: DievasCheckboxValue.unchecked, onChanged: (v) => result = v)),
      );
      await tester.tap(find.byType(DievasCheckbox));
      expect(result, DievasCheckboxValue.checked);
    });

    testWidgets('disabled when onChanged is null', (tester) async {
      await tester.pumpWidget(_harness(const DievasCheckbox(value: DievasCheckboxValue.checked, onChanged: null)));
      expect(tester.takeException(), isNull);
    });
  });
}
