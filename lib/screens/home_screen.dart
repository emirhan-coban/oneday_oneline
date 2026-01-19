import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // günün tarihi Tarih: XX Ay Yıl
      // TEXT + METİN ALANI + KELİME SINIRI + BUTON + GEÇMİŞ GÜNLER BUTONU
      // EN ALTA GÜNÜN TARİHİ AMA GÖRÜNMEZ CENTER YAPMAK İÇİN
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tarih: 16 Mayıs, 2005",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: GoogleFonts.jetBrainsMono().fontFamily,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
