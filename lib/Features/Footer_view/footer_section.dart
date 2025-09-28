import 'package:dave_portfolio/util/app_theme.dart';
import 'package:dave_portfolio/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

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

          return Column(
            children: [
              const Divider(color: AppTheme.primaryColor, thickness: 2, height: 2),
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxContentWidth),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: verticalPadding,
                    ),
                    child: Column(
                      children: [
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          childAspectRatio: isMobile ? 3.5 : 5.0,
                          children: [
                            _buildFooterLink('About me'),
                            _buildFooterLink('Email'),
                            _buildFooterLink('Resume'),
                            _buildFooterLink('CV'),
                          ],
                        ),
                        SizedBox(height: isMobile ? 48 : 96),
                        Text(
                          'Updated 6/24',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '©Dave _2025',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFooterLink(String text) {
    return Text(
      '→ $text',
      style: GoogleFonts.inter(
        fontSize: 20,
        color: Colors.white.withOpacity(0.9),
      ),
    );
  }
}
