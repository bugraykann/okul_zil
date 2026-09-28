import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/bell_schedule.dart';
import '../../../../core/constants/app_colors.dart';
import '../providers/core_providers.dart';

class ScheduleFormDialog extends ConsumerStatefulWidget {
  final BellSchedule? schedule;

  const ScheduleFormDialog({super.key, this.schedule});

  @override
  ConsumerState<ScheduleFormDialog> createState() => _ScheduleFormDialogState();
}

class _ScheduleFormDialogState extends ConsumerState<ScheduleFormDialog> {
  late TextEditingController _titleController;
  TimeOfDay? _selectedTime;
  String? _audioPath;
  List<int> _selectedDays = [1, 2, 3, 4, 5]; // Default Mon-Fri

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.schedule?.title ?? '',
    );

    if (widget.schedule != null) {
      final parts = widget.schedule!.time.split(':');
      if (parts.length == 2) {
        _selectedTime = TimeOfDay(
          hour: int.tryParse(parts[0]) ?? 8,
          minute: int.tryParse(parts[1]) ?? 0,
        );
      }
      _audioPath = widget.schedule!.audioPath;
      _selectedDays = List.from(widget.schedule!.days);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? const TimeOfDay(hour: 8, minute: 0),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _pickAudioFile() async {
    final result = await FilePicker.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _audioPath = result.files.single.path;
      });
    }
  }

  void _previewAudio() {
    if (_audioPath != null) {
      ref.read(audioServiceProvider).playAudio(_audioPath!);
    }
  }

  void _save() {
    if (_titleController.text.trim().isEmpty ||
        _selectedTime == null ||
        _audioPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen saat, başlık ve ses dosyası seçiniz.'),
        ),
      );
      return;
    }

    final formattedTime =
        '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}';

    final schedule = BellSchedule(
      id: widget.schedule?.id ?? DateTime.now().toIso8601String(),
      time: formattedTime,
      title: _titleController.text.trim(),
      audioPath: _audioPath!,
      days: _selectedDays,
      isEnabled: widget.schedule?.isEnabled ?? true,
    );

    Navigator.of(context).pop(schedule);
  }

  @override
  Widget build(BuildContext context) {
    final fileName =
        _audioPath?.split(r'\').last.split('/').last ?? 'Dosya Seçilmedi';

    return AlertDialog(
      title: Text(widget.schedule == null ? 'Yeni Zil Ekle' : 'Zili Düzenle'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Zil Başlığı (Örn: Ders Zili)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: _pickTime,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Zil Saati',
                  border: OutlineInputBorder(),
                ),
                child: Text(
                  _selectedTime != null
                      ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
                      : 'Saat Seçiniz',
                ),
              ),
            ),
            const SizedBox(height: 16),
            InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Ses Dosyası',
                border: OutlineInputBorder(),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      fileName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (_audioPath != null)
                    IconButton(
                      icon: const Icon(
                        Icons.play_arrow,
                        color: AppColors.primary,
                      ),
                      onPressed: _previewAudio,
                      tooltip: 'Önizle',
                    ),
                  IconButton(
                    icon: const Icon(Icons.folder_open),
                    onPressed: _pickAudioFile,
                    tooltip: 'Dosya Seç',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Hangi Günler Çalınsın?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                _buildDayChip(1, 'Pzt'),
                _buildDayChip(2, 'Sal'),
                _buildDayChip(3, 'Çar'),
                _buildDayChip(4, 'Per'),
                _buildDayChip(5, 'Cum'),
                _buildDayChip(6, 'Cmt'),
                _buildDayChip(7, 'Paz'),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            ref.read(audioServiceProvider).stopAudio();
            Navigator.of(context).pop();
          },
          child: const Text('İptal'),
        ),
        ElevatedButton(
          onPressed: _save,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          child: const Text('Kaydet'),
        ),
      ],
    );
  }

  Widget _buildDayChip(int dayIndex, String label) {
    final isSelected = _selectedDays.contains(dayIndex);
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          if (selected) {
            _selectedDays.add(dayIndex);
          } else {
            _selectedDays.remove(dayIndex);
          }
        });
      },
      selectedColor: AppColors.primary.withAlpha(100),
      checkmarkColor: AppColors.primary,
    );
  }
}
