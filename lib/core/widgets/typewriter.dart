import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TypewriterText extends StatefulWidget {
  final List<String> texts;
  final Duration typingSpeed;
  final Duration deletingSpeed;
  final Duration pause;

  const TypewriterText({
    super.key,
    required this.texts,
    this.typingSpeed = const Duration(milliseconds: 70),
    this.deletingSpeed = const Duration(milliseconds: 40),
    this.pause = const Duration(milliseconds: 1500),
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  int _index = 0;
  int _charIndex = 0;
  bool _isDeleting = false;
  String _displayText = "";
  Timer? _timer;

  String get _currentText => widget.texts[_index];

  @override
  void initState() {
    super.initState();
    _startCycle();
  }

  void _startCycle() {
    _timer = Timer.periodic(
      _isDeleting ? widget.deletingSpeed : widget.typingSpeed,
      (timer) {
        final text = _currentText; // always fresh
        if (!mounted) return;
        setState(() {
          if (_isDeleting) {
            // ---------- DELETING ----------
            if (_charIndex > 0) {
              _charIndex--;
              _displayText = text.substring(0, _charIndex);
              return;
            }

            // finished deleting → switch to next text
            _isDeleting = false;
            _index = (_index + 1) % widget.texts.length;
            _charIndex = 0;
            timer.cancel();
            Future.delayed(const Duration(milliseconds: 200), _startCycle);
          } else {
            // ---------- TYPING ----------
            if (_charIndex < text.length) {
              _charIndex++;
              _displayText = text.substring(0, _charIndex);
              return;
            }

            // finished typing → pause → start deleting
            timer.cancel();
            Future.delayed(widget.pause, () {
              _isDeleting = true;
              _startCycle();
            });
          }
        });
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 768 && screenWidth <= 1024;
    final isMobile = screenWidth <= 768;

    return Text(
      _displayText,
      style: GoogleFonts.quicksand(
        fontSize: isMobile ? 28 : (isTablet ? 38 : 48),
        fontWeight: FontWeight.bold,
        color: Colors.amber[400]!,
      ),
    );
  }
}
