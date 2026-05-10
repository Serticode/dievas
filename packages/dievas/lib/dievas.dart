/// Dievas design system — Flutter theme and component layer.
///
/// Import this library to access the full Dievas public API:
/// - [DievasScope] — entry-point widget; wraps your app
/// - [DievasTheme] — InheritedModel with static sub-system accessors
/// - [DievasThemeData] — the theme contract (implement to create brand themes)
/// - [DievasGlobalThemeData] — sealed abstract base (extend to create brand themes)
/// - [DievasLightThemeData] / [DievasDarkThemeData] — default themes
/// - All ThemeData sub-systems (colours, typography, spacing, etc.)
/// - [DievasGrid] / [DievasGridBreakpoint] — responsive grid
/// - Context extensions (`context.colors`, `context.typography`, ...)
/// - Button components: [DievasFilledButton], [DievasOutlinedButton],
///   [DievasTextButton], [DievasIconButton]
/// - Form components: [DievasTextInput], [DievasTextArea], [DievasCheckbox],
///   [DievasSwitch], [DievasRadio]
/// - Display components: [DievasAvatar], [DievasBadge], [DievasTag],
///   [DievasDivider], [DievasIcon], [DievasLinearProgress], [DievasCircularProgress]
library;

//  Scope
export 'src/scope/dievas_scope.dart';

//  Theme barrels
export 'src/theme.dart';
export 'src/themes.dart';

//  Components — Buttons
export 'src/components/buttons/dievas_filled_button.dart';
export 'src/components/buttons/dievas_icon_button.dart';
export 'src/components/buttons/dievas_outlined_button.dart';
export 'src/components/buttons/dievas_text_button.dart';
export 'src/components/buttons/button_types/dievas_button_icon_style_behavior.dart';
export 'src/components/buttons/button_types/dievas_button_shape.dart';
export 'src/components/buttons/button_types/dievas_button_size.dart';
export 'src/components/buttons/button_types/dievas_button_state.dart';
export 'src/components/buttons/button_types/dievas_button_style.dart';

//  Components — Form
export 'src/components/checkbox/dievas_checkbox.dart';
export 'src/components/radio/dievas_radio.dart';
export 'src/components/switch/dievas_switch.dart';
export 'src/components/text_area/dievas_text_area.dart';
export 'src/components/text_input/dievas_text_input.dart';

//  Components — Display
export 'src/components/avatar/dievas_avatar.dart';
export 'src/components/badge/dievas_badge.dart';
export 'src/components/divider/dievas_divider.dart';
export 'src/components/icon/dievas_icon.dart';
export 'src/components/progress/dievas_circular_progress.dart';
export 'src/components/progress/dievas_linear_progress.dart';
export 'src/components/tag/dievas_tag.dart';
