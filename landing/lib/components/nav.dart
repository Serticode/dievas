import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Fixed top navigation bar.
///
/// Server-rendered — no hydration needed. Backdrop blur is CSS-only.
class Nav extends StatelessComponent {
  const Nav({super.key});

  @override
  Component build(BuildContext context) {
    return nav(
      classes: 'fixed top-0 left-0 right-0 z-50 '
          'flex items-center justify-between '
          'px-10 py-5 '
          'border-b border-border '
          'backdrop-blur-md bg-bg-base/70',
      [
        a(
          href: '/',
          classes: 'font-mono text-sm tracking-widest text-text-hi no-underline',
          [
            Component.text('die'),
            span(classes: 'text-brand', [Component.text('v')]),
            Component.text('as'),
          ],
        ),
        a(
          href: '/widgetbook/',
          classes: 'font-mono text-xs tracking-wider text-text-mid '
              'no-underline transition-colors duration-200 '
              'hover:text-text-hi',
          [Component.text('open gallery →')],
        ),
      ],
    );
  }
}
