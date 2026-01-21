import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oneday_oneline/data/models/day_entry.dart';
import 'package:oneday_oneline/data/providers/entry_provider.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncEntries = ref.watch(recentEntriesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF171717),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Son 30 Gün',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: asyncEntries.when(
                  data: (entries) {
                    if (entries.isEmpty) {
                      return _EmptyState();
                    }
                    final sections = _buildSections(entries);
                    return ListView.separated(
                      itemCount: sections.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        final section = sections[index];
                        return _MonthBlock(section: section);
                      },
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(color: Colors.white54),
                  ),
                  error: (err, stack) => _ErrorState(error: err),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<_MonthSection> _buildSections(List<DayEntry> entries) {
    // entries expected sorted desc by repository; group by month-year
    final List<_MonthSection> sections = [];
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

    _MonthSection? current;

    for (final entry in entries) {
      final monthLabel = '${months[entry.date.month - 1]} ${entry.date.year}';
      if (current == null || current.monthLabel != monthLabel) {
        current = _MonthSection(monthLabel: monthLabel, entries: []);
        sections.add(current);
      }
      current.entries.add(entry);
    }

    return sections;
  }
}

class _MonthSection {
  final String monthLabel;
  final List<DayEntry> entries;

  _MonthSection({required this.monthLabel, required this.entries});
}

class _MonthBlock extends StatelessWidget {
  final _MonthSection section;

  const _MonthBlock({required this.section});

  @override
  Widget build(BuildContext context) {
    final titleStyle = GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );
    final bodyStyle = GoogleFonts.poppins(
      fontSize: 14,
      color: Colors.white,
      height: 1.35,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(section.monthLabel, style: bodyStyle.copyWith(fontSize: 15)),
        const SizedBox(height: 12),
        ...section.entries.map(
          (entry) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F24),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_formatDay(entry.date), style: titleStyle),
                  const SizedBox(height: 8),
                  Text(entry.content, style: bodyStyle),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _formatDay(DateTime date) {
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
    return '${date.day} ${months[date.month - 1]}';
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Henüz kayıt yok',
        style: GoogleFonts.poppins(color: Colors.white70, fontSize: 16),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final Object error;

  const _ErrorState({required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Bir şeyler ters gitti',
        style: GoogleFonts.poppins(color: Colors.redAccent, fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }
}
