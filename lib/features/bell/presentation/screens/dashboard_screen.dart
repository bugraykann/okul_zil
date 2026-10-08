import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/router/route_names.dart';
import '../providers/bell_manager_provider.dart';
import '../providers/clock_provider.dart';
import '../providers/bell_schedule_provider.dart';
import '../providers/shared_preferences_provider.dart';

import 'dart:io';

import '../providers/core_providers.dart';
import '../providers/system_active_provider.dart';
import '../providers/volume_provider.dart';
import '../providers/log_provider.dart';
import '../providers/logo_provider.dart';
import '../widgets/log_dialog.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(bellManagerProvider);
    ref.watch(bellScheduleProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 900;

        return Scaffold(
          backgroundColor: AppColors.background,
          drawer: isSmallScreen
              ? Drawer(
                  backgroundColor: AppColors.background,
                  child: SafeArea(child: const _TimelineWidget()),
                )
              : null,
          body: Row(
            children: [
              if (!isSmallScreen)
                Container(
                  width: 320,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withAlpha(25),
                        Colors.transparent,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    border: Border(
                      right: BorderSide(
                        color: AppColors.primary.withAlpha(40),
                        width: 1,
                      ),
                    ),
                  ),
                  child: const _TimelineWidget(),
                ),

              Expanded(
                child: Stack(
                  children: [
                    Consumer(
                      builder: (context, ref, child) {
                        final logoPath = ref.watch(logoControllerProvider);
                        if (logoPath == null || logoPath.isEmpty) {
                          return const SizedBox();
                        }
                        return Positioned.fill(
                          child: Center(
                            child: Opacity(
                              opacity: 0.1,
                              child: Image.file(
                                File(logoPath),
                                fit: BoxFit.contain,
                                width: 400,
                                height: 400,
                                errorBuilder: (context, error, stackTrace) => const SizedBox(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 40,
                            right: 24,
                            left: 24,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              isSmallScreen
                                  ? Builder(
                                      builder: (ctx) => IconButton(
                                        icon: const Icon(
                                          Icons.menu_open_rounded,
                                          color: AppColors.primary,
                                          size: 28,
                                        ),
                                        onPressed: () =>
                                            Scaffold.of(ctx).openDrawer(),
                                      ),
                                    )
                                  : const SizedBox(),

                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.history,
                                      color: AppColors.primary,
                                      size: 28,
                                    ),
                                    tooltip: 'Zil Geçmişi',
                                    onPressed: () => showDialog(
                                      context: context,
                                      builder: (ctx) => const LogDialog(),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.image,
                                      color: AppColors.primary,
                                      size: 28,
                                    ),
                                    tooltip: 'Okul Logosu Yükle',
                                    onPressed: () async {
                                      final result = await FilePicker.pickFiles(
                                        type: FileType.image,
                                      );
                                      if (result != null &&
                                          result.files.single.path != null) {
                                        ref
                                            .read(
                                              logoControllerProvider.notifier,
                                            )
                                            .setLogoPath(
                                              result.files.single.path,
                                            );
                                      }
                                    },
                                  ),
                                  const SizedBox(width: 16),
                                  const _VolumeSliderWidget(),
                                  const SizedBox(width: 16),
                                  const _SystemStatusWidget(),
                                  const SizedBox(width: 16),

                                  IconButton(
                                    icon: const Icon(
                                      Icons.settings,
                                      color: AppColors.primary,
                                      size: 28,
                                    ),
                                    onPressed: () =>
                                        context.push(RouteNames.schedules),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child: Center(
                            child: SingleChildScrollView(
                              padding: EdgeInsets.all(
                                isSmallScreen ? 16.0 : 24.0,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const _CurrentTimeWidget(),
                                  SizedBox(height: isSmallScreen ? 16 : 32),
                                  const _NextBellWidget(),
                                  SizedBox(height: isSmallScreen ? 32 : 48),
                                  const _ManualBellsWidget(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Positioned(
                      bottom: 8,
                      right: 16,
                      child: Text(
                        '© 2026 Buğra Aykan tarafından geliştirildi',
                        style: TextStyle(
                          color: Colors.grey.withAlpha(150),
                          fontSize: 10,
                        ),
                      ),
                    ),
                    
                    Positioned(
                      left: 16,
                      bottom: 16,
                      child: InkWell(
                        onTap: () async {
                          final Uri url = Uri.parse('https://buymeacoffee.com/bgraykn');
                          if (!await launchUrl(url)) {
                            debugPrint('Could not launch $url');
                          }
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFDD00), // BMC Yellow
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(20),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.local_cafe, color: Colors.black, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Buy me a coffee',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TimelineWidget extends ConsumerWidget {
  const _TimelineWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedulesAsync = ref.watch(bellScheduleProvider);
    final clockAsync = ref.watch(clockProvider);
    final nextBell = ref.watch(bellManagerProvider);

    return schedulesAsync.when(
      data: (schedules) {
        return clockAsync.when(
          data: (currentTime) {
            final todaySchedules = schedules
                .where(
                  (s) => s.isEnabled && s.days.contains(currentTime.weekday),
                )
                .toList();
            todaySchedules.sort((a, b) => a.time.compareTo(b.time));

            if (todaySchedules.isEmpty) {
              return const Center(
                child: Text(
                  'Bugün aktif zil yok',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              itemCount: todaySchedules.length,
              itemBuilder: (context, index) {
                final schedule = todaySchedules[index];

                bool isPast = false;
                bool isNext = false;

                if (nextBell != null && nextBell.id == schedule.id) {
                  isNext = true;
                } else {
                  final parts = schedule.time.split(':');
                  final schTime = DateTime(
                    currentTime.year,
                    currentTime.month,
                    currentTime.day,
                    int.tryParse(parts[0]) ?? 0,
                    int.tryParse(parts[1]) ?? 0,
                  );
                  if (schTime.isBefore(currentTime)) {
                    isPast = true;
                  }
                }

                final color = isNext
                    ? AppColors.primary
                    : (isPast
                          ? AppColors.textSecondary.withAlpha(80)
                          : AppColors.textSecondary.withAlpha(160));
                final dotSize = isNext ? 14.0 : 8.0;
                final textWeight = isNext ? FontWeight.bold : FontWeight.w500;
                final lineColor = AppColors.primary.withAlpha(isPast ? 20 : 40);

                return IntrinsicHeight(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                width: 2,
                                color: index == 0
                                    ? Colors.transparent
                                    : lineColor,
                              ),
                            ),
                            Container(
                              width: dotSize,
                              height: dotSize,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: color,
                                boxShadow: isNext
                                    ? [
                                        BoxShadow(
                                          color: AppColors.primary.withAlpha(
                                            100,
                                          ),
                                          blurRadius: 12,
                                          spreadRadius: 4,
                                        ),
                                      ]
                                    : null,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: 2,
                                color: index == todaySchedules.length - 1
                                    ? Colors.transparent
                                    : lineColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                schedule.time,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: color,
                                  fontWeight: textWeight,
                                ),
                              ),
                              Text(
                                schedule.title,
                                style: TextStyle(fontSize: 14, color: color),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, _) => const SizedBox(),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, _) => const SizedBox(),
    );
  }
}

class _CurrentTimeWidget extends ConsumerWidget {
  const _CurrentTimeWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clockStream = ref.watch(clockProvider);

    return clockStream.when(
      data: (time) {
        final formatted = DateFormat('HH:mm:ss').format(time);
        return Column(
          children: [
            const Text('Sistem Saati', style: AppTextStyles.bodySecondary),
            const SizedBox(height: 8),
            Text(
              formatted,
              style: AppTextStyles.heading1.copyWith(fontSize: 48),
            ),
          ],
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (_, _) => const Text('Saat alınamadı', style: AppTextStyles.body),
    );
  }
}

class _NextBellWidget extends ConsumerWidget {
  const _NextBellWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nextBell = ref.watch(bellManagerProvider);
    final clockAsync = ref.watch(clockProvider);
    final isSystemActive = ref.watch(systemActiveProvider);

    if (!isSystemActive) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
        decoration: BoxDecoration(
          color: Colors.red.withAlpha(15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.red.withAlpha(50)),
        ),
        child: Column(
          children: [
            const Icon(
              Icons.notifications_paused_outlined,
              size: 48,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            const Text(
              'TATİL MODU',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Otomatik ziller ve sayaç durduruldu.',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );
    }

    if (nextBell == null) {
      return const Text(
        'Sıradaki zil bulunamadı veya bugünün programı bitti.',
        style: AppTextStyles.bodySecondary,
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text('Sıradaki Zil', style: AppTextStyles.bodySecondary),
          const SizedBox(height: 8),
          Text(
            nextBell.time,
            style: AppTextStyles.heading2.copyWith(
              color: AppColors.primary,
              fontSize: 32,
            ),
          ),
          const SizedBox(height: 4),
          Text(nextBell.title, style: AppTextStyles.body),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          clockAsync.when(
            data: (currentTime) {
              final parts = nextBell.time.split(':');
              var nextTime = DateTime(
                currentTime.year,
                currentTime.month,
                currentTime.day,
                int.tryParse(parts[0]) ?? 0,
                int.tryParse(parts[1]) ?? 0,
              );

              if (nextTime.isBefore(currentTime)) {
                nextTime = nextTime.add(const Duration(days: 1));
              }

              final diff = nextTime.difference(currentTime);
              final h = diff.inHours.toString().padLeft(2, '0');
              final m = (diff.inMinutes % 60).toString().padLeft(2, '0');
              final s = (diff.inSeconds % 60).toString().padLeft(2, '0');

              return Column(
                children: [
                  const Text(
                    'Kalan Süre',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$h:$m:$s',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                      color: AppColors.primary,
                    ),
                  ),
                ],
              );
            },
            loading: () => const SizedBox(),
            error: (_, _) => const SizedBox(),
          ),
        ],
      ),
    );
  }
}

class _ManualBellsWidget extends ConsumerWidget {
  const _ManualBellsWidget();

  Future<void> _playManualBell(
    BuildContext context,
    WidgetRef ref,
    String prefKey,
    String title,
  ) async {
    final prefs = ref.read(sharedPreferencesProvider);
    final path = prefs.getString(prefKey);
    final audioService = ref.read(audioServiceProvider);

    if (path == null || path.isEmpty) {
      final result = await FilePicker.pickFiles(type: FileType.audio);
      if (result != null && result.files.single.path != null) {
        prefs.setString(prefKey, result.files.single.path!);
        audioService.playAudio(result.files.single.path!, isManual: true);
        ref
            .read(logManagerProvider.notifier)
            .addLog('$title (Manuel)', type: 'manual');
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title için ses dosyası seçilmedi.')),
          );
        }
      }
    } else {
      audioService.playAudio(path, isManual: true);
      ref
          .read(logManagerProvider.notifier)
          .addLog('$title (Manuel)', type: 'manual');
    }
  }

  Future<void> _changeManualBell(
    BuildContext context,
    WidgetRef ref,
    String prefKey,
    String title,
  ) async {
    final prefs = ref.read(sharedPreferencesProvider);
    final result = await FilePicker.pickFiles(type: FileType.audio);
    if (result != null && result.files.single.path != null) {
      prefs.setString(prefKey, result.files.single.path!);
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$title sesi güncellendi.')));
      }
    }
  }

  Widget _buildManualButton(
    BuildContext context,
    WidgetRef ref,
    String title,
    IconData icon,
    Color color,
    String prefKey,
  ) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => _playManualBell(context, ref, prefKey, title),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        TextButton(
          onPressed: () => _changeManualBell(context, ref, prefKey, title),
          child: const Text(
            'Sesi Değiştir',
            style: TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: [
        _buildManualButton(
          context,
          ref,
          'Öğrenci Giriş',
          Icons.school,
          Colors.blue,
          'manual_student_bell',
        ),
        _buildManualButton(
          context,
          ref,
          'Teneffüs',
          Icons.celebration,
          Colors.green,
          'manual_break_bell',
        ),
        _buildManualButton(
          context,
          ref,
          'İstiklal Marşı',
          Icons.flag,
          Colors.red.shade700,
          'manual_anthem',
        ),
        _buildManualButton(
          context,
          ref,
          'Sözsüz İstiklal Marşı',
          Icons.music_note,
          Colors.red.shade900,
          'manual_anthem_instrumental',
        ),
        Column(
          children: [
            ElevatedButton(
              onPressed: () {
                ref.read(audioServiceProvider).stopAudio();
                ref
                    .read(logManagerProvider.notifier)
                    .addLog('Sistem Susturuldu', type: 'manual');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.stop_circle_outlined),
                  SizedBox(width: 8),
                  Text(
                    'ZİLİ SUSTUR',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 36), // Align with other buttons
          ],
        ),
      ],
    );
  }
}

class _SystemStatusWidget extends ConsumerWidget {
  const _SystemStatusWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = ref.watch(systemActiveProvider);

    return Container(
      decoration: BoxDecoration(
        color: isActive ? Colors.green.withAlpha(20) : Colors.red.withAlpha(20),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive
              ? Colors.green.withAlpha(100)
              : Colors.red.withAlpha(100),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isActive ? Icons.notifications_active : Icons.notifications_off,
            color: isActive ? Colors.green : Colors.red,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            isActive ? 'Sistem Aktif' : 'Tatil Modu',
            style: TextStyle(
              color: isActive ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 12),
          Switch(
            value: isActive,
            onChanged: (_) {
              ref.read(systemActiveProvider.notifier).toggle();
            },
            activeThumbColor: Colors.green,
            activeTrackColor: Colors.green.withAlpha(50),
            inactiveThumbColor: Colors.red,
            inactiveTrackColor: Colors.red.withAlpha(50),
          ),
        ],
      ),
    );
  }
}

class _VolumeSliderWidget extends ConsumerWidget {
  const _VolumeSliderWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final volume = ref.watch(volumeControllerProvider);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withAlpha(20)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            volume == 0
                ? Icons.volume_off
                : (volume < 0.5 ? Icons.volume_down : Icons.volume_up),
            color: AppColors.primary,
            size: 20,
          ),
          SizedBox(
            width: 100,
            child: Slider(
              value: volume,
              min: 0.0,
              max: 1.0,
              activeColor: AppColors.primary,
              inactiveColor: AppColors.primary.withAlpha(50),
              onChanged: (val) {
                ref.read(volumeControllerProvider.notifier).setVolume(val);
              },
            ),
          ),
        ],
      ),
    );
  }
}
