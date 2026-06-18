import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Surface colour roles for specialized contexts within the Dievas design system.
///
/// These are distinct from [BackgroundColours] — they describe surfaces with
/// specific functional roles (canvas, code blocks, sidebars, table stripes)
/// rather than the generic background elevation stack.
final class SurfaceColours extends Equatable {
  const SurfaceColours({
    required this.surfaceCanvas,
    required this.surfaceCode,
    required this.surfaceSidebar,
    required this.surfaceTableStriped,
  });

  /// Canvas / drawing surface. Distinguishable from [bgBase] for creative
  /// workspaces, whiteboards, and illustration areas.
  final Color surfaceCanvas;

  /// Code block / inline code background. Visually distinct so code stands
  /// apart from surrounding content.
  final Color surfaceCode;

  /// Sidebar / navigation rail background. Provides a visual anchor for
  /// persistent navigation alongside the main content area.
  final Color surfaceSidebar;

  /// Alternating table row background. Applied to every other row for
  /// horizontal scan ability in data tables and list views.
  final Color surfaceTableStriped;

  SurfaceColours copyWith({
    Color? surfaceCanvas,
    Color? surfaceCode,
    Color? surfaceSidebar,
    Color? surfaceTableStriped,
  }) => SurfaceColours(
    surfaceCanvas: surfaceCanvas ?? this.surfaceCanvas,
    surfaceCode: surfaceCode ?? this.surfaceCode,
    surfaceSidebar: surfaceSidebar ?? this.surfaceSidebar,
    surfaceTableStriped: surfaceTableStriped ?? this.surfaceTableStriped,
  );

  static SurfaceColours lerp(SurfaceColours a, SurfaceColours b, double t) => SurfaceColours(
    surfaceCanvas: Color.lerp(a.surfaceCanvas, b.surfaceCanvas, t)!,
    surfaceCode: Color.lerp(a.surfaceCode, b.surfaceCode, t)!,
    surfaceSidebar: Color.lerp(a.surfaceSidebar, b.surfaceSidebar, t)!,
    surfaceTableStriped: Color.lerp(a.surfaceTableStriped, b.surfaceTableStriped, t)!,
  );

  @override
  List<Object?> get props => [surfaceCanvas, surfaceCode, surfaceSidebar, surfaceTableStriped];
}
