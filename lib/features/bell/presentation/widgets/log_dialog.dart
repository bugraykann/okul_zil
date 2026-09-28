import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../providers/log_provider.dart';

class LogDialog extends ConsumerWidget {
  const LogDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logs = ref.watch(logManagerProvider);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 600,
        height: 600,
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Zil Çalma Geçmişi',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: () => ref.read(logManagerProvider.notifier).clearLogs(),
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      label: const Text('Geçmişi Temizle', style: TextStyle(color: Colors.red)),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: logs.isEmpty
                  ? const Center(
                      child: Text('Henüz zil çalma kaydı yok.', style: TextStyle(color: Colors.grey)),
                    )
                  : ListView.separated(
                      itemCount: logs.length,
                      separatorBuilder: (context, index) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final log = logs[index];
                        final formattedDate = DateFormat('dd.MM.yyyy - HH:mm:ss').format(log.timestamp);
                        final isManual = log.type == 'manual';
                        
                        return ListTile(
                          leading: Icon(
                            isManual ? Icons.touch_app : Icons.access_time,
                            color: isManual ? Colors.orange : AppColors.primary,
                          ),
                          title: Text(log.message, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(formattedDate),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: isManual ? Colors.orange.withAlpha(20) : AppColors.primary.withAlpha(20),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              isManual ? 'MANUEL' : 'OTOMATİK',
                              style: TextStyle(
                                fontSize: 10,
                                color: isManual ? Colors.orange : AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
