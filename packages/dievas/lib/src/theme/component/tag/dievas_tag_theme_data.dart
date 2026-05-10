import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Theme data for [DievasTag].
///
/// Holds layout and typography tokens. Colour is resolved dynamically in the
/// widget from [DievasColourThemeData] based on [DievasTagStyle] — mirroring
/// the Badge pattern so the mapper stays clean.
final class DievasTagThemeData extends Equatable {
  const DievasTagThemeData({
    required this.textStyle,
    required this.borderRadius,
    required this.padding,
    required this.iconSize,
    required this.iconSpacing,
    required this.removeIconSize,
    required this.removeIconSpacing,
    required this.minHeight,
  });

  /// Label text style — typically [DievasTypographyThemeData.labelSm].
  final TextStyle textStyle;

  /// Container corner radius.
  final BorderRadius borderRadius;

  /// Inner padding applied to the tag container.
  final EdgeInsets padding;

  /// Leading icon size (dp).
  final double iconSize;

  /// Gap between leading icon and label (dp).
  final double iconSpacing;

  /// Remove (×) icon size (dp).
  final double removeIconSize;

  /// Gap between label and remove icon (dp).
  final double removeIconSpacing;

  /// Minimum container height (dp).
  final double minHeight;

  @override
  List<Object?> get props => [
    textStyle,
    borderRadius,
    padding,
    iconSize,
    iconSpacing,
    removeIconSize,
    removeIconSpacing,
    minHeight,
  ];
}
