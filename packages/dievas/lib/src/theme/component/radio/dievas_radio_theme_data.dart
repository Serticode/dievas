import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Theme data for [DievasRadio].
///
/// Token-derived dimensions and colours. Widget reads this from
/// [DievasComponentThemeData.radio].
final class DievasRadioThemeData extends Equatable {
  const DievasRadioThemeData({
    required this.size,
    required this.strokeWidth,
    required this.dotSize,
    required this.colorSelected,
    required this.colorUnselected,
    required this.colorDisabled,
    required this.borderColorUnselected,
    required this.borderColorDisabled,
    required this.dotColor,
    required this.disabledOpacity,
    required this.labelStyle,
    required this.labelSpacing,
  });

  /// Outer circle diameter (dp).
  final double size;

  /// Ring stroke width (dp) in unselected state.
  final double strokeWidth;

  /// Inner dot diameter (dp) in selected state.
  final double dotSize;

  /// Outer ring fill / border colour when selected.
  final Color colorSelected;

  /// Outer ring border colour when unselected (transparent fill).
  final Color colorUnselected;

  /// Outer ring colour when disabled.
  final Color colorDisabled;

  /// Border colour when unselected.
  final Color borderColorUnselected;

  /// Border colour when disabled.
  final Color borderColorDisabled;

  /// Inner dot fill colour when selected.
  final Color dotColor;

  /// Opacity multiplier applied to the whole widget when disabled.
  final double disabledOpacity;

  /// Text style for the optional label.
  final TextStyle labelStyle;

  /// Gap between the radio circle and the label (dp).
  final double labelSpacing;

  @override
  List<Object?> get props => [
    size,
    strokeWidth,
    dotSize,
    colorSelected,
    colorUnselected,
    colorDisabled,
    borderColorUnselected,
    borderColorDisabled,
    dotColor,
    disabledOpacity,
    labelStyle,
    labelSpacing,
  ];
}
