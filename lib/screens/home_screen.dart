import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oneday_oneline/widgets/history_button.dart';
import 'package:oneday_oneline/widgets/primary_button.dart';
import 'package:oneday_oneline/data/repositories/entry_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _charLimit = 80;
  late final TextEditingController _textController;
  int _charCount = 0;
  bool _isUpdating = false;
  bool _hasTodayEntry = false;
  bool _isSaving = false;
  late final DateTime _today;
  final EntryRepository _entryRepository = EntryRepository();
  @override
  void initState() {
    super.initState();
    _today = DateTime.now();
    _textController = TextEditingController();
    _textController.addListener(_handleTextChange);
    _loadTodayEntry();
  }

  @override
  void dispose() {
    _textController.removeListener(_handleTextChange);
    _textController.dispose();
    super.dispose();
  }

  void _handleTextChange() {
    if (_isUpdating) return;

    final current = _textController.text;
    if (current.length > _charLimit) {
      _isUpdating = true;
      final trimmed = current.substring(0, _charLimit);
      _textController.value = TextEditingValue(
        text: trimmed,
        selection: TextSelection.collapsed(offset: trimmed.length),
      );
      _isUpdating = false;
    }

    setState(() {
      _charCount = _textController.text.length;
    });
  }

  Future<void> _loadTodayEntry() async {
    final existing = await _entryRepository.getEntryByDate(_today);
    if (mounted) {
      setState(() {
        _hasTodayEntry = existing != null;
      });
    }
  }

  Future<void> _saveToday() async {
    if (_hasTodayEntry || _isSaving || _charCount == 0) return;
    setState(() => _isSaving = true);
    await _entryRepository.saveEntry(_textController.text, DateTime.now());
    if (!mounted) return;
    setState(() {
      _hasTodayEntry = true;
      _isSaving = false;
      _textController.clear();
      _charCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background ambient glows
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),
          Positioned(
            bottom: -150,
            right: -50,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF4A00E0).withOpacity(0.1),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),
          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top Date
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      _formattedToday,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        color: Colors.white54,
                      ),
                    ),
                  ),

                  // Center Card
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Bugünü bir cümle ile anlat.",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: 20,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.surface.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.08),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextField(
                              controller: _textController,
                              maxLines: 5,
                              minLines: 3,
                              autocorrect: true,
                              keyboardType: TextInputType.multiline,
                              cursorColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white.withOpacity(0.9),
                                height: 1.5,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Metninizi buraya yazın...",
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.3),
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "$_charCount/$_charLimit karakter",
                                style: TextStyle(
                                  color: _charCount >= _charLimit
                                      ? Colors.redAccent.withOpacity(0.8)
                                      : Colors.white38,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity:
                                  (_hasTodayEntry ||
                                      _charCount == 0 ||
                                      _isSaving)
                                  ? 0.5
                                  : 1.0,
                              child: PrimaryButton(
                                label: _hasTodayEntry ? "Kaydedildi" : "Kaydet",
                                isLoading: _isSaving,
                                onPressed:
                                    (_hasTodayEntry ||
                                        _charCount == 0 ||
                                        _isSaving)
                                    ? () {}
                                    : _saveToday,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: HistoryButton(
                              label: "Geçmiş",
                              onPressed: () {
                                Navigator.pushNamed(context, '/history');
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Bottom Date (invisible for layout balance)
                  Opacity(
                    opacity: 0,
                    child: Text(
                      _formattedToday,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String get _formattedToday {
    const months = [
      'Ocak',
      'Şubat',
      'Mart',
      'Nisan',
      'Mayıs',
      'Haziran',
      'Temmuz',
      'Ağustos',
      'Eylül',
      'Ekim',
      'Kasım',
      'Aralık',
    ];
    return '${_today.day} ${months[_today.month - 1]} ${_today.year}';
  }
}
