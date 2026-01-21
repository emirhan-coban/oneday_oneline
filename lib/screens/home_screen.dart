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
    });
  }

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
                _formattedToday,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Bugünü bir cümle ile anlat.",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withAlpha(77),
                        width: 0.6,
                      ),
                    ),
                    child: TextField(
                      controller: _textController,
                      maxLines: 6,
                      autocorrect: true,
                      keyboardType: TextInputType.multiline,
                      cursorColor: Colors.white,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Metninizi buraya yazın...",
                        hintStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "$_charCount/$_charLimit karakter",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Opacity(
                        opacity:
                            (_hasTodayEntry || _charCount == 0 || _isSaving)
                            ? 0.5
                            : 1,
                        child: IgnorePointer(
                          ignoring:
                              _hasTodayEntry || _charCount == 0 || _isSaving,
                          child: PrimaryButton(
                            label: _hasTodayEntry ? "Kaydedildi" : "Kaydet",
                            onPressed: _saveToday,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      HistoryButton(
                        label: "Geçmiş",
                        onPressed: () {
                          Navigator.pushNamed(context, '/history');
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                _formattedToday,
                style: TextStyle(
                  fontSize: 48,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: Color(0xFF171717),
                ),
              ),
            ],
          ),
        ),
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
    return 'Tarih: ${_today.day} ${months[_today.month - 1]}, ${_today.year}';
  }
}
