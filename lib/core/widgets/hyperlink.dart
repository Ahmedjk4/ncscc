import 'package:flutter/material.dart';

class Hyperlink extends StatelessWidget {
  const Hyperlink({super.key, required this.dest, required this.text});
  final String dest;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint('Hyperlink tapped');
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichText(
          text: TextSpan(
            text: text,
            style: const TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            // Add gesture recognizer or onTap functionality as needed
          ),
        ),
      ),
    );
  }
}
