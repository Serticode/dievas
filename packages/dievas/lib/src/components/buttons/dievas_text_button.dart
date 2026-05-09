import 'package:flutter/material.dart';

import '../../theme/dievas_theme.dart';
import 'dievas_button_state_animated_loader_mixin.dart';
import 'dievas_button_state_switcher.dart';
import 'types/dievas_button_size.dart';
import 'types/dievas_button_state.dart';

/// Visual style variants for [DievasTextButton].
enum DievasTextButtonStyle {
  /// Brand-coloured foreground — primary inline action.
  primary,

  /// Error-red foreground — destructive inline action.
  destructive,
}

/// Duration for press-opacity animation.
const Duration _kPressedOpacityDuration = Duration(milliseconds: 100);

/// Opacity applied on press (Apple platforms).
const double _kApplePressedOpacity = 0.7;

/// A text-only button with no background or border.
///
/// Sizes itself to its content. Used for inline actions, links, and
/// secondary affordance where a full-height button would be too heavy.
///
/// ```dart
/// DievasTextButton(
///   label: 'View details',
///   onPressed: () { },
/// )
/// ```
class DievasTextButton extends StatefulWidget with DievasButtonStateAnimatedLoaderMixin {
  const DievasTextButton({
    super.key,
    required this.label,
    this.style = .primary,
    this.size = .md,
    this.state = .idle,
    this.leadingIcon,
    this.trailingIcon,
    this.onPressed,
  });

  final String label;
  final DievasTextButtonStyle style;
  final DievasButtonSize size;

  @override
  final DievasButtonState state;

  final Widget? leadingIcon;
  final Widget? trailingIcon;

  /// Pressed callback. `null` or [DievasButtonState.loading] → non-interactive.
  final VoidCallback? onPressed;

  @override
  State<DievasTextButton> createState() => _DievasTextButtonState();
}

class _DievasTextButtonState extends State<DievasTextButton>
    with SingleTickerProviderStateMixin, DievasButtonStateAnimatedLoaderProviderMixin {
  late final _statesController = WidgetStatesController();

  @override
  void dispose() {
    _statesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final components = DievasTheme.componentsOf(context);
    final buttonTheme = switch (widget.style) {
      .primary => components.textButton.primary,
      .destructive => components.textButton.destructive,
    };

    final textStyle = switch (widget.size) {
      .sm => buttonTheme.textStyle.sm,
      .md => buttonTheme.textStyle.md,
      .lg => buttonTheme.textStyle.lg,
    };

    final iconSize = switch (widget.size) {
      .sm => buttonTheme.iconSize.sm,
      .md => buttonTheme.iconSize.md,
      .lg => buttonTheme.iconSize.lg,
    };

    final iconSpacing = switch (widget.size) {
      .sm => buttonTheme.iconSpacing.sm,
      .md => buttonTheme.iconSpacing.md,
      .lg => buttonTheme.iconSpacing.lg,
    };

    final platform = Theme.of(context).platform;
    final isApple = platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;

    return Semantics(
      button: true,
      child: Material(
        type: .transparency,
        child: InkWell(
          statesController: _statesController,
          onTap: widget.state == .loading ? null : widget.onPressed,
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          child: ValueListenableBuilder<Set<WidgetState>>(
            valueListenable: _statesController,
            builder: (_, states, _) {
              final isPressed = states.contains(WidgetState.pressed);
              final isDisabled = states.contains(WidgetState.disabled) || widget.onPressed == null;

              final opacityFactor = isDisabled
                  ? buttonTheme.disabledOpacity
                  : (isApple && isPressed ? _kApplePressedOpacity : 1.0);

              final themeStyle = buttonTheme.style;
              final activeStyle = isPressed ? themeStyle.focused : themeStyle.idle;
              final foreground = activeStyle.foreground.withValues(alpha: opacityFactor);

              final content = Row(
                mainAxisSize: .min,
                spacing: iconSpacing,
                children: [
                  if (widget.leadingIcon case final icon?)
                    IconTheme(
                      data: IconThemeData(color: foreground, size: iconSize),
                      child: icon,
                    ),
                  AnimatedDefaultTextStyle(
                    duration: _kPressedOpacityDuration,
                    style: textStyle.copyWith(color: foreground),
                    child: Text(widget.label),
                  ),
                  if (widget.trailingIcon case final icon?)
                    IconTheme(
                      data: IconThemeData(color: foreground, size: iconSize),
                      child: icon,
                    ),
                ],
              );

              return DievasButtonStateSwitcher(
                state: widget.state,
                loader: IconTheme(
                  data: IconThemeData(color: foreground, size: iconSize),
                  child: animatedLoader,
                ),
                content: content,
              );
            },
          ),
        ),
      ),
    );
  }
}
