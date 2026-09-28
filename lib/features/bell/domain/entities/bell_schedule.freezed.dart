// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bell_schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BellSchedule {

 String get id; String get time; String get audioPath; String get title; List<int> get days; bool get isEnabled;
/// Create a copy of BellSchedule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BellScheduleCopyWith<BellSchedule> get copyWith => _$BellScheduleCopyWithImpl<BellSchedule>(this as BellSchedule, _$identity);

  /// Serializes this BellSchedule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BellSchedule;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BellSchedule&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.time, _this.time) || other.time == _this.time)&&(identical(other.audioPath, _this.audioPath) || other.audioPath == _this.audioPath)&&(identical(other.title, _this.title) || other.title == _this.title)&&const DeepCollectionEquality().equals(other.days, _this.days)&&(identical(other.isEnabled, _this.isEnabled) || other.isEnabled == _this.isEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BellSchedule;
  return Object.hash(runtimeType,_this.id,_this.time,_this.audioPath,_this.title,const DeepCollectionEquality().hash(_this.days),_this.isEnabled);
}

@override
String toString() {
  final _this = this as BellSchedule;
  return 'BellSchedule(id: ${_this.id}, time: ${_this.time}, audioPath: ${_this.audioPath}, title: ${_this.title}, days: ${_this.days}, isEnabled: ${_this.isEnabled})';
}


}

/// @nodoc
abstract mixin class $BellScheduleCopyWith<$Res>  {
  factory $BellScheduleCopyWith(BellSchedule value, $Res Function(BellSchedule) _then) = _$BellScheduleCopyWithImpl;
@useResult
$Res call({
 String id, String time, String audioPath, String title, List<int> days, bool isEnabled
});




}
/// @nodoc
class _$BellScheduleCopyWithImpl<$Res>
    implements $BellScheduleCopyWith<$Res> {
  _$BellScheduleCopyWithImpl(this._self, this._then);

  final BellSchedule _self;
  final $Res Function(BellSchedule) _then;

/// Create a copy of BellSchedule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? time = null,Object? audioPath = null,Object? title = null,Object? days = null,Object? isEnabled = null,}) {
  return _then(BellSchedule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,audioPath: null == audioPath ? _self.audioPath : audioPath // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<int>,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BellSchedule].
extension BellSchedulePatterns on BellSchedule {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BellSchedule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BellSchedule() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BellSchedule value)  $default,){
final _that = this;
switch (_that) {
case _BellSchedule():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BellSchedule value)?  $default,){
final _that = this;
switch (_that) {
case _BellSchedule() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String time,  String audioPath,  String title,  List<int> days,  bool isEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BellSchedule() when $default != null:
return $default(_that.id,_that.time,_that.audioPath,_that.title,_that.days,_that.isEnabled);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String time,  String audioPath,  String title,  List<int> days,  bool isEnabled)  $default,) {final _that = this;
switch (_that) {
case _BellSchedule():
return $default(_that.id,_that.time,_that.audioPath,_that.title,_that.days,_that.isEnabled);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String time,  String audioPath,  String title,  List<int> days,  bool isEnabled)?  $default,) {final _that = this;
switch (_that) {
case _BellSchedule() when $default != null:
return $default(_that.id,_that.time,_that.audioPath,_that.title,_that.days,_that.isEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BellSchedule implements BellSchedule {
  const _BellSchedule({required this.id, required this.time, required this.audioPath, required this.title,  List<int> days = const [1, 2, 3, 4, 5], this.isEnabled = true}): _days = days;
  factory _BellSchedule.fromJson(Map<String, dynamic> json) => _$BellScheduleFromJson(json);

@override final  String id;
@override final  String time;
@override final  String audioPath;
@override final  String title;
 final  List<int> _days;
@override@JsonKey() List<int> get days {
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_days);
}

@override@JsonKey() final  bool isEnabled;

/// Create a copy of BellSchedule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BellScheduleCopyWith<_BellSchedule> get copyWith => __$BellScheduleCopyWithImpl<_BellSchedule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BellScheduleToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BellSchedule&&(identical(other.id, id) || other.id == id)&&(identical(other.time, time) || other.time == time)&&(identical(other.audioPath, audioPath) || other.audioPath == audioPath)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.days, _days)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,time,audioPath,title,const DeepCollectionEquality().hash(_days),isEnabled);
}

@override
String toString() {
    return 'BellSchedule(id: $id, time: $time, audioPath: $audioPath, title: $title, days: $days, isEnabled: $isEnabled)';
}


}

/// @nodoc
abstract mixin class _$BellScheduleCopyWith<$Res> implements $BellScheduleCopyWith<$Res> {
  factory _$BellScheduleCopyWith(_BellSchedule value, $Res Function(_BellSchedule) _then) = __$BellScheduleCopyWithImpl;
@override @useResult
$Res call({
 String id, String time, String audioPath, String title, List<int> days, bool isEnabled
});




}
/// @nodoc
class __$BellScheduleCopyWithImpl<$Res>
    implements _$BellScheduleCopyWith<$Res> {
  __$BellScheduleCopyWithImpl(this._self, this._then);

  final _BellSchedule _self;
  final $Res Function(_BellSchedule) _then;

/// Create a copy of BellSchedule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? time = null,Object? audioPath = null,Object? title = null,Object? days = null,Object? isEnabled = null,}) {
  return _then(_BellSchedule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,audioPath: null == audioPath ? _self.audioPath : audioPath // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<int>,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
