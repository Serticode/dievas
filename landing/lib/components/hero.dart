import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../constants.dart';

/// Hero section — above-the-fold landing content.
///
/// Left copy column in normal flow; right side is two absolutely-positioned
/// layers:
///   1. `_rightContainment` — large rounded frame with an interactive app
///      window mock (tab switcher + light/dark theme toggle).
///   2. Social icon badges — sit in the cut-out space below the frame.
///
/// All interactivity is CSS-only (checkbox/radio hack) plus one vanilla-JS
/// parallax snippet for the floating tooltips. No Jaspr client hydration
/// required — works on the first SSR paint.
///
/// Interactive elements inside the app window mock:
///   • **Tab switcher** — four radio inputs show Buttons / Tokens / Type /
///     Status panels via `:checked ~ .app-inner .panel-*` CSS selectors.
///   • **Theme toggle** — a checkbox in the browser chrome swaps CSS custom
///     property overrides on `.app-inner`, flipping between dark and light.
///   • **Swatch hover** — each colour swatch reveals its hex on `:hover` via
///     a `group-hover` overlay (pure Tailwind).
///   • **Pill links** — shipped component pills link to the gallery with a
///     hover-reveal `→` affordance.
///   • **Tooltip parallax** — `mousemove` on `#hero-right` sets `--px`/`--py`
///     CSS custom properties; `.hero-tooltip` reads them via the CSS `translate`
///     property, which composes with the existing float animation `transform`.
class Hero extends StatelessComponent {
  const Hero({super.key});

