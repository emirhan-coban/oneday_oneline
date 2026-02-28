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
        color: Colors.white.withOpacity(0.05),
        border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          splashColor: Colors.white.withOpacity(0.1),
          highlightColor: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
