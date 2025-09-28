import 'package:dave_portfolio/models/project.dart';
import 'package:dave_portfolio/util/app_theme.dart';
import 'package:dave_portfolio/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectsSection extends StatelessWidget {
  final List<Project> projects = [
    Project(
      imagePath: '',
      title: 'badi',
      subtitle: 'Real estate app for finding properties',
    ),
    Project(
      imagePath: 'https://via.placeholder.com',
      title: 'FilmFinder',
      subtitle: 'Movie discovery app with personalized ratings',
    ),
    Project(
      imagePath: 'https://via.placeholder.com',
      title: 'Finova',
      subtitle: 'a phone authentication app flow with Firebase',
    ),
    Project(
      imagePath: 'https://via.placeholder.com',
      title: 'Quirky',
      subtitle: 'a to-do list app with Firebase',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double width = constraints.maxWidth;
          bool isMobile = width < kMobileBreakpoint;
          double maxContentWidth =
              isMobile ? double.infinity : (width < kTabletBreakpoint ? 700 : 800);
          double horizontalPadding = isMobile
              ? kMobileHorizontalPadding
              : (width < kTabletBreakpoint
                  ? kTabletHorizontalPadding
                  : kDesktopHorizontalPadding);
          double verticalPadding = isMobile ? 48.0 : 96.0;

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxContentWidth),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Projects",
                      style: GoogleFonts.inter(
                        fontSize: isMobile ? 24 : 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Divider(color: AppTheme.primaryColor.withOpacity(0.2), height: 1),
                    ...projects.map((project) => _ProjectItem(
                          project: project,
                          isMobile: isMobile,
                        )),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ProjectItem extends StatelessWidget {
  final Project project;
  final bool isMobile;

  const _ProjectItem({
    required this.project,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    double imageWidth = isMobile ? 80 : 100;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: imageWidth,
            height: imageWidth * (19.5 / 9),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: AppTheme.primaryColor.withOpacity(0.4),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.5),
              child: Image.network(
                project.imagePath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error, color: AppTheme.primaryColor),
              ),
            ),
          ),
          SizedBox(width: isMobile ? 20 : 32),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.title,
                  style: GoogleFonts.inter(
                    fontSize: isMobile ? 22 : 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: isMobile ? 4 : 8),
                Text(
                  project.subtitle,
                  style: GoogleFonts.inter(
                    fontSize: isMobile ? 16 : 20,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.primaryColor, width: 1.5),
            ),
            child: const Icon(Icons.arrow_forward, color: AppTheme.primaryColor),
          ),
        ],
      ),
    );
  }
}
