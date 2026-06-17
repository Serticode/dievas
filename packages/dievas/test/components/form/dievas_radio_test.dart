import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _harness(Widget child) => DievasScope(
  lightTheme: DievasLightThemeData(),
  darkTheme: DievasDarkThemeData(),
  child: MaterialApp(home: Scaffold(body: child)),
);

void main() {
  group('DievasRadio', () {
    testWidgets('renders unselected without throwing', (tester) async {
      await tester.pumpWidget(_harness(
        const DievasRadio<String>(value: 'a', groupValue: 'b', onChanged: null),
      ));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders selected state', (tester) async {
      await tester.pumpWidget(_harness(
        DievasRadio<String>(value: 'a', groupValue: 'a', onChanged: (_) {}),
      ));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders with label', (tester) async {
      await tester.pumpWidget(_harness(
        const DievasRadio<String>(value: 'a', groupValue: 'a', onChanged: null, label: 'Option A'),
      ));
      expect(tester.takeException(), isNull);
      expect(find.text('Option A'), findsOneWidget);
    });

    testWidgets('fires onChanged with value on tap', (tester) async {
      String? result;
      await tester.pumpWidget(_harness(
        DievasRadio<String>(value: 'opt', groupValue: 'other', onChanged: (v) => result = v),
      ));
      await tester.tap(find.byType(DievasRadio<String>));
      expect(result, 'opt');
    });

    testWidgets('disabled when onChanged is null', (tester) async {
      await tester.pumpWidget(_harness(
        const DievasRadio<String>(value: 'a', groupValue: 'b', onChanged: null),
      ));
      expect(tester.takeException(), isNull);
    });
  });
}
