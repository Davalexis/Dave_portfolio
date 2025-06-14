import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideProjectsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double width = constraints.maxWidth;
          bool isMobile = width < 600;
          double maxContentWidth =
              isMobile ? double.infinity : (width < 1200 ? 700 : 800);
          double horizontalPadding = isMobile ? 24.0 : 40.0;
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
                    Divider(color: Colors.black.withOpacity(0.2), height: 1),
                    _ProjectItem(
                      imagePath: '',
                      title: 'badi',
                      subtitle: 'Real estate app for finding properties',
                      isMobile: isMobile,
                    ),
                    Divider(color: Colors.black.withOpacity(0.2), height: 1),
                
                    _ProjectItem(
                      imagePath: 'https://via.placeholder.com',
                      title: 'FilmFinder',
                      subtitle: 'Movie discovery app with personalized ratings',
                      isMobile: isMobile,
                    ),
                    Divider(color: Colors.black.withOpacity(0.2), height: 1),
                    _ProjectItem(
                      imagePath: 'https://via.placeholder.com',
                      title: 'Finova',
                      subtitle: 'a phone authentication app flow with Firebase',
                      isMobile: isMobile,
                    ),
                    Divider(color: Colors.black.withOpacity(0.2), height: 1),
                    _ProjectItem(
                      imagePath: 'https://via.placeholder.com',
                      title: 'Quirky',
                      subtitle: 'a to-do list app with Firebase',
                      isMobile: isMobile,
                    ),
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
  final String imagePath;
  final String title;
  final String subtitle;
  final bool isMobile;

  const _ProjectItem({
   
    required this.imagePath,
    required this.title,
    required this.subtitle,
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
          // This is the phone-shaped container
          Container(
            width: imageWidth,
            height: imageWidth * (19.5 / 9), // A common phone aspect ratio
            decoration: BoxDecoration(
              color: Colors.white, // A background color for the phone screen
              border: Border.all(
                color: Colors.black.withOpacity(0.4),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.5),
              child: Image.network(
                imagePath,
                fit: BoxFit.cover, // Fills the container, clipping if necessary
                // Optional: Add a loading builder for a better user experience
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      value:
                          loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(width: isMobile ? 20 : 32),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: isMobile ? 22 : 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: isMobile ? 4 : 8),
                Text(
                  subtitle,
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
              border: Border.all(color: Colors.black, width: 1.5),
            ),
            child: const Icon(Icons.arrow_forward, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
