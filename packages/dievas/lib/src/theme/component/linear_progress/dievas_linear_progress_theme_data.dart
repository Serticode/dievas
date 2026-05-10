import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Theme data for [DievasLinearProgress].
///
/// Holds the height, radius, and colour tokens consumed by the widget.
/// Derived by the component mapper — not constructed directly in widget code.
final class DievasLinearProgressThemeData extends Equatable {
  const DievasLinearProgressThemeData({
    required this.height,
    required this.borderRadius,
    required this.trackColor,
    required this.colorPrimary,
    required this.colorSuccess,
    required this.colorError,
  });

  /// Track height in logical pixels.
  final double height;

  /// Corner radius applied to both the track and the fill bar.
  final BorderRadius borderRadius;

  /// Unfilled track background colour.
  final Color trackColor;

  /// Fill colour for [DievasLinearProgressStyle.primary].
  final Color colorPrimary;

  /// Fill colour for [DievasLinearProgressStyle.success].
  final Color colorSuccess;

  /// Fill colour for [DievasLinearProgressStyle.error].
  final Color colorError;

  @override
  List<Object?> get props => [height, borderRadius, trackColor, colorPrimary, colorSuccess, colorError];
}
