import 'dart:ui';
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Son 30 Gün',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.4),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background ambient glows
          Positioned(
            top: 50,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF4A00E0).withOpacity(0.08),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),
          // Content
          SafeArea(
            bottom: false,
            child: asyncEntries.when(
              data: (entries) {
                if (entries.isEmpty) {
                  return _EmptyState();
                }
                final sections = _buildSections(entries);
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                  physics: const BouncingScrollPhysics(),
                  itemCount: sections.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 32),
                  itemBuilder: (context, index) {
                    final section = sections[index];
                    return _MonthBlock(section: section);
                  },
                );
              },
              loading: () => Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              error: (err, stack) => _ErrorState(error: err),
            ),
          ),
        ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 16),
          child: Text(
            section.monthLabel,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.9),
              letterSpacing: 0.5,
            ),
          ),
        ),
        ...section.entries.map(
          (entry) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.08),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          _formatDay(entry.date),
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.9),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    entry.content,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.95),
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
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
    return '${date.day} ${months[date.month - 1]}'.toUpperCase();
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history_rounded,
            size: 64,
            color: Colors.white.withOpacity(0.2),
          ),
          const SizedBox(height: 16),
          Text(
            'Henüz kayıt yok',
            style: GoogleFonts.poppins(
              color: Colors.white54,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 64,
            color: Colors.redAccent.withOpacity(0.7),
          ),
          const SizedBox(height: 16),
          Text(
            'Bir şeyler ters gitti',
            style: GoogleFonts.poppins(
              color: Colors.redAccent.withOpacity(0.9),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