  @override
  Component build(BuildContext context) => section(
    classes: 'relative min-h-screen overflow-hidden flex items-start lg:items-center',
    [
      // Ambient glow behind everything
      div(classes: 'pointer-events-none absolute inset-0 flex items-center justify-center', [
        div(classes: 'w-[700px] h-[500px] rounded-full bg-brand/8 blur-[120px]', []),
      ]),

      // Background word mark — desktop only, pinned to the bottom of the hero.
      div(
        classes:
            'pointer-events-none select-none '
            'absolute inset-x-0 bottom-0 '
            'hidden lg:flex justify-center overflow-hidden',
        [
          span(
            classes: 'font-display font-bold whitespace-nowrap text-brand',
            attributes: const {
              'style':
                  'font-size: clamp(120px, 24vw, 340px); '
                  'line-height: 0.85; '
                  'letter-spacing: -0.02em; '
                  'opacity: 0.05;',
            },
            [Component.text('DIEVAS')],
          ),
        ],
      ),

      // ── LEFT COLUMN — editorial copy ──────────────────────────────────────
      div(
        classes:
            'relative z-10 flex flex-col w-full '
            'items-center lg:items-start '
            'text-center lg:text-left '
            'px-6 lg:px-0 lg:ml-[max(40px,9vw)] '
            'pt-28 pb-8 lg:pt-24 lg:pb-24 '
            'pr-6 lg:pr-[56%] '
            'opacity-0 animate-[fade-up_0.5s_ease_0.05s_forwards]',
        [
          // Eyebrow
          p(
            classes:
                'section-eyebrow font-display text-sm tracking-[0.16em] uppercase mb-7 '
                'opacity-0 animate-[fade-up_0.6s_ease_0.1s_forwards]',
            [Component.text('✶  Flutter Design System')],
          ),

          // Display headline
          h1(
            classes:
                'font-display text-[clamp(50px,6.5vw,86px)] font-black leading-[0.93] '
                'tracking-[-0.025em] mb-8 '
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
                'max-w-sm font-body font-light text-sm leading-[1.8] '
                'text-text-mid mb-10 '
                'opacity-0 animate-[fade-up_0.7s_ease_0.35s_forwards]',
            [
              Component.text(
                "Dievas ports Moon Design System's component catalogue. "
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
                href: DievasUrls.pubDev,
                attributes: const {'target': '_blank', 'rel': 'noopener'},
                classes:
                    'inline-flex items-center gap-2 '
                    'px-6 py-3 rounded-md '
                    'bg-action text-on-brand '
                    'font-mono text-sm font-medium tracking-wide '
                    'no-underline transition-all duration-200 '
                    'hover:bg-action-hover hover:-translate-y-px '
                    'hover:shadow-[0_8px_32px_rgba(129,140,248,0.35)]',
                [
                  Component.text('View on pub.dev'),
                  span(classes: 'text-xs', [Component.text('→')]),
                ],
              ),
              a(
                href: DievasUrls.gallery,
                attributes: const {'target': '_blank', 'rel': 'noopener'},
                classes:
                    'inline-flex items-center gap-2 '
                    'px-6 py-3 rounded-md '
                    'border border-border-brand text-text-mid '
                    'font-mono text-sm font-normal '
                    'no-underline transition-all duration-200 '
                    'hover:border-brand hover:text-text-hi hover:-translate-y-px',
                [Component.text('Gallery')],
              ),
            ],
          ),

          // Stats
          div(
            classes:
                'flex gap-10 flex-wrap '
                'mt-16 pt-10 border-t border-border '
                'opacity-0 animate-[fade-up_0.7s_ease_0.62s_forwards]',
            [
              _stat('3', 'packages'),
              _stat('2', 'default themes'),
              _stat('16', 'components'),
              _stat('∞', 'brand configs'),
            ],
          ),

          // Mobile word mark — in-flow so it sits directly above the preview.
          div(classes: 'lg:hidden w-full text-center overflow-hidden mt-8 -mb-24', [
            span(
              classes: 'font-display font-bold whitespace-nowrap text-brand',
              attributes: const {
                'style':
                    'font-size: clamp(80px, 24vw, 140px); '
                    'line-height: 0.85; '
                    'letter-spacing: -0.02em; '
                    'opacity: 0.12;',
              },
              [Component.text('DIEVAS')],
            ),
          ]),

          // Mobile preview — static peek, desktop hides this
          div(
            classes:
                'lg:hidden relative w-full mt-10 h-[260px] rounded-2xl overflow-hidden '
                'opacity-0 animate-[fade-up_0.7s_ease_0.72s_forwards]',
            attributes: const {
              'style':
                  'background: linear-gradient(160deg, rgba(28,44,82,1) 0%, rgba(18,28,60,1) 45%, rgba(8,13,32,1) 100%); '
                  'border: 1px solid rgba(129,140,248,0.22); '
                  'box-shadow: inset 0 1px 0 rgba(255,255,255,0.08), '
                  '0 24px 64px rgba(0,0,0,0.6);',
            },
            [
              div(
                classes: 'pointer-events-none absolute top-0 left-0 right-0',
                attributes: const {
                  'style':
                      'height: 140px; '
                      'background: radial-gradient(ellipse 70% 50% at 55% 0%, rgba(129,140,248,0.14) 0%, transparent 75%);',
                },
                [],
              ),
              div(classes: 'absolute inset-0 p-3', [_staticMobilePreview()]),
              div(
                classes: 'pointer-events-none absolute bottom-0 left-0 right-0',
                attributes: const {
                  'style':
                      'height: 96px; '
                      'background: linear-gradient(to bottom, transparent, rgba(8,13,32,0.97));',
                },
                [],
              ),
            ],
          ),
        ],
      ),

      // ── RIGHT CONTAINMENT — the framed region ─────────────────────────────
      // id="hero-right" is the mousemove target for the parallax script.
      div(
        id: 'hero-right',
        classes:
            'absolute hidden lg:block top-[88px] rounded-[32px] overflow-hidden '
            'opacity-0 animate-[fade-up_0.8s_ease_0.4s_forwards]',
        attributes: const {
          'style':
              'left: 45%; right: -32px; bottom: 88px; '
              'background: linear-gradient(160deg, rgba(28,44,82,1) 0%, rgba(18,28,60,1) 45%, rgba(8,13,32,1) 100%); '
              'border: 1px solid rgba(129,140,248,0.22); '
              'box-shadow: inset 0 1px 0 rgba(255,255,255,0.08), '
              '0 0 0 1px rgba(129,140,248,0.06), '
              '0 48px 120px rgba(0,0,0,0.7);',
        },
        [
          // Top screen-edge shine
          div(
            classes: 'pointer-events-none absolute top-0 left-0 right-0',
            attributes: const {
              'style':
                  'height: 1px; '
                  'background: linear-gradient(90deg, transparent 0%, rgba(255,255,255,0.18) 40%, rgba(129,140,248,0.3) 60%, transparent 100%);',
            },
            [],
          ),

          // Inner top radial glow
          div(
            classes: 'pointer-events-none absolute top-0 left-0 right-0',
            attributes: const {
              'style':
                  'height: 280px; '
                  'background: radial-gradient(ellipse 70% 50% at 55% 0%, rgba(129,140,248,0.16) 0%, transparent 75%);',
            },
            [],
          ),

          // Bottom vignette — fades content into the frame's dark base
          div(
            classes: 'pointer-events-none absolute bottom-0 left-0 right-0',
            attributes: const {
              'style':
                  'height: 160px; '
                  'background: linear-gradient(to bottom, transparent, rgba(8,13,32,0.96));',
            },
            [],
          ),

          // App window — interactive mock gallery
          div(classes: 'absolute top-8 left-6 bottom-8', attributes: const {'style': 'right: -36px;'}, [
            _appWindow(),
          ]),

          // Tooltip — top right (.hero-tooltip gets parallax translate)
          div(
            classes:
                'hero-tooltip '
                'absolute top-8 right-20 '
                'bg-bg-elevated border border-border-brand '
                'rounded-xl px-4 py-2.5 '
                'flex items-center gap-2.5 '
                'shadow-[0_8px_32px_rgba(0,0,0,0.5)] '
                'animate-[float-slow_4s_ease-in-out_0.3s_infinite]',
            [
              div(classes: 'w-2 h-2 rounded-full bg-brand flex-shrink-0', []),
              span(classes: 'font-mono text-xs text-text-hi whitespace-nowrap', [Component.text('9 theme aspects')]),
            ],
          ),

          // Tooltip — mid left (.hero-tooltip gets parallax translate, opposing direction)
          div(
            classes:
                'hero-tooltip '
                'absolute bottom-24 left-8 '
                'bg-bg-elevated border border-border '
                'rounded-xl px-4 py-2.5 '
                'flex items-center gap-2.5 '
                'shadow-[0_8px_32px_rgba(0,0,0,0.5)] '
                'animate-[float-slow_4s_ease-in-out_1.8s_infinite]',
            [
              div(classes: 'w-2 h-2 rounded-full bg-[#4ADE80] flex-shrink-0', []),
              span(classes: 'font-mono text-xs text-text-hi whitespace-nowrap', [
                Component.text('Zero hardcoded values'),
              ]),
            ],
          ),
        ],
      ),

      // ── LINK BADGES — in the cut-out below the containment ───────────────
      div(
        classes:
            'absolute hidden lg:flex items-center gap-3 bottom-6 right-8 '
            'opacity-0 animate-[fade-up_0.6s_ease_1.0s_forwards]',
        [
          a(
            href: DievasUrls.portfolio,
            attributes: const {'target': '_blank', 'rel': 'noopener'},
            classes:
                'flex items-center gap-2.5 '
                'bg-bg-elevated border border-border-brand '
                'rounded-xl px-4 py-2.5 '
                'font-mono text-xs text-text-hi no-underline '
                'shadow-[0_8px_32px_rgba(0,0,0,0.5)] '
                'transition-all duration-200 '
                'hover:border-brand hover:text-brand hover:-translate-y-px',
            [
              div(classes: 'w-2 h-2 rounded-full bg-brand flex-shrink-0', []),
              Component.text('Serticode Inc.'),
            ],
          ),
          a(
            href: DievasUrls.moonDs,
            attributes: const {'target': '_blank', 'rel': 'noopener'},
            classes:
                'flex items-center gap-2.5 '
                'bg-bg-elevated border border-border '
                'rounded-xl px-4 py-2.5 '
                'font-mono text-xs text-text-hi no-underline '
                'shadow-[0_8px_32px_rgba(0,0,0,0.5)] '
                'transition-all duration-200 '
                'hover:border-brand/50 hover:text-brand hover:-translate-y-px',
            [
              div(classes: 'w-2 h-2 rounded-full bg-brand/50 flex-shrink-0', []),
              Component.text('Moon DS'),
            ],
          ),
        ],
      ),

      // Parallax script — sets --px/--py on .hero-tooltip elements via mousemove
      RawText(_parallaxScript),
    ],
  );

