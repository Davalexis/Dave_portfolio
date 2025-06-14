import 'package:dave_portfolio/Features/Detail_view/detailsScreen.dart';
import 'package:dave_portfolio/Features/Footer_view/footer_section.dart';
import 'package:dave_portfolio/Features/Projects_view/side_project_view.dart';
import 'package:dave_portfolio/widget/Animated_background.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart'; // <-- IMPORT THE PACKAGE

class LandingPagePortfolio extends StatefulWidget {
  const LandingPagePortfolio({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LandingPagePortfolioState createState() => _LandingPagePortfolioState();
}

class _LandingPagePortfolioState extends State<LandingPagePortfolio>
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

  // HELPER METHOD TO LAUNCH URLS SAFELY
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri, webOnlyWindowName: '_blank');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $url'
          ),
          duration: const Duration(seconds: 4),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          padding: const EdgeInsets.all(16.0),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),

          ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
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
              child: AnimatedBackground(
                cursorPosition: _cursorPosition,
                screenSize: screenSize,
                noiseController: _noiseAnimationController,
              ),
            ),
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: const Text('David Alex'),
                  backgroundColor: Color(0xFF6A7D95).withOpacity(0.1),
                  elevation: 0,
                  // pinned: true,
                  // floating: true,
                  actions: [
                    IconButton(
                      onPressed: () => _launchURL('https://github.com/Davalexis'),
                      icon: const Icon(FontAwesomeIcons.github),
                    ),
                    IconButton(
                      onPressed: () => _launchURL('https://X.com/Davalexis11'),
                      icon: const Icon(FontAwesomeIcons.xTwitter),
                    ),
                    IconButton(
                      onPressed: () => _launchURL('https://www.linkedin.com/in/david-alex-9331072a8/'),
                      icon: const Icon(FontAwesomeIcons.linkedin),
                    ),
                    const SizedBox(width: 8),
                  ],
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(1.0),
                    child: Container(color: Colors.black.withOpacity(0.2), height: 1.0),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Detailsscreen(),
                ),
                SliverToBoxAdapter(
                  child: SideProjectsSection(),
                ),
                SliverToBoxAdapter(
                  child: FooterSection(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}