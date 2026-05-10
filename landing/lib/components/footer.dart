import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Page footer.
class FooterComponent extends StatelessComponent {
  const FooterComponent({super.key});

  @override
  Component build(BuildContext context) {
    return footer(
      classes:
          'max-w-5xl mx-auto px-10 w-full '
          'py-8 border-t border-border '
          'flex items-center justify-between flex-wrap gap-4',
      [
        span(classes: 'font-mono text-xs text-text-lo', [
          Component.text('Dievas — built by '),
          a(
            href: 'https://serticode.dev',
            attributes: const {'target': '_blank', 'rel': 'noopener'},
            classes: 'text-brand no-underline hover:underline',
            [Component.text('Serticode Inc.')],
          ),
        ]),
        nav(classes: 'flex items-center gap-5', [
          for (final lnk in _links)
            a(
              href: lnk.$2,
              attributes: lnk.$3 != null ? {'target': '_blank', 'rel': 'noopener'} : {},
              classes:
                  'font-mono text-xs text-text-lo no-underline '
                  'transition-colors duration-200 hover:text-text-mid',
              [Component.text(lnk.$1)],
            ),
        ]),
      ],
    );
  }

  static const _links = [
    ('Gallery', '/widgetbook/', null),
    ('GitHub', 'https://github.com/serticode/dievas', '_blank'),
    ('Moon DS', 'https://flutter.moon.io', '_blank'),
  ];
}