  // ── Static mobile preview ─────────────────────────────────────────────────
  //
  // Simplified, non-interactive snapshot used exclusively in the `lg:hidden`
  // mobile card. Shares no IDs with _appWindow(), so the radio/checkbox
  // CSS selectors never have duplicate-ID conflicts.

  Component _staticMobilePreview() => div(
    classes:
        'w-full h-full bg-bg-subtle rounded-2xl overflow-hidden '
        'border border-border/50 '
        'shadow-[0_32px_80px_rgba(0,0,0,0.8)]',
    [
      // Minimal browser chrome
      div(classes: 'bg-bg-base border-b border-border/60', [
        div(classes: 'flex items-center justify-between px-4 py-2.5 border-b border-border/30', [
          div(classes: 'flex items-center gap-1.5', [
            div(classes: 'w-2 h-2 rounded-full bg-[#FF5F57]', []),
            div(classes: 'w-2 h-2 rounded-full bg-[#FEBC2E]', []),
            div(classes: 'w-2 h-2 rounded-full bg-[#28C840]', []),
          ]),
          span(classes: 'font-mono text-[9px] text-text-lo tracking-wider', [
            Component.text('dievas / gallery'),
          ]),
          div(classes: 'w-10', []),
        ]),
        div(classes: 'flex items-center justify-center px-4 py-2', [
          div(
            classes:
                'flex-1 max-w-[220px] flex items-center gap-1.5 '
                'px-2.5 py-1 rounded-lg bg-bg-elevated border border-border/50',
            [
              div(classes: 'w-1.5 h-1.5 rounded-full bg-[#4ADE80] flex-shrink-0', []),
              span(classes: 'font-mono text-[9px] text-text-lo truncate', [
                Component.text('dievas.serticode.com/gallery'),
              ]),
            ],
          ),
        ]),
      ]),
      // Static content snapshot — buttons only
      div(classes: 'p-4 flex flex-col gap-3', [
        p(classes: 'font-mono text-[8px] tracking-[0.14em] uppercase text-text-lo', [Component.text('Buttons')]),
        div(classes: 'flex items-center gap-2 flex-wrap', [
          div(
            classes:
                'inline-flex items-center gap-1 px-3 py-1.5 rounded-md '
                'bg-action text-on-brand font-mono text-[10px] font-medium',
            [div(classes: 'w-2 h-2 rounded-sm bg-white/30', []), Component.text('Filled')],
          ),
          div(
            classes:
                'inline-flex items-center px-3 py-1.5 rounded-md '
                'border border-border-brand text-brand font-mono text-[10px]',
            [Component.text('Outlined')],
          ),
          div(classes: 'inline-flex items-center px-3 py-1.5 rounded-md text-text-mid font-mono text-[10px]', [
            Component.text('Ghost'),
          ]),
        ]),
        div(classes: 'border-t border-border/40', []),
        p(classes: 'font-mono text-[8px] tracking-[0.14em] uppercase text-text-lo', [
          Component.text('Colour Tokens'),
        ]),
        div(classes: 'flex items-center gap-1.5 flex-wrap', [
          for (final item in const [
            ('#6366F1', 'action'),
            ('#818CF8', 'brand'),
            ('#4ADE80', 'success'),
            ('#EF4444', 'error'),
          ])
            div(classes: 'flex flex-col items-center gap-0.5', [
              div(
                classes: 'w-7 h-7 rounded-md border border-border/30',
                attributes: {'style': 'background-color: ${item.$1}'},
                [],
              ),
              span(classes: 'font-mono text-[7px] text-text-lo', [Component.text(item.$2)]),
            ]),
        ]),
      ]),
    ],
  );

