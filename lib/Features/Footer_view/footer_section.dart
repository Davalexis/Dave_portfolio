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
          bool isMobile = width < 600;
          double maxContentWidth = isMobile ? double.infinity : (width < 1200 ? 700 : 800);
          double horizontalPadding = isMobile ? 24.0 : 40.0;
          double verticalPadding = isMobile ? 48.0 : 96.0;

          return Column(
            children: [
              const Divider(color: Colors.black, thickness: 2, height: 2),
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