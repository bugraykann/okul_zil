import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/bell_schedule.dart';
import '../../../../core/constants/app_colors.dart';

class TemplateGeneratorDialog extends ConsumerStatefulWidget {
  final List<int>? initialDays;

  const TemplateGeneratorDialog({super.key, this.initialDays});

  @override
  ConsumerState<TemplateGeneratorDialog> createState() => _TemplateGeneratorDialogState();
}

class _TemplateGeneratorDialogState extends ConsumerState<TemplateGeneratorDialog> {
  final _lessonCountCtrl = TextEditingController(text: '8');
  final _lessonDurationCtrl = TextEditingController(text: '40');
  final _breakDurationCtrl = TextEditingController(text: '10');
  final _lunchAfterLessonCtrl = TextEditingController(text: '4');
  final _lunchDurationCtrl = TextEditingController(text: '50');
  final _studentEntryOffsetCtrl = TextEditingController(text: '2'); // 2 mins before teacher

  TimeOfDay _startTime = const TimeOfDay(hour: 8, minute: 30);
  List<int> _selectedDays = [1, 2, 3, 4, 5];

  @override
  void initState() {
    super.initState();
    if (widget.initialDays != null) {
      _selectedDays = List.from(widget.initialDays!);
    }
  }

  String? _studentAudioPath;
  String? _teacherAudioPath;
  String? _exitAudioPath;

  Future<void> _pickStartTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (picked != null) {
      setState(() => _startTime = picked);
    }
  }

  void _generate() {
    final lessonCount = int.tryParse(_lessonCountCtrl.text) ?? 0;
    final lessonDuration = int.tryParse(_lessonDurationCtrl.text) ?? 40;
    final breakDuration = int.tryParse(_breakDurationCtrl.text) ?? 10;
    final lunchAfter = int.tryParse(_lunchAfterLessonCtrl.text) ?? 4;
    final lunchDuration = int.tryParse(_lunchDurationCtrl.text) ?? 50;
    final offset = int.tryParse(_studentEntryOffsetCtrl.text) ?? 2;

    if (lessonCount <= 0) return;

    List<BellSchedule> generated = [];
    DateTime currentTime = DateTime(2020, 1, 1, _startTime.hour, _startTime.minute);

    for (int i = 1; i <= lessonCount; i++) {
      final studentEntryTime = currentTime.subtract(Duration(minutes: offset));
      generated.add(_createBell(
        title: '$i. Ders Öğrenci Başlama',
        time: studentEntryTime,
        audioPath: _studentAudioPath,
      ));

      generated.add(_createBell(
        title: '$i. Ders Öğretmen Başlama',
        time: currentTime,
        audioPath: _teacherAudioPath,
      ));

      final exitTime = currentTime.add(Duration(minutes: lessonDuration));
      generated.add(_createBell(
        title: '$i. Ders Çıkış',
        time: exitTime,
        audioPath: _exitAudioPath,
      ));

      if (i == lunchAfter) {
        currentTime = exitTime.add(Duration(minutes: lunchDuration));
      } else {
        currentTime = exitTime.add(Duration(minutes: breakDuration));
      }
    }

    Navigator.of(context).pop(generated);
  }

  BellSchedule _createBell({required String title, required DateTime time, String? audioPath}) {
    final formattedTime = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    return BellSchedule(
      id: DateTime.now().microsecondsSinceEpoch.toString() + title.hashCode.toString(),
      time: formattedTime,
      audioPath: audioPath ?? '',
      title: title,
      days: _selectedDays,
      isEnabled: true,
    );
  }

  Future<void> _pickAudio(void Function(String?) onSelected) async {
    final result = await FilePicker.pickFiles(type: FileType.audio, allowMultiple: false);
    if (result != null && result.files.single.path != null) {
      setState(() => onSelected(result.files.single.path));
    }
  }

  Widget _buildAudioSelector(String label, String? currentPath, void Function(String?) onSelected) {
    final fileName = currentPath?.split(r'\').last.split('/').last ?? 'Dosya Seçilmedi';
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InputDecorator(
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        child: Row(
          children: [
            Expanded(child: Text(fileName, maxLines: 1, overflow: TextOverflow.ellipsis)),
            IconButton(
              icon: const Icon(Icons.folder_open),
              onPressed: () => _pickAudio(onSelected),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Otomatik Şablon Oluşturucu'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: _pickStartTime,
              child: InputDecorator(
                decoration: const InputDecoration(labelText: 'İlk Ders Başlama Saati', border: OutlineInputBorder()),
                child: Text('${_startTime.hour.toString().padLeft(2, '0')}:${_startTime.minute.toString().padLeft(2, '0')}'),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: TextField(controller: _lessonCountCtrl, decoration: const InputDecoration(labelText: 'Ders Sayısı', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
                const SizedBox(width: 8),
                Expanded(child: TextField(controller: _lessonDurationCtrl, decoration: const InputDecoration(labelText: 'Ders Süresi (dk)', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: TextField(controller: _breakDurationCtrl, decoration: const InputDecoration(labelText: 'Teneffüs Süresi (dk)', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
                const SizedBox(width: 8),
                Expanded(child: TextField(controller: _studentEntryOffsetCtrl, decoration: const InputDecoration(labelText: 'Giriş Zili Erken (dk)', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: TextField(controller: _lunchAfterLessonCtrl, decoration: const InputDecoration(labelText: 'Öğle Arası (Hangi dersten sonra)', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
                const SizedBox(width: 8),
                Expanded(child: TextField(controller: _lunchDurationCtrl, decoration: const InputDecoration(labelText: 'Öğle Arası Süresi (dk)', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
              ],
            ),
            const SizedBox(height: 16),
            _buildAudioSelector('Öğrenci Giriş Zili Sesi', _studentAudioPath, (p) => _studentAudioPath = p),
            _buildAudioSelector('Öğretmen Zili Sesi', _teacherAudioPath, (p) => _teacherAudioPath = p),
            _buildAudioSelector('Teneffüs / Çıkış Zili Sesi', _exitAudioPath, (p) => _exitAudioPath = p),
            const SizedBox(height: 4),
            const Text('Hangi Günlere Uygulansın?', style: TextStyle(fontWeight: FontWeight.bold)),
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
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('İptal')),
        ElevatedButton(
          onPressed: _generate,
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
          child: const Text('Oluştur'),
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