  // ── App window ─────────────────────────────────────────────────────────────
  //
  // Structure:
  //   outer div  (float animation, border, shadow, overflow-hidden — no bg)
  //     input#app-tab-*  ×4  (radio, sr-only)    ← preceding siblings of .app-inner
  //     input#app-theme      (checkbox, sr-only)  ← preceding sibling of .app-inner
  //     div.app-inner        (bg — themeable skin)
  //       browser chrome     (title bar + url bar + tab bar)
  //       div.tab-panels     (the four content panels)
  //
  // CSS selectors anchor at the inputs and descend into .app-inner:
  //   #app-tab-buttons:checked ~ .app-inner .panel-buttons { display: flex; }
  //   #app-theme:checked       ~ .app-inner { --color-bg-base: <light>; ... }

  Component _appWindow() => div(
    // Outer shell handles visual framing + float animation only.
    // bg is deliberately absent here; .app-inner owns the background so the
    // theme-toggle CSS variable override cascades correctly.
    classes:
        'w-full h-full rounded-2xl overflow-hidden '
        'border border-border/50 '
        'shadow-[0_32px_80px_rgba(0,0,0,0.8),0_0_0_1px_rgba(129,140,248,0.06)] '
        'animate-[float_9s_ease-in-out_infinite]',
    [
      // ── Hidden radio inputs — tab switcher ──────────────────────────────
      input(
        id: 'app-tab-buttons',
        classes: 'sr-only',
        attributes: const {'type': 'radio', 'name': 'app-tab', 'checked': ''},
      ),
      input(
        id: 'app-tab-tokens',
        classes: 'sr-only',
        attributes: const {'type': 'radio', 'name': 'app-tab'},
      ),
      input(
        id: 'app-tab-type',
        classes: 'sr-only',
        attributes: const {'type': 'radio', 'name': 'app-tab'},
      ),
      input(
        id: 'app-tab-status',
        classes: 'sr-only',
        attributes: const {'type': 'radio', 'name': 'app-tab'},
      ),

      // ── Hidden checkbox — theme toggle ───────────────────────────────────
      input(
        id: 'app-theme',
        classes: 'sr-only',
        attributes: const {'type': 'checkbox'},
      ),

      // ── .app-inner — the themeable skin (bg lives here, not on outer div) ─
      div(
        classes: 'app-inner bg-bg-subtle w-full h-full flex flex-col',
        [
          // Browser chrome
          div(classes: 'bg-bg-base border-b border-border/60 flex-shrink-0', [
            // Title bar: traffic lights · title · theme toggle button
            div(
              classes: 'flex items-center justify-between px-5 py-3 border-b border-border/30',
              [
                // Traffic lights
                div(classes: 'flex items-center gap-1.5', [
                  div(classes: 'w-2.5 h-2.5 rounded-full bg-[#FF5F57]', []),
                  div(classes: 'w-2.5 h-2.5 rounded-full bg-[#FEBC2E]', []),
                  div(classes: 'w-2.5 h-2.5 rounded-full bg-[#28C840]', []),
                ]),

                // Window title
                span(
                  classes: 'font-mono text-[10px] text-text-lo tracking-wider',
                  [Component.text('dievas / gallery')],
                ),

                // Theme toggle — label[for=app-theme] is inside .app-inner so
                // `#app-theme:checked ~ .app-inner .theme-*` selectors apply to it.
                label(
                  classes:
                      'theme-toggle-label '
                      'flex items-center gap-1 '
                      'cursor-pointer select-none '
                      'px-2 py-1 rounded-md '
                      'border border-border/40 '
                      'font-mono text-[9px] text-text-lo '
                      'transition-colors duration-200 '
                      'hover:border-brand/50 hover:text-brand',
                  attributes: const {'for': 'app-theme', 'title': 'Toggle light / dark'},
                  [
                    // Dark mode shows sun icon + "light" label (action = switch TO light)
                    span(classes: 'theme-icon-dark', [Component.text('☼')]),
                    span(classes: 'theme-label-dark font-mono text-[9px]', [Component.text(' light')]),
                    // Light mode shows moon icon + "dark" label (action = switch TO dark)
                    span(classes: 'theme-icon-light', [Component.text('◑')]),
                    span(classes: 'theme-label-light font-mono text-[9px]', [Component.text(' dark')]),
                  ],
                ),
              ],
            ),

            // URL bar
            div(classes: 'flex items-center justify-center px-5 py-2', [
              div(
                classes:
                    'flex-1 max-w-[280px] '
                    'flex items-center gap-2 '
                    'px-3 py-1.5 rounded-lg '
                    'bg-bg-elevated border border-border/50',
                [
                  div(classes: 'w-1.5 h-1.5 rounded-full bg-[#4ADE80] flex-shrink-0', []),
                  span(classes: 'font-mono text-[10px] text-text-lo truncate', [
                    Component.text('dievas.serticode.com/gallery'),
                  ]),
                ],
              ),
            ]),

            // Tab bar — four labels, one per radio input
            div(classes: 'flex border-t border-border/20 overflow-x-auto', [
              _tabLabel('app-tab-buttons', 'tab-lbl-buttons', 'Buttons'),
              _tabLabel('app-tab-tokens', 'tab-lbl-tokens', 'Tokens'),
              _tabLabel('app-tab-type', 'tab-lbl-type', 'Type'),
              _tabLabel('app-tab-status', 'tab-lbl-status', 'Status'),
            ]),
          ]),

          // ── Tab panels ─────────────────────────────────────────────────────
          div(classes: 'tab-panels flex-1 overflow-hidden p-5', [
            // BUTTONS panel
            div(classes: 'app-panel panel-buttons flex-col gap-3', [
              _blockLabel('Buttons'),
              div(classes: 'flex items-center gap-2 flex-wrap', [
                div(
                  classes:
                      'inline-flex items-center gap-1.5 px-4 py-2 rounded-md '
                      'bg-action text-on-brand font-mono text-xs font-medium '
                      'transition-shadow duration-200 '
                      'hover:shadow-[0_4px_16px_rgba(99,102,241,0.4)]',
                  [
                    div(classes: 'w-2.5 h-2.5 rounded-sm bg-white/30', []),
                    Component.text('Filled'),
                  ],
                ),
                div(
                  classes:
                      'inline-flex items-center px-4 py-2 rounded-md '
                      'border border-border-brand text-brand font-mono text-xs '
                      'transition-colors duration-200 '
                      'hover:bg-action/10',
                  [Component.text('Outlined')],
                ),
                div(
                  classes:
                      'inline-flex items-center px-4 py-2 rounded-md '
                      'text-text-mid font-mono text-xs '
                      'transition-colors duration-200 '
                      'hover:text-text-hi',
                  [Component.text('Ghost')],
                ),
                div(
                  classes:
                      'inline-flex items-center justify-center w-9 h-9 rounded-md '
                      'border border-border/60 text-text-lo '
                      'transition-colors duration-200 '
                      'hover:border-brand/50 hover:text-brand',
                  [span(classes: 'text-sm', [Component.text('⊞')])],
                ),
              ]),
            ]),

            // TOKENS panel
            div(classes: 'app-panel panel-tokens flex-col gap-3', [
              _blockLabel('Colour Tokens'),
              div(classes: 'flex items-center gap-2 flex-wrap', [
                _swatch('#6366F1', 'action',   hex: '#6366F1'),
                _swatch('#818CF8', 'brand',    hex: '#818CF8'),
                _swatch('#F8FAFC', 'text-hi',  hex: '#F8FAFC'),
                _swatch('#0F172A', 'bg-base',  hex: '#0F172A'),
                _swatch('#334155', 'border',   hex: '#334155'),
                _swatch('#4ADE80', 'success',  hex: '#4ADE80'),
                _swatch('#F59E0B', 'warning',  hex: '#F59E0B'),
                _swatch('#EF4444', 'error',    hex: '#EF4444'),
              ]),
            ]),

            // TYPOGRAPHY panel
            div(classes: 'app-panel panel-type flex-col gap-3', [
              _blockLabel('Typography Scale'),
              div(classes: 'flex flex-col gap-3', [
                div(classes: 'flex items-baseline justify-between', [
                  span(
                    classes: 'font-display text-2xl font-black text-text-hi leading-none',
                    [Component.text('Aa')],
                  ),
                  span(
                    classes: 'font-mono text-[9px] text-text-lo',
                    [Component.text('displayLg · Extended 500')],
                  ),
                ]),
                div(classes: 'border-t border-border/30', []),
                div(classes: 'flex items-baseline justify-between', [
                  span(
                    classes: 'font-body text-lg font-bold text-text-mid leading-none',
                    [Component.text('Aa')],
                  ),
                  span(
                    classes: 'font-mono text-[9px] text-text-lo',
                    [Component.text('headingMd · Maison 500')],
                  ),
                ]),
                div(classes: 'border-t border-border/30', []),
                div(classes: 'flex items-baseline justify-between', [
                  span(classes: 'font-body text-base text-text-mid leading-none', [Component.text('Aa')]),
                  span(
                    classes: 'font-mono text-[9px] text-text-lo',
                    [Component.text('bodyMd · Maison 400')],
                  ),
                ]),
                div(classes: 'border-t border-border/30', []),
                div(classes: 'flex items-baseline justify-between', [
                  span(classes: 'font-mono text-sm text-text-lo leading-none', [Component.text('Aa')]),
                  span(
                    classes: 'font-mono text-[9px] text-text-lo',
                    [Component.text('codeMd · DM Mono 400')],
                  ),
                ]),
              ]),
            ]),

            // STATUS panel
            div(classes: 'app-panel panel-status flex-col gap-3', [
              _blockLabel('Component Status'),
              div(classes: 'flex flex-wrap gap-1.5', [
                for (final c in _shipped) _pill(c, shipped: true),
                for (final c in _wip) _pill(c, shipped: false),
              ]),
            ]),
          ]),
        ],
      ),
    ],
  );

