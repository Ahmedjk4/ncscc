import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ncss_code_club/core/widgets/typewriter.dart';
import 'package:ncss_code_club/core/widgets/shared_app_bar.dart';
import 'package:ncss_code_club/core/utils/nav_items.dart';
import 'package:ncss_code_club/core/utils/app_router.dart';
import 'package:ncss_code_club/core/utils/app_theme.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isScrolled = false;
  int _activePageIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 50 && !_isScrolled) {
      setState(() => _isScrolled = true);
    } else if (_scrollController.offset <= 50 && _isScrolled) {
      setState(() => _isScrolled = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 768 && screenWidth <= 1024;
    final isMobile = screenWidth <= 768;

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: isMobile
          ? SharedAppDrawer(
              navItems: navItemsList,
              activeIndex: _activePageIndex,
              onTap: (index) {
                setState(() => _activePageIndex = index);
                Navigator.pop(context);
              },
            )
          : null,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: isMobile ? 420 : (isTablet ? 520 : 640),
                  child: Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/images/hero_background.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppTheme.primaryColor.withValues(alpha: 0.65),
                            AppTheme.primaryColor.withValues(alpha: 0.35),
                            Colors.black.withValues(alpha: 0.05),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 820),
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 20 : 40,
                              vertical: isMobile ? 24 : 40,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.20),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.18),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Welcome to',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: isMobile
                                        ? 24
                                        : (isTablet ? 36 : 44),
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TypewriterText(
                                  texts: ['NCSCC', 'New Cairo STEM Code Club'],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Empowering the next generation of innovators',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: isMobile
                                        ? 13
                                        : (isTablet ? 16 : 18),
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 18),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.amber[400],
                                    foregroundColor: AppTheme.primaryColor,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: isMobile ? 28 : 40,
                                      vertical: isMobile ? 12 : 16,
                                    ),
                                    textStyle: TextStyle(
                                      fontSize: isMobile ? 14 : 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  child: const Text('Join Us Today'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 400,
                  child: Container(
                    color: AppTheme.primaryColor.withValues(alpha: 1),
                    padding: EdgeInsets.all(
                      isMobile ? 20 : (isTablet ? 40 : 64),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Scroll to see the app bar change!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: isMobile ? 16 : 20,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Shared app bar (reusable)
          SharedAppBar(
            isScrolled: _isScrolled,
            activePageIndex: _activePageIndex,
            scaffoldKey: _scaffoldKey,
            onNavTap: (index) {
              switch (index) {
                case 0:
                  context.pushReplacement(AppRouter.home);
                  break;
                case 1:
                  context.pushReplacement(AppRouter.about);
                  break;
                case 2:
                  // Navigate to Projects
                  break;
                case 3:
                  // Navigate to Events
                  break;
                case 4:
                  // Navigate to Team
                  break;
                case 5:
                  // Navigate to Contact
                  break;
              }
            },
          ),
        ],
      ),
    );
  }
}
