import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ncss_code_club/core/widgets/shared_app_bar.dart';
import 'package:ncss_code_club/core/utils/nav_items.dart';
import 'package:go_router/go_router.dart';
import 'package:ncss_code_club/core/utils/app_router.dart';

class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isScrolled = false;
  final int _activePageIndex = 1;
  bool _isHovered = false;
  bool _isPressed = false; // Add this new state variable

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
                        child: Center(
                          // Added Center widget
                          child: Text(
                            'About NCSCC',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Wrap(
                        direction: isMobile ? Axis.vertical : Axis.horizontal,
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          MouseRegion(
                            onEnter: (_) => setState(() => _isHovered = true),
                            onExit: (_) => setState(() => _isHovered = false),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              transform: Matrix4.identity()
                                ..translate(
                                  0,
                                  (_isHovered || _isPressed) ? -10.0 : 0.0,
                                ),
                              width: isMobile ? screenWidth : screenWidth * 0.4,
                              padding: const EdgeInsets.all(20.0),
                              child: GestureDetector(
                                onTapDown: (_) =>
                                    setState(() => _isPressed = true),
                                onTapUp: (_) =>
                                    setState(() => _isPressed = false),
                                onTapCancel: () =>
                                    setState(() => _isPressed = false),
                                child: Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      isMobile ? 20 : 16,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          isMobile ? 20 : 16,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.2,
                                            ),
                                            blurRadius: 10,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/HelloWorld.jpg',
                                            width: isMobile
                                                ? screenWidth * 0.8
                                                : 600,
                                            height: isMobile
                                                ? screenWidth * 0.8 * 0.5
                                                : 300,
                                            fit: BoxFit.cover,
                                          ),
                                          Text("Hello World!"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: isMobile ? screenWidth : screenWidth * 0.5,
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText(
                                  '''NCSS Code Club is an educative club founded in NCSS by Ahmed Mohammed, The club is dedicated to fostering a passion for coding and technology among students. Our mission is to provide a supportive environment where young minds can explore, learn, and innovate in the field of computer science.''',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                SelectableText(
                                  '''"We believe hands-on experiences, collaborative projects." 
                          
                          - Mohamed Hossam''',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