  // ── Helpers ─────────────────────────────────────────────────────────────────

  /// Tab label — a `<label>` that targets a radio input.
  /// The `activeClass` (e.g. `tab-lbl-buttons`) is used by the CSS selector
  /// `#app-tab-buttons:checked ~ .app-inner .tab-lbl-buttons` to highlight it.
  Component _tabLabel(String forId, String activeClass, String text_) => label(
    classes:
        '$activeClass tab-lbl '
        'cursor-pointer whitespace-nowrap '
        'px-4 py-2 '
        'font-mono text-[10px] tracking-wider uppercase '
        'text-text-lo border-b-2 border-transparent '
        'hover:text-text-mid',
    attributes: {'for': forId},
    [Component.text(text_)],
  );

  /// Section block label above a group of content.
  Component _blockLabel(String text_) => p(
    classes: 'font-mono text-[9px] tracking-[0.14em] uppercase text-text-lo',
    [Component.text(text_)],
  );

  /// Colour swatch with hex reveal on hover.
  /// The hover overlay uses Tailwind `group`/`group-hover` utilities — pure CSS.
  Component _swatch(String color, String label, {required String hex}) => div(
    classes: 'flex flex-col items-center gap-1',
    [
      div(
        // `group` turns this div into a hover anchor for child `group-hover:*` classes.
        classes: 'group relative w-9 h-9 rounded-lg border border-border/30 cursor-default',
        attributes: {'style': 'background-color: $color'},
        [
          // Hex reveal overlay — appears on hover
          div(
            classes:
                'absolute inset-0 rounded-lg '
                'bg-black/75 '
                'opacity-0 group-hover:opacity-100 '
                'transition-opacity duration-200 '
                'flex items-center justify-center p-0.5',
            [
              span(
                classes: 'font-mono text-[7px] text-white text-center leading-none',
                [Component.text(hex)],
              ),
            ],
          ),
        ],
      ),
      span(
        classes: 'font-mono text-[8px] text-text-lo text-center leading-tight',
        [Component.text(label)],
      ),
    ],
  );

