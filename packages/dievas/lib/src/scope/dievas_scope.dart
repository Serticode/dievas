import 'package:flutter/foundation.dart' show FlutterExceptionHandler;
import 'package:flutter/material.dart';

import '../theme.dart';
import '../themes.dart';

/// The entry-point widget for the Dievas design system.
///
/// [DievasScope] must wrap your application (or the subtree consuming Dievas).
/// It resolves the active theme based on [themeMode] + platform brightness,
/// inserts [DievasTheme] into the widget tree, and bridges to Material via
/// [MaterialApp]'s [theme] parameter.
///
/// ```dart
/// DievasScope(
///   lightTheme: CadenceLightThemeData(),
///   darkTheme: CadenceDarkThemeData(),
///   themeMode: ThemeMode.system,
///   child: MaterialApp.router(...),
/// )
/// ```
///
/// If no [lightTheme] / [darkTheme] is provided, the defaults
/// ([DievasLightThemeData] / [DievasDarkThemeData]) are used — suitable for
/// the gallery and quick prototypes.
class DievasScope extends StatefulWidget {
  DievasScope({
    super.key,
    DievasThemeData? lightTheme,
    DievasThemeData? darkTheme,
    this.themeMode = .system,
    required this.child,
  }) : lightTheme = lightTheme ?? DievasLightThemeData(),
       darkTheme = darkTheme ?? DievasDarkThemeData();

  /// Theme data for light mode. Defaults to [DievasLightThemeData].
  final DievasThemeData lightTheme;

  /// Theme data for dark mode. Defaults to [DievasDarkThemeData].
  final DievasThemeData darkTheme;

  /// Controls which theme is active. Defaults to [ThemeMode.system].
  final ThemeMode themeMode;

  /// The subtree this scope provides the theme to.
  final Widget child;

  /// Returns the [DievasScopeState] from the nearest [DievasScope] ancestor.
  ///
  /// Use this to call [DievasScopeState.setThemeMode] programmatically, e.g.
  /// from a settings screen.
  static DievasScopeState of(BuildContext context) {
    final state = context.findAncestorStateOfType<DievasScopeState>();
    assert(state != null, 'No DievasScope found in the widget tree.');
    return state!;
  }

  static FlutterExceptionHandler onError = FlutterError.presentError;

  @override
  State<DievasScope> createState() => DievasScopeState();
}

/// Mutable state for [DievasScope].
class DievasScopeState extends State<DievasScope> with WidgetsBindingObserver {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.themeMode;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didUpdateWidget(DievasScope oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.themeMode != oldWidget.themeMode) {
      _themeMode = widget.themeMode;
    }
  }

  @override
  void didChangePlatformBrightness() => setState(() {});

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void setThemeMode(ThemeMode mode) => setState(() => _themeMode = mode);

  DievasThemeData get _activeTheme {
    final platformBrightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    return switch (_themeMode) {
      .light => widget.lightTheme,
      .dark => widget.darkTheme,
      .system => platformBrightness == .dark ? widget.darkTheme : widget.lightTheme,
    };
  }

  @override
  Widget build(BuildContext context) => DievasTheme(data: _activeTheme, child: widget.child);
}
