// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bell_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BellSchedule _$BellScheduleFromJson(Map<String, dynamic> json) =>
    _BellSchedule(
      id: json['id'] as String,
      time: json['time'] as String,
      audioPath: json['audioPath'] as String,
      title: json['title'] as String,
      days:
          (json['days'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [1, 2, 3, 4, 5],
      isEnabled: json['isEnabled'] as bool? ?? true,
    );

Map<String, dynamic> _$BellScheduleToJson(_BellSchedule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'time': instance.time,
      'audioPath': instance.audioPath,
      'title': instance.title,
      'days': instance.days,
      'isEnabled': instance.isEnabled,
    };
