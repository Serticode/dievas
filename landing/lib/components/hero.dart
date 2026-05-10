import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Hero section — above-the-fold landing content.
///
/// Statically rendered. CSS animations handle the staggered fade-in.
/// No Dart JS needed on the client for this component.
class Hero extends StatelessComponent {
  const Hero({super.key});

  @override
  Component build(BuildContext context) => section(
    classes:
        'relative min-h-screen flex flex-col justify-center '
        'pt-20 overflow-hidden',
    [
      // Ambient glow — pure CSS, server-rendered.
      div(classes: 'pointer-events-none absolute inset-0 flex items-center justify-center', [
        div(
          classes:
              'w-[600px] h-[400px] rounded-full '
              'bg-brand/10 blur-[80px]',
          [],
        ),
      ]),

      // Eyebrow
      div(classes: 'relative max-w-5xl mx-auto px-10 w-full', [
        p(
          classes:
              'font-mono text-xs tracking-[0.18em] uppercase '
              'text-brand mb-7 opacity-0 animate-[fade-up_0.6s_ease_0.1s_forwards]',
          [Component.text('✶  Flutter Design System')],
        ),

        // Title
        h1(
          classes:
              'text-[clamp(52px,8vw,96px)] font-black leading-[0.94] '
              'tracking-[-0.03em] mb-8 '
              'opacity-0 animate-[fade-up_0.7s_ease_0.2s_forwards]',
          [
            span(classes: 'text-text-lo', [Component.text('Build')]),
            br(),
            Component.text('Once'),
            span(classes: 'text-brand', [Component.text('.')]),
            br(),
            span(classes: 'text-text-lo', [Component.text('Ship')]),
            br(),
            Component.text('Anywhere'),
            span(classes: 'text-brand', [Component.text('.')]),
          ],
        ),

        // Subtitle
        p(
          classes:
              'max-w-lg font-mono font-light text-base leading-[1.7] '
              'text-text-mid mb-12 '
              'opacity-0 animate-[fade-up_0.7s_ease_0.35s_forwards]',
          [
            Component.text(
              "Dievas ports Moon Design System's component catalogue."
              'Token-driven. InheritedModel-first. Multi-brand.',
            ),
          ],
        ),

        // CTAs
        div(
          classes:
              'flex items-center gap-4 flex-wrap '
              'opacity-0 animate-[fade-up_0.7s_ease_0.48s_forwards]',
          [
            a(
              href: '/widgetbook/',
              classes:
                  'inline-flex items-center gap-2 '
                  'px-6 py-3 rounded-md '
                  'bg-action text-on-brand '
                  'font-mono text-sm font-medium tracking-wide '
                  'no-underline transition-all duration-200 '
                  'hover:bg-action-hover hover:-translate-y-px '
                  'hover:shadow-[0_8px_32px_rgba(129,140,248,0.35)]',
              [
                Component.text('Explore components'),
                span(classes: 'text-xs', [Component.text('→')]),
              ],
            ),
            a(
              href: 'https://github.com/serticode/dievas',
              attributes: const {'target': '_blank', 'rel': 'noopener'},
              classes:
                  'inline-flex items-center gap-2 '
                  'px-6 py-3 rounded-md '
                  'border border-border-brand text-text-mid '
                  'font-mono text-sm font-normal '
                  'no-underline transition-all duration-200 '
                  'hover:border-brand hover:text-text-hi hover:-translate-y-px',
              [Component.text('GitHub')],
            ),
          ],
        ),

        // Stats
        div(
          classes:
              'flex gap-12 flex-wrap '
              'mt-20 pt-12 border-t border-border '
              'opacity-0 animate-[fade-up_0.7s_ease_0.62s_forwards]',
          [
            _stat('3', 'packages'),
            _stat('2', 'default themes'),
            _stat('4', 'button variants'),
            _stat('∞', 'brand configs'),
          ],
        ),
      ]),
    ],
  );

  Component _stat(String value, String label) => div(classes: 'flex flex-col gap-1', [
    span(classes: 'font-mono text-3xl font-medium text-text-hi leading-none', [Component.text(value)]),
    span(classes: 'font-mono text-[11px] tracking-[0.12em] uppercase text-text-lo', [Component.text(label)]),
  ]);
}
