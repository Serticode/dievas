import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/dievas_theme.dart';

/// A multiline text input area.
///
/// Shares the same token architecture as [DievasTextInput]. Height is driven
/// by [minLines] / [maxLines] rather than a fixed size enum — always uses the
/// `md` content padding and typography variant.
///
/// Moon reference: Textarea
///
/// ```dart
/// DievasTextArea(
///   controller: _ctrl,
///   label: 'Bio',
///   hint: 'Tell us about yourself...',
///   minLines: 3,
///   maxLines: 6,
/// )
/// DievasTextArea(controller: _ctrl, errorText: 'Required', maxLines: 4)
/// ```
class DievasTextArea extends StatelessWidget {
  const DievasTextArea({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.minLines = 3,
    this.maxLines = 6,
    this.enabled = true,
    this.keyboardType = TextInputType.multiline,
    this.textInputAction = TextInputAction.newline,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.autofocus = false,
    this.maxLength,
    this.autocorrect = true,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;

  /// Floating label rendered above the input container.
  final String? label;

  /// Placeholder text shown when the field is empty.
  final String? hint;

  /// Helper text shown below the input when there is no error.
  final String? helperText;

  /// Error message. Overrides [helperText] and switches the border to error colour.
  final String? errorText;

  /// Minimum visible lines. Defaults to 3.
  final int minLines;

  /// Maximum lines before the field scrolls. Defaults to 6.
  final int? maxLines;

  final bool enabled;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;
  final bool autofocus;
  final int? maxLength;
  final bool autocorrect;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).textInput;
    final hasError = errorText != null && errorText!.isNotEmpty;

    // TextArea always uses md tokens
    final contentPadding = theme.contentPadding.md;
    final inputStyle = theme.inputStyle.md;
    final placeholderStyle = theme.placeholderStyle.md;

    final borderColor = hasError ? theme.borderColorError : theme.borderColor;
    final focusedBorderColor = hasError ? theme.borderColorError : theme.borderColorFocused;

    final border = OutlineInputBorder(
      borderRadius: theme.borderRadius,
      borderSide: BorderSide(color: borderColor, width: theme.strokeWidth),
    );

    final focusedBorder = OutlineInputBorder(
      borderRadius: theme.borderRadius,
      borderSide: BorderSide(color: focusedBorderColor, width: theme.strokeWidthFocused),
    );

    final disabledBorder = OutlineInputBorder(
      borderRadius: theme.borderRadius,
      borderSide: BorderSide(color: theme.borderColor, width: theme.strokeWidth),
    );

    final field = TextField(
      controller: controller,
      focusNode: focusNode,
      style: inputStyle,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onEditingComplete: onEditingComplete,
      autofocus: autofocus,
      maxLength: maxLength,
      autocorrect: autocorrect,
      enabled: enabled,
      minLines: minLines,
      maxLines: maxLines,
      cursorColor: theme.borderColorFocused,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: placeholderStyle,
        contentPadding: contentPadding,
        filled: true,
        fillColor: theme.bgColor,
        border: border,
        enabledBorder: border,
        focusedBorder: focusedBorder,
        disabledBorder: disabledBorder,
        errorBorder: focusedBorder,
        focusedErrorBorder: focusedBorder,
        isDense: true,
        counterText: '',
      ),
    );

    Widget column = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          DefaultTextStyle(style: theme.labelStyle, child: Text(label!)),
          SizedBox(height: theme.labelSpacing),
        ],
        field,
        if (hasError) ...[
          SizedBox(height: theme.helperSpacing),
          DefaultTextStyle(
            style: theme.errorStyle.copyWith(color: theme.borderColorError),
            child: Text(errorText!),
          ),
        ] else if (helperText != null) ...[
          SizedBox(height: theme.helperSpacing),
          DefaultTextStyle(style: theme.helperStyle, child: Text(helperText!)),
        ],
      ],
    );

    if (!enabled) {
      return Opacity(opacity: theme.disabledOpacity, child: column);
    }

    return column;
  }
}
