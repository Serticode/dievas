import 'package:flutter/widgets.dart';

/// Visual style of [DievasLinearProgress].
enum DievasLinearProgressStyle {
  /// Solid brand-coloured track.
  primary,

  /// Success-green track.
  success,

  /// Error-red track.
  error,
}

/// A horizontal progress bar.
///
/// Pass `value: null` for an indeterminate (animated) indicator.
///
/// Moon reference: LinearProgress
///
/// ```dart
/// DievasLinearProgress(value: 0.6)
/// DievasLinearProgress(value: null) // indeterminate
/// ```
class DievasLinearProgress extends StatelessWidget {
  const DievasLinearProgress({super.key, this.value, this.style = .primary});

  /// Progress from 0.0 to 1.0. `null` → indeterminate.
  final double? value;

  final DievasLinearProgressStyle style;

  @override
  Widget build(BuildContext context) {
    // TODO: M3 implementation — derive track/fill colours from
    //       DievasTheme.componentsOf(context).linearProgress,
    //       height from DievasTheme.sizingOf(context)
    return const SizedBox.shrink();
  }
}
