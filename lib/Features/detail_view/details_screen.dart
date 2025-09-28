import 'dart:async';

import 'package:dave_portfolio/util/app_theme.dart';
import 'package:dave_portfolio/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Stream<DateTime> _timeStream;
  late StreamSubscription<DateTime> _timeSubscription;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _timeStream = Stream.periodic(const Duration(seconds: 1), (count) {
      return DateTime.now();
    });
    _timeSubscription = _timeStream.listen((time) {
      setState(() {
        _currentTime = time;
      });
    });
  }

  @override
  void dispose() {
    _timeSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        bool isMobile = width < kMobileBreakpoint;
        bool isTablet = width >= kMobileBreakpoint && width < kTabletBreakpoint;

        double maxContentWidth =
            isMobile ? double.infinity : (isTablet ? 700 : 800);
        double horizontalPadding = isMobile
            ? kMobileHorizontalPadding
            : (isTablet ? kTabletHorizontalPadding : kDesktopHorizontalPadding);
        double heading1Size = isMobile
            ? kMobileHeading1Size
            : (isTablet ? kTabletHeading1Size : kDesktopHeading1Size);
        double heading2Size = isMobile
            ? kMobileHeading2Size
            : (isTablet ? kTabletHeading2Size : kDesktopHeading2Size);
        double bodyTextSize = isMobile
            ? kMobileBodyTextSize
            : (isTablet ? kTabletBodyTextSize : kDesktopBodyTextSize);
        double topPadding = isMobile
            ? kMobileTopPadding
            : (isTablet ? kTabletTopPadding : kDesktopTopPadding);

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
                    DateFormat('h:mm:ss a').format(_currentTime),
                    bodyTextSize,
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

  Widget _buildInfoRow(
    String label,
    String value,
    double textSize,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: textSize - 1,
            color: AppTheme.primaryColor.withOpacity(0.8),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: textSize - 1,
            fontWeight: FontWeight.w500,
            color: AppTheme.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildRichTextInfo({
    required String prefix,
    required String boldText,
    required double textSize,
  }) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.inter(
          fontSize: textSize,
          color: AppTheme.secondaryColor,
          height: 1.5,
        ),
        children: [
          TextSpan(text: "$prefix → "),
          TextSpan(
            text: boldText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}