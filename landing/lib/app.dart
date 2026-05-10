import 'package:jaspr/server.dart';
import 'package:jaspr/dom.dart';

import 'components/architecture_section.dart';
import 'components/components_section.dart';
import 'components/footer.dart';
import 'components/hero.dart';
import 'components/nav.dart';

/// Root document component. Renders the complete HTML page.
///
/// Jaspr server renders this on every request. The client JS bundle hydrates
/// any components annotated with [@client].
class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    return Document(
      title: 'Dievas — Flutter Design System',
      lang: 'en',
      meta: const {
        'description':
            'A token-driven Flutter design system porting Moon Design '
            'System. Multi-brand. '
            'InheritedModel-first. Production-ready.',
      },
      head: [
        link(rel: 'preconnect', href: 'https://fonts.googleapis.com'),
        link(rel: 'preconnect', href: 'https://fonts.gstatic.com', attributes: const {'crossorigin': ''}),
        link(
          rel: 'stylesheet',
          href:
              'https://fonts.googleapis.com/css2?family=DM+Mono:wght@300;400;500&family=Syne:wght@400;500;600;700;800&display=swap',
        ),
        link(rel: 'stylesheet', href: '/output.css'),
      ],
      body: const _AppBody(),
    );
  }
}

/// Body content — rendered inside [Document]'s [body].
class _AppBody extends StatelessComponent {
  const _AppBody();

  @override
  Component build(BuildContext context) {
    return div(id: 'main', classes: 'bg-bg-base text-text-hi antialiased', [
      const Nav(),
      const Hero(),
      const ArchitectureSection(),
      const ComponentsSection(),
      const FooterComponent(),
    ]);
  }
}
