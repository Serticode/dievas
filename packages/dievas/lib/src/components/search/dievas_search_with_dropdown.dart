import 'package:flutter/material.dart';

import '../../theme/dievas_theme.dart';

/// A search field with an overlay dropdown showing filtered results.
///
/// As the user types, [items] are filtered and matching results appear in a
/// dropdown overlay positioned below the search field. Tapping outside the
/// dropdown or clearing the search text dismisses it.
///
/// Unlike [DievasSearchWithList] (which renders results inline), this
/// variant uses an [Overlay] so the dropdown can extend beyond the parent's
/// clip bounds — useful inside dialogs, side panels, or tight layouts.
///
/// Moon reference: SearchWithDropdown
///
/// ```dart
/// DievasSearchWithDropdown<String>(
///   items: ['Apple', 'Banana', 'Cherry'],
///   displayString: (s) => s,
///   hint: 'Search...',
///   onSelected: (fruit) => print(fruit),
/// )
/// ```
class DievasSearchWithDropdown<T> extends StatefulWidget {
  const DievasSearchWithDropdown({
    super.key,
    required this.items,
    required this.displayString,
    required this.onSelected,
    this.hint,
    this.filter,
    this.enabled = true,
  });

  /// The full set of searchable items.
  final List<T> items;

  /// Converts an item to its display string for filtering and rendering.
  final String Function(T) displayString;

  /// Called when the user taps a result item. Search text is cleared
  /// and the dropdown dismissed before this fires.
  final ValueChanged<T> onSelected;

  /// Placeholder text in the search field.
  final String? hint;

  /// Custom filter predicate. Defaults to case-insensitive substring match.
  final bool Function(T item, String query)? filter;

  /// When `false` the search field is read-only.
  final bool enabled;

  @override
  State<DievasSearchWithDropdown<T>> createState() => _DievasSearchWithDropdownState<T>();
}

class _DievasSearchWithDropdownState<T> extends State<DievasSearchWithDropdown<T>> {
  final _controller = TextEditingController();
  final _fieldKey = GlobalKey();
  OverlayEntry? _dropdown;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onQueryChange);
  }

  @override
  void dispose() {
    _removeDropdown();
    _controller.removeListener(_onQueryChange);
    _controller.dispose();
    super.dispose();
  }

  void _onQueryChange() {
    final query = _controller.text;
    if (query.isEmpty) {
      _removeDropdown();
      setState(() {});
      return;
    }

    final filter = widget.filter ?? _defaultFilter;
    final results = widget.items.where((item) => filter(item, query)).toList();

    setState(() {});
    if (results.isNotEmpty) {
      _showOverlay(results);
    } else {
      _removeDropdown();
    }
  }

  bool _defaultFilter(T item, String query) =>
      widget.displayString(item).toLowerCase().contains(query.toLowerCase());

  void _showOverlay(List<T> results) {
    final renderBox = _fieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    _removeDropdown();

    _dropdown = OverlayEntry(
      builder: (context) => _DropdownResults<T>(
        top: offset.dy + size.height,
        left: offset.dx,
        width: size.width,
        results: results,
        displayString: widget.displayString,
        onItemTap: _onItemTap,
        onDismiss: _removeDropdown,
      ),
    );

    Overlay.of(context).insert(_dropdown!);
  }

  void _removeDropdown() {
    _dropdown?.remove();
    _dropdown = null;
  }

  void _onItemTap(T item) {
    _removeDropdown();
    _controller.clear();
    widget.onSelected(item);
  }

  @override
  Widget build(BuildContext context) {
    final colors = DievasTheme.colorsOf(context);
    final typo = DievasTheme.typographyOf(context);
    final spacing = DievasTheme.spacingOf(context);
    final borderRadius = DievasTheme.borderOf(context).md;

    return SizedBox(
      key: _fieldKey,
      height: DievasTheme.sizingOf(context).inputHeightMd,
      child: TextField(
        controller: _controller,
        enabled: widget.enabled,
        style: typo.bodyMd,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: typo.bodyMd.copyWith(color: colors.input.inputPlaceholder),
          contentPadding: EdgeInsets.symmetric(horizontal: spacing.md, vertical: spacing.sm),
          filled: true,
          fillColor: colors.input.inputBg,
          prefixIcon: Padding(
            padding: EdgeInsetsDirectional.only(start: spacing.md, end: spacing.xs),
            child: IconTheme(
              data: IconThemeData(color: colors.icon.iconSecondary, size: 20),
              child: const Icon(Icons.search),
            ),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 0),
          suffixIcon: _controller.text.isNotEmpty
              ? Padding(
                padding: EdgeInsetsDirectional.only(end: spacing.sm, start: spacing.xs),
                child: IconTheme(
                  data: IconThemeData(color: colors.icon.iconSecondary, size: 16),
                  child: GestureDetector(
                    onTap: () {
                      _controller.clear();
                      _removeDropdown();
                    },
                    child: const Icon(Icons.close),
                  ),
                ),
              )
              : null,
          suffixIconConstraints: const BoxConstraints(minWidth: 32, minHeight: 0),
          border: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(color: colors.input.inputBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(color: colors.input.inputBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(color: colors.input.inputBorderFocus),
          ),
          isDense: true,
        ),
      ),
    );
  }
}

class _DropdownResults<T> extends StatelessWidget {
  const _DropdownResults({
    required this.top,
    required this.left,
    required this.width,
    required this.results,
    required this.displayString,
    required this.onItemTap,
    required this.onDismiss,
  });

  final double top;
  final double left;
  final double width;
  final List<T> results;
  final String Function(T) displayString;
  final ValueChanged<T> onItemTap;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final colors = DievasTheme.colorsOf(context);
    final typo = DievasTheme.typographyOf(context);
    final spacing = DievasTheme.spacingOf(context);
    final border = DievasTheme.borderOf(context);

    final sizing = DievasTheme.sizingOf(context);
    final rowHeight = sizing.inputHeightSm;
    final maxHeight = (results.length * rowHeight).clamp(0.0, rowHeight * 7);

    return Stack(
      children: [
        // Full-screen tap-to-dismiss layer
        Positioned.fill(
          child: GestureDetector(onTap: onDismiss, behavior: .opaque, child: const SizedBox.expand()),
        ),
        Positioned(
          top: top,
          left: left,
          width: width,
          child: Material(
            elevation: 0,
            color: colors.background.bgElevated,
            borderRadius: BorderRadius.vertical(bottom: border.md.topLeft),
            child: Container(
              constraints: BoxConstraints(maxHeight: maxHeight),
              decoration: BoxDecoration(
                color: colors.background.bgElevated,
                borderRadius: BorderRadius.vertical(bottom: border.md.topLeft),
                border: Border.all(color: colors.input.inputBorderFocus),
                boxShadow: [
                  BoxShadow(
                    color: colors.background.bgOverlay,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: results.length,
                separatorBuilder: (_, _) => Divider(
                  height: 1,
                  thickness: 1,
                  color: colors.border.borderDefault,
                  indent: spacing.md,
                  endIndent: spacing.md,
                ),
                itemBuilder: (context, i) {
                  final item = results[i];
                  return InkWell(
                    onTap: () => onItemTap(item),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: spacing.md, vertical: spacing.smPlus),
                      child: Text(displayString(item), style: typo.bodyMd),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
