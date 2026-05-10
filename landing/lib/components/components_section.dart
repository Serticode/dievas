import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Component status strip — shipped vs. in-progress.
class ComponentsSection extends StatelessComponent {
  const ComponentsSection({super.key});

  @override
  Component build(BuildContext context) {
    return section(classes: 'py-4xl max-w-5xl mx-auto px-10 w-full', [
      // Section label + legend
      div(classes: 'flex items-center justify-between flex-wrap gap-4 mb-10', [
        p(classes: 'font-mono text-[11px] tracking-[0.16em] uppercase text-brand', [
          Component.text('✶  Component status'),
        ]),
        div(classes: 'flex items-center gap-5 font-mono text-[11px] text-text-lo', [
          _legendItem(shipped: true, label: 'production'),
          _legendItem(shipped: false, label: 'in progress'),
        ]),
      ]),

      // Pills grid
      div(classes: 'flex flex-wrap gap-2', [
        for (final c in _shipped) _pill(c, shipped: true),
        for (final c in _wip) _pill(c, shipped: false),
      ]),

      // CTA
      div(classes: 'mt-20 py-16 text-center relative', [
        // Glow
        div(classes: 'pointer-events-none absolute inset-0 flex items-center justify-center', [
          div(classes: 'w-[500px] h-[200px] rounded-full bg-brand/10 blur-[60px]', []),
        ]),

        div(classes: 'relative', [
          h2(
            classes:
                'text-[clamp(36px,5vw,60px)] font-black tracking-[-0.025em] '
                'leading-[1.05] mb-5',
            [Component.text('See it in action.')],
          ),
          p(classes: 'font-mono text-sm text-text-mid mb-10', [
            Component.text('Interact with every component, toggle themes,'),
            br(),
            Component.text('test viewports — in the live gallery.'),
          ]),
          a(
            href: '/widgetbook/',
            classes:
                'inline-flex items-center gap-2 '
                'px-6 py-3 rounded-md '
                'bg-action text-on-brand '
                'font-mono text-sm font-medium '
                'no-underline transition-all duration-200 '
                'hover:bg-action-hover hover:-translate-y-px',
            [
              Component.text('Open Widgetbook'),
              span(classes: 'text-xs', [Component.text('→')]),
            ],
          ),
        ]),
      ]),
    ]);
  }

  Component _legendItem({required bool shipped, required String label}) => div(classes: 'flex items-center gap-2', [
    div(classes: 'w-1.5 h-1.5 rounded-full ${shipped ? 'bg-brand' : 'bg-text-lo'}', []),
    Component.text(label),
  ]);

  Component _pill(String name, {required bool shipped}) => div(
    classes:
        'inline-flex items-center gap-2 '
        'px-3.5 py-2 '
        'border border-border rounded-full '
        'font-mono text-xs text-text-mid '
        'bg-bg-subtle '
        'transition-colors duration-200 '
        'hover:border-border-brand hover:text-text-hi',
    [
      div(
        classes:
            'w-1.5 h-1.5 rounded-full flex-shrink-0 '
            '${shipped ? 'bg-brand' : 'bg-text-lo'}',
        [],
      ),
      Component.text(name),
    ],
  );

  static const _shipped = ['FilledButton', 'OutlinedButton', 'TextButton', 'IconButton'];

  static const _wip = [
    'Avatar',
    'Badge',
    'Tag',
    'Divider',
    'CircularProgress',
    'LinearProgress',
    'TextField',
    'TextArea',
    'Checkbox',
    'Switch',
    'Radio',
    'BottomSheet',
    'Toast',
    'Modal',
    'Tooltip',
  ];
}
