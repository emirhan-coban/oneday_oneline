import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oneday_oneline/widgets/primary_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _markSplashAsShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('splash_shown', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "1Day1Line",
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: GoogleFonts.jetBrainsMono().fontFamily,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Her gün, bir cümle.",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: GoogleFonts.jetBrainsMono().fontFamily,
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: "Başla",
                onPressed: () async {
                  await _markSplashAsShown();
                  if (mounted) {
                    Navigator.of(context).pushReplacementNamed('/home');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
