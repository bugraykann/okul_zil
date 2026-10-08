import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart' hide Border;

import 'dart:io';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/bell_schedule.dart';
import '../providers/bell_schedule_provider.dart';
import '../widgets/schedule_form_dialog.dart';
import '../widgets/template_generator_dialog.dart';

class SchedulesScreen extends ConsumerStatefulWidget {
  const SchedulesScreen({super.key});

  @override
  ConsumerState<SchedulesScreen> createState() => _SchedulesScreenState();
}

class _SchedulesScreenState extends ConsumerState<SchedulesScreen> {
  int _selectedDay = DateTime.now().weekday;
  List<BellSchedule>? _localSchedules;
  bool _isDirty = false;
  bool _isLoading = true;

  final _days = [
    (1, 'Pzt'),
    (2, 'Sal'),
    (3, 'Çar'),
    (4, 'Per'),
    (5, 'Cum'),
    (6, 'Cmt'),
    (7, 'Paz'),
  ];

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final schedules = await ref.read(bellScheduleProvider.future);
      if (mounted) {
        setState(() {
          _localSchedules = schedules.map((e) => e.copyWith()).toList();
          _isDirty = false;
          _isLoading = false;
        });
      }
    });
  }

  Future<void> _onWillPop() async {
    if (!_isDirty) {
      if (mounted) context.pop();
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kaydedilmemiş Değişiklikler'),
        content: const Text(
          'Yaptığınız değişiklikleri kaydetmeden çıkmak istediğinize emin misiniz?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Çık', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      context.pop();
    }
  }

  Future<void> _saveAll() async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
      await ref
          .read(bellScheduleProvider.notifier)
          .saveSchedules(_localSchedules!);
      if (mounted) {
        Navigator.of(context).pop(); // pop loading
        setState(() {
          _isDirty = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tüm değişiklikler başarıyla kaydedildi.'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Kaydetme başarısız: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedDayName = _days.firstWhere((d) => d.$1 == _selectedDay).$2;

    return PopScope(
      canPop: !_isDirty,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _onWillPop();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Row(
          children: [
            Container(
              width: 260,
              decoration: BoxDecoration(
                color: AppColors.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(10),
                    blurRadius: 4,
                    offset: const Offset(2, 0),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: AppColors.textPrimary,
                            ),
                            onPressed: _onWillPop,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Zil Ayarları',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'GÜNLER',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _days.length,
                        itemBuilder: (context, index) {
                          final day = _days[index];
                          final isSelected = _selectedDay == day.$1;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 4.0,
                            ),
                            child: ListTile(
                              selected: isSelected,
                              selectedTileColor: AppColors.primary.withAlpha(
                                20,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              leading: Icon(
                                Icons.calendar_today,
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                                size: 20,
                              ),
                              title: Text(
                                day.$2,
                                style: TextStyle(
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.textPrimary,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                              onTap: () {
                                setState(() => _selectedDay = day.$1);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 24,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.withAlpha(40)),
                      ),
                    ),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runSpacing: 16,
                      children: [
                        Text(
                          '$selectedDayName Günü Programı',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            OutlinedButton.icon(
                              onPressed: _isLoading
                                  ? null
                                  : () => _confirmDeleteDay(context),
                              icon: const Icon(Icons.delete_outline, size: 20),
                              label: const Text('Günü Sil'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.error,
                                side: const BorderSide(color: AppColors.error),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            OutlinedButton.icon(
                              onPressed: _isLoading
                                  ? null
                                  : () => _confirmDeleteAbsolutelyAll(context),
                              icon: const Icon(Icons.delete_sweep, size: 20),
                              label: const Text('Tüm Zilleri Sil'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.red.shade900,
                                side: BorderSide(color: Colors.red.shade900),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton.icon(
                              onPressed: _isLoading
                                  ? null
                                  : () => _importFromExcel(context),
                              icon: const Icon(Icons.upload_file, size: 20),
                              label: const Text('Excel Aktar'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal.shade600,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: _isLoading
                                  ? null
                                  : () async {
                                      final generated =
                                          await showDialog<List<BellSchedule>>(
                                            context: context,
                                            builder: (context) =>
                                                TemplateGeneratorDialog(
                                                  initialDays: [_selectedDay],
                                                ),
                                          );
                                      if (generated != null &&
                                          generated.isNotEmpty) {
                                        setState(() {
                                          _localSchedules!.addAll(generated);
                                          _isDirty = true;
                                        });
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'Ziller oluşturuldu! Lütfen kaydedin ve ses dosyası ayarlayın.',
                                                  ),
                                                ),
                                              );
                                        }
                                      }
                                    },
                              icon: const Icon(Icons.auto_awesome, size: 20),
                              label: const Text('Şablon'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber.shade700,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton.icon(
                              onPressed: _isLoading
                                  ? null
                                  : () => _showFormDialog(context, null),
                              icon: const Icon(Icons.add, size: 20),
                              label: const Text('Yeni Zil'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton.icon(
                              onPressed: _isDirty ? _saveAll : null,
                              icon: const Icon(Icons.save, size: 20),
                              label: const Text('Kaydet'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isDirty
                                    ? Colors.green.shade600
                                    : Colors.grey,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 16,
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'SAAT',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'AÇIKLAMA',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'SES DOSYASI',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'DURUM',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'İŞLEMLER',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Builder(
                            builder: (context) {
                              final filtered = _localSchedules!
                                  .where((s) => s.days.contains(_selectedDay))
                                  .toList();
                              filtered.sort((a, b) => a.time.compareTo(b.time));

                              if (filtered.isEmpty) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.calendar_today_outlined,
                                        size: 64,
                                        color: Colors.grey.withAlpha(100),
                                      ),
                                      const SizedBox(height: 16),
                                      const Text(
                                        'Bu gün için ayarlanmış zil bulunmuyor.',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }

                              return ListView.separated(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 8,
                                ),
                                itemCount: filtered.length,
                                separatorBuilder: (_, _) =>
                                    const SizedBox(height: 8),
                                itemBuilder: (context, index) {
                                  final schedule = filtered[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.surface,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withAlpha(5),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            schedule.time,
                                            style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            schedule.title,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.audiotrack,
                                                size: 16,
                                                color: Colors.grey,
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  schedule.audioPath
                                                      .split('/')
                                                      .last,
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Switch(
                                              value: schedule.isEnabled,
                                              activeTrackColor: AppColors
                                                  .primary
                                                  .withAlpha(128),
                                              activeThumbColor:
                                                  AppColors.primary,
                                              onChanged: (val) {
                                                setState(() {
                                                  final idx = _localSchedules!
                                                      .indexWhere(
                                                        (s) =>
                                                            s.id == schedule.id,
                                                      );
                                                  if (idx != -1) {
                                                    _localSchedules![idx] =
                                                        schedule.copyWith(
                                                          isEnabled: val,
                                                        );
                                                    _isDirty = true;
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.edit_outlined,
                                                  color: Colors.blueGrey,
                                                ),
                                                onPressed: () =>
                                                    _showFormDialog(
                                                      context,
                                                      schedule,
                                                    ),
                                                tooltip: 'Düzenle',
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.delete_outline,
                                                  color: AppColors.error,
                                                ),
                                                onPressed: () => _confirmDelete(
                                                  context,
                                                  schedule,
                                                ),
                                                tooltip: 'Sil',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showFormDialog(
    BuildContext context,
    BellSchedule? schedule,
  ) async {
    final result = await showDialog<BellSchedule>(
      context: context,
      builder: (_) =>
          ScheduleFormDialog(schedule: schedule, initialDays: [_selectedDay]),
    );

    if (result != null) {
      setState(() {
        if (schedule == null) {
          _localSchedules!.add(result);
        } else {
          final index = _localSchedules!.indexWhere((s) => s.id == result.id);
          if (index != -1) {
            _localSchedules![index] = result;
          }
        }
        _isDirty = true;
      });
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,
    BellSchedule schedule,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Silmek istediğinize emin misiniz?'),
        content: Text('${schedule.time} - ${schedule.title} silinecek.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Sil', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        _localSchedules!.removeWhere((s) => s.id == schedule.id);
        _isDirty = true;
      });
    }
  }

  Future<void> _confirmDeleteDay(BuildContext context) async {
    final dayName = _days.firstWhere((d) => d.$1 == _selectedDay).$2;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$dayName Günü Zillerini Sil'),
        content: Text(
          'Sadece $dayName gününe ayarlanmış bütün ziller silinecek. (Eğer bir zil başka günlere de ayarlıysa, sadece $dayName gününden çıkarılacak). Emin misiniz?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Sil', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        final List<BellSchedule> updated = [];
        for (var s in _localSchedules!) {
          if (s.days.contains(_selectedDay)) {
            final newDays = s.days.where((d) => d != _selectedDay).toList();
            if (newDays.isNotEmpty) {
              updated.add(s.copyWith(days: newDays));
            }
          } else {
            updated.add(s);
          }
        }
        _localSchedules = updated;
        _isDirty = true;
      });
    }
  }

  Future<void> _confirmDeleteAbsolutelyAll(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tüm Zilleri Tamamen Sil'),
        content: const Text(
          'Eklediğiniz BÜTÜN ziller BÜTÜN günlerden silinecek. Bu işlem geri alınamaz. Devam etmek istediğinize emin misiniz?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text(
              'Tamamen Sil',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        _localSchedules!.clear();
        _isDirty = true;
      });
    }
  }

  Future<void> _importFromExcel(BuildContext context) async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );

    if (result == null || result.files.single.path == null) return;

    try {
      final bytes = File(result.files.single.path!).readAsBytesSync();
      final excel = Excel.decodeBytes(bytes);

      List<BellSchedule> importedBells = [];
      int descCol = -1;
      int timeCol = -1;

      for (var table in excel.tables.keys) {
        final sheet = excel.tables[table]!;
        for (var row in sheet.rows) {
          if (descCol == -1 || timeCol == -1) {
            for (int i = 0; i < row.length; i++) {
              final val = row[i]?.value?.toString().toUpperCase() ?? '';
              if (val.contains('AÇIKLAMA')) descCol = i;
              if (val.contains('SAAT')) timeCol = i;
            }
            if (descCol != -1 && timeCol != -1) continue;
          }

          if (descCol == -1 || timeCol == -1) continue;
          if (descCol >= row.length || timeCol >= row.length) continue;

          final titleCell = row[descCol];
          final timeCell = row[timeCol];

          if (titleCell == null || timeCell == null) continue;

          final title = titleCell.value?.toString().trim() ?? '';
          final timeStr = timeCell.value?.toString().trim() ?? '';

          if (title.isEmpty || timeStr.isEmpty) continue;

          String formattedTime = '';
          try {
            String t = timeStr.toUpperCase();
            bool isPM = t.contains('ÖS') || t.contains('PM');
            t = t
                .replaceAll('ÖS', '')
                .replaceAll('ÖÖ', '')
                .replaceAll('AM', '')
                .replaceAll('PM', '')
                .trim();

            final parts = t.split(':');
            if (parts.length >= 2) {
              int h = int.parse(parts[0]);
              int m = int.parse(parts[1]);

              if (isPM && h < 12) h += 12;
              if (!isPM && h == 12) h = 0;

              formattedTime =
                  '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';
            }
          } catch (e) {
            continue;
          }

          if (formattedTime.isNotEmpty) {
            importedBells.add(
              BellSchedule(
                id:
                    DateTime.now().microsecondsSinceEpoch.toString() +
                    title.hashCode.toString(),
                time: formattedTime,
                audioPath: '',
                title: title,
                days: [_selectedDay],
                isEnabled: true,
              ),
            );
          }
        }
        break;
      }

      if (importedBells.isNotEmpty) {
        setState(() {
          _localSchedules!.addAll(importedBells);
          _isDirty = true;
        });

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${importedBells.length} zil aktarıldı. (Zil müziklerini ve kaydetmeyi unutmayın)',
              ),
            ),
          );
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Excelden zil bulunamadı. Sütun adları "AÇIKLAMA" ve "SAAT" olmalı.',
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Hata: $e')));
      }
    }
  }
}
