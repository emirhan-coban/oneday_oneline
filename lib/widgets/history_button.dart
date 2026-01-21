import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const HistoryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 153,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(13),
        border: Border.all(color: Colors.black.withAlpha(77), width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          splashColor: Colors.white.withAlpha(20),
          highlightColor: Colors.white.withAlpha(13),
          focusColor: Colors.white.withAlpha(10),
          hoverColor: Colors.white.withAlpha(8),
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
