import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'addons/component_boundary_addon.dart';
import 'addons/dievas_theme_addon.dart';
import 'components/buttons/dievas_filled_button.dart';
import 'components/buttons/dievas_icon_button.dart';
import 'components/buttons/dievas_outlined_button.dart';
import 'components/buttons/dievas_text_button.dart';

void main() => runApp(const DievasGallery());

class DievasGallery extends StatelessWidget {
  const DievasGallery({super.key});

  @override
  Widget build(BuildContext context) => Widgetbook.material(
    directories: [
      WidgetbookCategory(
        name: 'Components',
        children: [
          WidgetbookFolder(
            name: 'Buttons',
            children: [filledButtonComponent, outlinedButtonComponent, textButtonComponent, iconButtonComponent],
          ),
        ],
      ),
    ],
    addons: [
      DievasThemeAddon(),
      ComponentBoundaryAddon(),
      GridAddon(10),
      ViewportAddon([Viewports.none, ...IosViewports.all, ...AndroidViewports.all]),
      TextScaleAddon(min: 0.75, max: 1.5, initialScale: 1),
      // ignore: experimental_member_use
      TimeDilationAddon(),
      InspectorAddon(),
    ],
  );
}
