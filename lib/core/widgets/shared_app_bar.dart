import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ncss_code_club/core/utils/nav_items.dart';
import 'package:ncss_code_club/core/utils/app_theme.dart';

class SharedAppBar extends StatelessWidget {
  final bool isScrolled;
  final int activePageIndex;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final ValueChanged<int>? onNavTap;

  const SharedAppBar({
    super.key,
    required this.isScrolled,
    required this.activePageIndex,
    this.scaffoldKey,
    this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1024;
    final isTablet = screenWidth > 768 && screenWidth <= 1024;
    final isMobile = screenWidth <= 768;

    return ClipRect(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: 80,
        decoration: BoxDecoration(
          color: isScrolled ? AppTheme.primaryColor : Colors.black87,
          boxShadow: isScrolled
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
          border: Border(
            bottom: BorderSide(
              color: Colors.white.withValues(alpha: isScrolled ? 0.1 : 0.2),
              width: 1,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : (isTablet ? 32 : 40),
          ),
          child: Row(
            children: [
              // Logo
              _buildLogo(isMobile),
              const Spacer(),
              // Nav items on larger screens
              if (!isMobile) ...[
                if (isDesktop) ..._buildNavItems(isDesktop),
                if (isDesktop) const SizedBox(width: 32),
                if (isDesktop)
                  _buildActionButton(
                    'Join Club',
                    Colors.amber[400]!,
                    AppTheme.primaryColor,
                    isMobile,
                  ),
                if (isDesktop) const SizedBox(width: 12),
                if (isDesktop)
                  _buildActionButton(
                    'Login',
                    Colors.transparent,
                    Colors.white,
                    isMobile,
                    outlined: true,
                  ),
              ],
              // Hamburger
              if (isMobile || isTablet)
                IconButton(
                  icon: Icon(Icons.menu, color: Colors.white, size: 28),
                  onPressed: () => scaffoldKey?.currentState?.openEndDrawer(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(bool isMobile) {
    return Row(
      children: [
        Container(
          width: isMobile ? 45 : 50,
          height: isMobile ? 45 : 50,
          decoration: BoxDecoration(
            color: Colors.amber[400],
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.amber[400]!.withValues(alpha: 0.3),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Icon(
            Icons.code,
            color: AppTheme.primaryColor,
            size: isMobile ? 24 : 28,
          ),
        ),
        if (!isMobile) const SizedBox(width: 16),
        if (!isMobile)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'New Cairo STEM',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Code Club',
                style: GoogleFonts.montserrat(
                  color: Colors.amber[400],
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
      ],
    );
  }

  List<Widget> _buildNavItems(bool isDesktop) {
    return navItemsList.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      final title = item['title'] as String;
      final isActive = index == activePageIndex;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => onNavTap?.call(index),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: isActive
                    ? BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(18),
                      )
                    : null,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                    color: isActive ? Colors.amber[400] : Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 4,
                width: isActive ? 28 : 6,
                decoration: BoxDecoration(
                  color: isActive ? Colors.amber[400] : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _buildActionButton(
    String text,
    Color bgColor,
    Color textColor,
    bool isMobile, {
    bool outlined = false,
  }) {
    return SizedBox(
      height: isMobile ? 38 : 42,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: outlined ? Colors.transparent : bgColor,
          foregroundColor: textColor,
          side: outlined
              ? BorderSide(color: Colors.white.withValues(alpha: 0.8), width: 2)
              : null,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 28,
            vertical: 12,
          ),
          elevation: outlined ? 0 : 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: isMobile ? 13 : 14,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

// Reusable drawer widget for mobile/tablet. Can be used by any screen that
// uses `SharedAppBar` to keep the drawer UI in one place.
class SharedAppDrawer extends StatelessWidget {
  final List<Map<String, dynamic>> navItems;
  final int activeIndex;
  final ValueChanged<int> onTap;

  const SharedAppDrawer({
    super.key,
    required this.navItems,
    required this.activeIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.primaryColor,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.amber[400],
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.code, color: AppTheme.primaryColor, size: 40),
              ),
              const SizedBox(height: 12),
              Text(
                'New Cairo STEM',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Code Club',
                style: GoogleFonts.montserrat(
                  color: Colors.amber[400],
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Divider(color: Colors.white.withValues(alpha: 0.2)),

              // Navigation items
              ..._buildDrawerItems(context),

              Divider(color: Colors.white.withValues(alpha: 0.2)),

              // Action buttons in drawer
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber[400],
                          foregroundColor: AppTheme.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Join Club',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: BorderSide(color: Colors.white, width: 2),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDrawerItems(BuildContext context) {
    return navItems.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      final title = item['title'] as String;
      final isActive = index == activeIndex;
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: isActive
            ? BoxDecoration(
                color: Colors.white.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(12),
              )
            : null,
        child: ListTile(
          leading: Icon(
            item['icon'] as IconData,
            color: isActive ? Colors.amber[400] : Colors.white,
          ),
          title: Text(
            title,
            style: TextStyle(
              color: isActive ? Colors.amber[400] : Colors.white,
              fontSize: 16,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          onTap: () {
            onTap(index);
          },
        ),
      );
    }).toList();
  }
}
