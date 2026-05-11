import 'package:flutter_test/flutter_test.dart';

import 'package:dievas_gallery/main.dart';

void main() {
  testWidgets('DievasGallery renders without throwing', (WidgetTester tester) async {
    await tester.pumpWidget(const DievasGallery());
    await tester.pump();
    expect(tester.takeException(), isNull);
  });
}
