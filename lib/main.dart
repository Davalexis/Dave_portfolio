import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.interTextTheme(Theme.of(context).textTheme);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dave portfolio',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        textTheme: textTheme.apply(
          bodyColor: const Color(0xFF1A1A1A),
          displayColor: const Color(0xFF1A1A1A),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: const Color(0xFF1A1A1A)),
          titleTextStyle: textTheme.titleLarge?.copyWith(
            color: const Color(0xFF1A1A1A),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: DaveLeePortfolioPage(),
    );
  }
}

class DaveLeePortfolioPage extends StatefulWidget {
  @override
  _DaveLeePortfolioPageState createState() => _DaveLeePortfolioPageState();
}

class _DaveLeePortfolioPageState extends State<DaveLeePortfolioPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _noiseAnimationController;
  bool _isAnimating = true;
  Offset _cursorPosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    _noiseAnimationController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();
  }

  void _toggleAnimation() {
    setState(() {
      _isAnimating = !_isAnimating;
      if (_isAnimating) {
        _noiseAnimationController.repeat();
      } else {
        _noiseAnimationController.stop();
      }
    });
  }

  void _updateCursorPosition(PointerHoverEvent event) {
    setState(() {
      _cursorPosition = event.localPosition;
    });
  }

  @override
  void dispose() {
    _noiseAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('David Alex'),
        actions: [
          IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.black.withOpacity(0.2), height: 1.0),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleAnimation,
        backgroundColor: Colors.black.withOpacity(0.7),
        child: Icon(
          _isAnimating ? Icons.pause : Icons.play_arrow,
          color: Colors.white,
        ),
      ),
      body: MouseRegion(
        onHover: _updateCursorPosition,
        child: Stack(
          children: [
            Positioned.fill(
              child: _AnimatedBackground(
                cursorPosition: _cursorPosition,
                screenSize: screenSize,
                noiseController: _noiseAnimationController,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  _HeroSection(),
                  _SideProjectsSection(),
                  _FooterSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- SECTIONS ---

class _HeroSection extends StatelessWidget {
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

class _SideProjectsSection extends StatelessWidget {
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
                      imagePath: 'https://i.imgur.com/3ZQFgAm.png',
                      title: 'badi',
                      subtitle: 'Real estate app for finding properties',
                      isMobile: isMobile,
                    ),
                    Divider(color: Colors.black.withOpacity(0.2), height: 1),
                
                    _ProjectItem(
                      imagePath: 'https://i.imgur.com/Y3g3j27.png',
                      title: 'FilmFinder',
                      subtitle: 'Movie discovery app with personalized ratings',
                      isMobile: isMobile,
                    ),
                    Divider(color: Colors.black.withOpacity(0.2), height: 1),
                    _ProjectItem(
                      imagePath: 'https://i.imgur.com/3ZQFgAm.png',
                      title: 'Finova',
                      subtitle: 'a phone authentication app flow with Firebase',
                      isMobile: isMobile,
                    ),
                    Divider(color: Colors.black.withOpacity(0.2), height: 1),
                    _ProjectItem(
                      imagePath: 'https://i.imgur.com/3ZQFgAm.png',
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
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.isMobile,
  }) : super(key: key);

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

class _FooterSection extends StatelessWidget {
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
                            _buildFooterLink('Email'),
                            _buildFooterLink('LinkedIn'),
                            _buildFooterLink('Resume'),
                            _buildFooterLink('GitHub'),
                            _buildFooterLink('Twitter'),
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

// --- BACKGROUND AND NOISE WIDGETS ---
class _AnimatedBackground extends StatelessWidget {
  final Offset cursorPosition;
  final Size screenSize;
  final AnimationController noiseController;

  const _AnimatedBackground({
    Key? key,
    required this.cursorPosition,
    required this.screenSize,
    required this.noiseController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double alignX =
        (screenSize.width > 0)
            ? (cursorPosition.dx / screenSize.width) * 2 - 1
            : 0;
    final double alignY =
        (screenSize.height > 0)
            ? (cursorPosition.dy / screenSize.height) * 2 - 1
            : 0;
    final Alignment gradientCenter = Alignment(alignX, alignY);

    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: gradientCenter,
              radius: 1.5,
              colors: const [
                Color(0xFFADB5C0),
                Color(0xFF8895A5),
                Color(0xFF6A7D95),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        ),
        CustomPaint(
          painter: NoisePainter(animation: noiseController),
          child: Container(),
        ),
      ],
    );
  }
}

class NoisePainter extends CustomPainter {
  final Animation<double> animation;
  NoisePainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withOpacity(0.04);
    final random = Random();
    int numberOfDots = (size.width * size.height * 0.02).toInt();
    for (int i = 0; i < numberOfDots; i++) {
      final double x = random.nextDouble() * size.width;
      final double y = random.nextDouble() * size.height;
      final double radius = random.nextDouble() * 1.0 + 0.5;
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant NoisePainter oldDelegate) =>
      oldDelegate.animation.value != animation.value;
}