  /// Component status pill.
  /// Shipped components are wrapped in an `<a>` with a hover-reveal `→` arrow.
  /// WIP components render as an inert `<div>`.
  Component _pill(String name, {required bool shipped}) {
    final dot = div(
      classes: 'w-1 h-1 rounded-full flex-shrink-0 ${shipped ? 'bg-brand' : 'bg-border'}',
      [],
    );
    const baseClasses =
        'group inline-flex items-center gap-1.5 '
        'px-2.5 py-1 '
        'border border-border/50 rounded-full '
        'font-mono text-[9px] text-text-lo';

    if (!shipped) {
      return div(classes: baseClasses, [dot, Component.text(name)]);
    }

    return a(
      href: '${DievasUrls.gallery}#${name.toLowerCase()}',
      attributes: const {'target': '_blank', 'rel': 'noopener'},
      classes:
          '$baseClasses no-underline '
          'transition-colors duration-150 '
          'hover:border-brand/40 hover:text-text-mid',
      [
        dot,
        Component.text(name),
        // Arrow — hidden by default, fades in on hover
        span(
          classes:
              'text-brand text-[8px] ml-0.5 '
              'opacity-0 group-hover:opacity-100 '
              'transition-opacity duration-150',
          [Component.text('→')],
        ),
      ],
    );
  }

