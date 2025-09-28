import 'package:dave_portfolio/features/detail_view/details_screen.dart';
import 'package:dave_portfolio/features/footer_view/footer_section.dart';
import 'package:dave_portfolio/features/projects_view/side_projects_section.dart';
import 'package:dave_portfolio/widget/animated_background.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dave_portfolio/services/url_launcher_service.dart';

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
  final UrlLauncherService _urlLauncherService = UrlLauncherService();

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
                      onPressed: () => _urlLauncherService.launchURL('https://github.com/Davalexis'),
                      icon: const Icon(FontAwesomeIcons.github),
                    ),
                    IconButton(
                      onPressed: () => _urlLauncherService.launchURL('https://X.com/Davalexis11'),
                      icon: const Icon(FontAwesomeIcons.xTwitter),
                    ),
                    IconButton(
                      onPressed: () => _urlLauncherService.launchURL('https://www.linkedin.com/in/david-alex-9331072a8/'),
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
                  child: DetailsScreen(),
                ),
                SliverToBoxAdapter(
                  child: ProjectsSection(),
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