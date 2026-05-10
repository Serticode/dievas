import 'package:flutter/widgets.dart';

import '../../theme/dievas_theme.dart';

/// Orientation of [DievasDivider].
enum DievasDividerOrientation {
  /// Full-width horizontal rule.
  horizontal,

  /// Full-height vertical rule.
  vertical,
}

/// A thin hairline rule that separates content regions.
///
/// Automatically uses `colors.border.borderDefault` and `border.strokeThin`
/// from the active [DievasTheme].
///
/// Moon reference: Divider
///
/// ```dart
/// const DievasDivider()
/// const DievasDivider(orientation: DievasDividerOrientation.vertical)
/// const DievasDivider(indent: 16, endIndent: 16)
/// ```
class DievasDivider extends StatelessWidget {
  const DievasDivider({super.key, this.orientation = .horizontal, this.indent = 0, this.endIndent = 0});

  final DievasDividerOrientation orientation;

  /// Leading inset before the line starts (dp).
  final double indent;

  /// Trailing inset after the line ends (dp).
  final double endIndent;

  @override
  Widget build(BuildContext context) {
    final colors = DievasTheme.colorsOf(context);
    final border = DievasTheme.borderOf(context);

    final color = colors.border.borderDefault;
    final thickness = border.strokeThin;

    return switch (orientation) {
      DievasDividerOrientation.horizontal => Container(
        height: thickness,
        margin: EdgeInsets.only(left: indent, right: endIndent),
        color: color,
      ),
      DievasDividerOrientation.vertical => Container(
        width: thickness,
        margin: EdgeInsets.only(top: indent, bottom: endIndent),
        color: color,
      ),
    };
  }
}