  Component _stat(String value, String label) => div(classes: 'flex flex-col gap-1', [
    span(classes: 'font-display text-3xl font-black text-text-hi leading-none', [Component.text(value)]),
    span(classes: 'font-body text-[11px] tracking-[0.12em] uppercase text-text-lo', [Component.text(label)]),
  ]);

  static const _shipped = [
    'FilledButton',
    'OutlinedButton',
    'TextButton',
    'IconButton',
    'Avatar',
    'Badge',
    'Checkbox',
    'Switch',
    'TextArea',
    'TextField',
    'Radio',
    'Tag',
    'Divider',
    'CircularProgress',
    'LinearProgress',
    'Icon',
  ];

  static const _wip = ['BottomSheet', 'Toast', 'Modal', 'Tooltip'];
}

// ── Parallax script ─────────────────────────────────────────────────────────
//
// Listens to mousemove on #hero-right (the right containment frame).
// Sets --px / --py on each .hero-tooltip directly. The CSS `translate` property
// on .hero-tooltip reads these, composing additively with the float animation
// which uses `transform: translateY()`. Both can coexist because `translate`
// and `transform` are separate CSS properties in modern browsers.
//
// Tooltip 0 (top-right "9 theme aspects") shifts in the mouse direction.
// Tooltip 1 (bottom-left "Zero hardcoded values") shifts in the opposing
// direction — the difference in direction/magnitude creates perceived depth.
const _parallaxScript = '''<script>
(function () {
  var el = document.getElementById('hero-right');
  if (!el) return;
  var tips = el.querySelectorAll('.hero-tooltip');
  function update(x, y) {
    if (tips[0]) {
      tips[0].style.setProperty('--px', (x * 10).toFixed(1) + 'px');
      tips[0].style.setProperty('--py', (y *  7).toFixed(1) + 'px');
    }
    if (tips[1]) {
      tips[1].style.setProperty('--px', (x * -8).toFixed(1) + 'px');
      tips[1].style.setProperty('--py', (y * -6).toFixed(1) + 'px');
    }
  }
  el.addEventListener('mousemove', function (e) {
    var r = el.getBoundingClientRect();
    update(
      (e.clientX - r.left)  / r.width  - 0.5,
      (e.clientY - r.top)   / r.height - 0.5
    );
  }, { passive: true });
  el.addEventListener('mouseleave', function () { update(0, 0); });
})();
</script>''';
