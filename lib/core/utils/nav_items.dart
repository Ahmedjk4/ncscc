import 'package:flutter/material.dart';

// Central navigation configuration used across screens.
// Each item now has an `id` (index-like integer), `title` and `icon`.
final List<Map<String, dynamic>> navItemsList = [
  {'id': 0, 'title': 'Home', 'icon': Icons.home},
  {'id': 1, 'title': 'About', 'icon': Icons.info_outline},
  {'id': 2, 'title': 'Projects', 'icon': Icons.work_outline},
  {'id': 3, 'title': 'Events', 'icon': Icons.event},
  {'id': 4, 'title': 'Contact', 'icon': Icons.contact_mail_outlined},
];
