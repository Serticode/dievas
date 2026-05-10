import 'package:dievas/dievas.dart' show DievasColourThemeData;
import 'package:flutter/widgets.dart';

import '../../theme/dievas_theme.dart';

/// Visual style of [DievasTag].
enum DievasTagStyle {
  /// Solid background.
  filled,

  /// Tinted background — default.
  tinted,

  /// Border only, transparent background.
  outlined,
}

/// An interactive or read-only chip that can carry a label, a leading icon,
/// and an optional dismiss (×) affordance.
///
/// When [onPressed] is non-null the whole chip is tappable. When [onRemove]
/// is non-null a trailing ×-button is rendered.
///
/// Moon reference: Tag
///
/// ```dart
/// DievasTag(label: 'Flutter')
/// DievasTag(label: 'Active', style: .filled, leadingIcon: Icon(Icons.circle, size: 8))
/// DievasTag(label: 'Remove me', onRemove: () { ... })
/// DievasTag(label: 'Click me', onPressed: () { ... })
/// ```
class DievasTag extends StatelessWidget {
  const DievasTag({
    super.key,
    required this.label,
    this.style = DievasTagStyle.tinted,
    this.leadingIcon,
    this.onPressed,
    this.onRemove,
  });

  final String label;
  final DievasTagStyle style;

  /// Optional leading icon widget.
  final Widget? leadingIcon;

  /// Tap callback. `null` → non-interactive (static display).
  final VoidCallback? onPressed;

  /// Remove callback. Renders a dismiss (×) button when non-null.
  final VoidCallback? onRemove;

  // Resolves the (background, border, foreground) triple from the active
  // colour sub-system for the current style.
  ({Color background, Color border, Color foreground}) _appearance(_TagColors c) => switch (style) {
    DievasTagStyle.filled => (background: c.bgElevated, border: c.transparent, foreground: c.textPrimary),
    DievasTagStyle.tinted => (background: c.bgSubtle, border: c.transparent, foreground: c.textSecondary),
    DievasTagStyle.outlined => (background: c.transparent, border: c.borderDefault, foreground: c.textSecondary),
  };

  @override
  Widget build(BuildContext context) {
    final colors = DievasTheme.colorsOf(context);
    final theme = DievasTheme.componentsOf(context).tag;

    final c = _TagColors(colors);
    final appearance = _appearance(c);
    final hasBorder = appearance.border != c.transparent;

    Widget row = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leadingIcon != null) ...[
          SizedBox.square(
            dimension: theme.iconSize,
            child: Center(
              child: IconTheme(
                data: IconThemeData(color: appearance.foreground, size: theme.iconSize),
                child: leadingIcon!,
              ),
            ),
          ),
          SizedBox(width: theme.iconSpacing),
        ],
        DefaultTextStyle(
          style: theme.textStyle.copyWith(color: appearance.foreground),
          child: Text(label),
        ),
        if (onRemove != null) ...[
          SizedBox(width: theme.removeIconSpacing),
          GestureDetector(
            onTap: onRemove,
            behavior: HitTestBehavior.opaque,
            child: SizedBox.square(
              dimension: theme.removeIconSize,
              child: Center(
                child: Icon(
                  const IconData(0xe5cd, fontFamily: 'MaterialIcons'), // close
                  size: theme.removeIconSize,
                  color: appearance.foreground,
                ),
              ),
            ),
          ),
        ],
      ],
    );

    Widget container = Container(
      constraints: BoxConstraints(minHeight: theme.minHeight),
      padding: theme.padding,
      decoration: BoxDecoration(
        color: appearance.background,
        borderRadius: theme.borderRadius,
        border: hasBorder ? Border.all(color: appearance.border) : null,
      ),
      child: row,
    );

    if (onPressed == null) return container;

    return GestureDetector(onTap: onPressed, behavior: HitTestBehavior.opaque, child: container);
  }
}

// Private helper that bundles frequently needed colour lookups.
final class _TagColors {
  _TagColors(DievasColourThemeData c)
    : bgSubtle = c.background.bgSubtle,
      bgElevated = c.background.bgElevated,
      textPrimary = c.text.textPrimary,
      textSecondary = c.text.textSecondary,
      borderDefault = c.border.borderDefault,
      transparent = const Color(0x00000000);

  final Color bgSubtle;
  final Color bgElevated;
  final Color textPrimary;
  final Color textSecondary;
  final Color borderDefault;
  final Color transparent;
}
