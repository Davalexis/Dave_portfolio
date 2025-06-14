import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Detailsscreen extends StatelessWidget {
  const Detailsscreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        bool isMobile = width < 600;
        bool isTablet = width >= 600 && width < 1200;
        double maxContentWidth =
            isMobile ? double.infinity : (isTablet ? 700 : 800);
        double horizontalPadding = isMobile ? 24.0 : 40.0;
        double heading1Size = isMobile ? 48 : (isTablet ? 60 : 72);
        double heading2Size = isMobile ? 80 : (isTablet ? 92 : 104);
        double bodyTextSize = isMobile ? 16 : (isTablet ? 18 : 20);
        double topPadding = kToolbarHeight + (isMobile ? 24 : 48);

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxContentWidth),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                topPadding,
                horizontalPadding,
                isMobile ? 48.0 : 96.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(
                    "Based in Nigeria",
                    "3:12:33 PM",
                    bodyTextSize,
                    Color(0xFF1A1A1A),
                  ),
                  const SizedBox(height: 12),
                  Divider(color: Colors.black.withOpacity(0.2), height: 1),
                  SizedBox(height: isMobile ? 48 : 64),
                  Text(
                    "Hi, this is",
                    style: GoogleFonts.inter(
                      fontSize: heading1Size,
                      fontWeight: FontWeight.w500,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    "Dave.",
                    style: GoogleFonts.inter(
                      fontSize: heading2Size,
                      fontWeight: FontWeight.w600,
                      height: 1.1,
                    ),
                  ),
                  SizedBox(height: isMobile ? 48 : 64),
                   _buildRichTextInfo(
                    prefix: "Mobile App developer",
                    boldText: "Flutter Developer",
                    textSize: bodyTextSize,
                  ),
                  
                  const SizedBox(height: 20),
                  _buildRichTextInfo(
                    prefix: "Tech stack",
                    boldText: "Flutter • Firebase • Figma • Github",
                    textSize: bodyTextSize,
                  ),
                  const SizedBox(height: 20),
                  _buildRichTextInfo(
                    prefix: "Programming languages",
                    boldText: "Dart",
                    textSize: bodyTextSize,
                  ),
                  const SizedBox(height: 20),
                  _buildRichTextInfo(
                    prefix: "Experience",
                    boldText: "1+ years in mobile app development",
                    textSize: bodyTextSize,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }



//======  // Helper methods to build the UI components
  Widget _buildInfoRow(
    String label,
    String value,
    double textSize,
    Color textColor,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: textSize - 1,
            color: textColor.withOpacity(0.8),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: textSize - 1,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ],
    );
  }


// Builds a RichText widget with a prefix and bold text
  Widget _buildRichTextInfo({
    required String prefix,
    required String boldText,
    required double textSize,
  }) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.inter(
          fontSize: textSize,
          color: Color(0xFF333333),
          height: 1.5,
        ),
        children: [
          TextSpan(text: "$prefix → "),
          TextSpan(
            text: boldText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
        ],
      ),
    );
  }
}