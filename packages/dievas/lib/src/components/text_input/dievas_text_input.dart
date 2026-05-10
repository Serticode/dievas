import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/dievas_theme.dart';

/// Size variants for [DievasTextInput].
enum DievasTextInputSize {
  /// 40 dp container height — compact contexts.
  sm,

  /// 48 dp container height — default.
  md,

  /// 52 dp container height — prominent / hero inputs.
  lg,
}

/// A themed text input field.
///
/// All colours, sizes, and typography are token-driven via [DievasTheme].
/// No raw values appear in this file.
///
/// Moon reference: TextInput
///
/// ```dart
/// DievasTextInput(
///   controller: _ctrl,
///   label: 'Email',
///   hint: 'you@example.com',
///   leadingIcon: Icon(Icons.email_outlined),
/// )
/// DievasTextInput(controller: _ctrl, errorText: 'Invalid email', size: .sm)
/// DievasTextInput(controller: _ctrl, enabled: false)
/// ```
class DievasTextInput extends StatefulWidget {
  const DievasTextInput({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.leadingIcon,
    this.trailingIcon,
    this.size = DievasTextInputSize.md,
    this.enabled = true,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
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

  /// Error message. Overrides [helperText] and switches the border to the
  /// error colour.
  final String? errorText;

  /// Leading widget inside the input container (icon, prefix, etc.).
  final Widget? leadingIcon;

  /// Trailing widget inside the input container (icon, suffix, etc.).
  final Widget? trailingIcon;

  final DievasTextInputSize size;

  /// When `false` the field is read-only and dimmed.
  final bool enabled;

  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;
  final bool autofocus;
  final int? maxLength;
  final bool autocorrect;

  @override
  State<DievasTextInput> createState() => _DievasTextInputState();
}

class _DievasTextInputState extends State<DievasTextInput> {
  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).textInput;
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;

    final height = switch (widget.size) {
      DievasTextInputSize.sm => theme.height.sm,
      DievasTextInputSize.md => theme.height.md,
      DievasTextInputSize.lg => theme.height.lg,
    };

    final contentPadding = switch (widget.size) {
      DievasTextInputSize.sm => theme.contentPadding.sm,
      DievasTextInputSize.md => theme.contentPadding.md,
      DievasTextInputSize.lg => theme.contentPadding.lg,
    };

    final inputStyle = switch (widget.size) {
      DievasTextInputSize.sm => theme.inputStyle.sm,
      DievasTextInputSize.md => theme.inputStyle.md,
      DievasTextInputSize.lg => theme.inputStyle.lg,
    };

    final placeholderStyle = switch (widget.size) {
      DievasTextInputSize.sm => theme.placeholderStyle.sm,
      DievasTextInputSize.md => theme.placeholderStyle.md,
      DievasTextInputSize.lg => theme.placeholderStyle.lg,
    };

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

    Widget field = SizedBox(
      height: height,
      child: TextField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        style: inputStyle,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        inputFormatters: widget.inputFormatters,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        onEditingComplete: widget.onEditingComplete,
        autofocus: widget.autofocus,
        maxLength: widget.maxLength,
        autocorrect: widget.autocorrect,
        enabled: widget.enabled,
        maxLines: 1,
        cursorColor: theme.borderColorFocused,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: placeholderStyle,
          contentPadding: contentPadding,
          filled: true,
          fillColor: theme.bgColor,
          prefixIcon: widget.leadingIcon == null
              ? null
              : Padding(
                  padding: EdgeInsetsDirectional.only(start: contentPadding.left, end: theme.iconSpacing),
                  child: IconTheme(
                    data: IconThemeData(color: theme.iconColor, size: theme.iconSize),
                    child: widget.leadingIcon!,
                  ),
                ),
          prefixIconConstraints: widget.leadingIcon == null
              ? null
              : BoxConstraints(minWidth: theme.iconSize + contentPadding.left + theme.iconSpacing),
          suffixIcon: widget.trailingIcon == null
              ? null
              : Padding(
                  padding: EdgeInsetsDirectional.only(end: contentPadding.right, start: theme.iconSpacing),
                  child: IconTheme(
                    data: IconThemeData(color: theme.iconColor, size: theme.iconSize),
                    child: widget.trailingIcon!,
                  ),
                ),
          suffixIconConstraints: widget.trailingIcon == null
              ? null
              : BoxConstraints(minWidth: theme.iconSize + contentPadding.right + theme.iconSpacing),
          border: border,
          enabledBorder: border,
          focusedBorder: focusedBorder,
          disabledBorder: disabledBorder,
          errorBorder: focusedBorder,
          focusedErrorBorder: focusedBorder,
          // Suppress internal helper/error text — we render our own below.
          isDense: true,
          counterText: '',
        ),
      ),
    );

    Widget column = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          DefaultTextStyle(style: theme.labelStyle, child: Text(widget.label!)),
          SizedBox(height: theme.labelSpacing),
        ],
        field,
        if (hasError) ...[
          SizedBox(height: theme.helperSpacing),
          DefaultTextStyle(
            style: theme.errorStyle.copyWith(color: theme.borderColorError),
            child: Text(widget.errorText!),
          ),
        ] else if (widget.helperText != null) ...[
          SizedBox(height: theme.helperSpacing),
          DefaultTextStyle(style: theme.helperStyle, child: Text(widget.helperText!)),
        ],
      ],
    );

    if (!widget.enabled) {
      return Opacity(opacity: theme.disabledOpacity, child: column);
    }

    return column;
  }
}
