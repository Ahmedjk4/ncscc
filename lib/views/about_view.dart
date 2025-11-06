import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ncss_code_club/components/shared_app_bar.dart';
import 'package:ncss_code_club/config/nav_items.dart';
import 'package:go_router/go_router.dart';
import 'package:ncss_code_club/utils/app_router.dart';

class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isScrolled = false;
  int _activePageIndex = 1;

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
    // final isTablet = screenWidth > 768 && screenWidth <= 1024;
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
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 80)),

              SliverList(
                delegate: SliverChildListDelegate(
                  AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 500),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(child: widget),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: const Text(
                          'About Us',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: SelectableText(
                          '''NCSS Code Club is dedicated to fostering a passion for coding and technology among students. Our mission is to provide a supportive environment where young minds can explore, learn, and innovate in the field of computer science.''',
                          style: const TextStyle(fontSize: 16, height: 1.4),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SelectableText(
                          'We believe in empowering the next generation of tech enthusiasts by offering hands-on experiences, collaborative projects, and mentorship from industry professionals.',
                          style: const TextStyle(fontSize: 16, height: 1.4),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              // NOTE: SharedAppBar must NOT be placed directly inside a
              // CustomScrollView.slivers list because it is a regular widget
              // (not a sliver). It is added below as an overlay in the Stack.
            ],
          ),

          // Shared app bar (overlay)
          SharedAppBar(
            isScrolled: _isScrolled,
            activePageIndex: _activePageIndex,
            scaffoldKey: _scaffoldKey,
            onNavTap: (index) {
              switch (index) {
                case 0:
                  context.push(AppRouter.home);
                  break;
                case 1:
                  context.push(AppRouter.about);
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
