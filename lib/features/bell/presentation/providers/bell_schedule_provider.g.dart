// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bell_schedule_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BellScheduleNotifier)
final bellScheduleProvider = BellScheduleNotifierProvider._();

final class BellScheduleNotifierProvider
    extends $AsyncNotifierProvider<BellScheduleNotifier, List<BellSchedule>> {
  BellScheduleNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bellScheduleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bellScheduleNotifierHash();

  @$internal
  @override
  BellScheduleNotifier create() => BellScheduleNotifier();
}

String _$bellScheduleNotifierHash() =>
    r'c45891b8e961fa71b2004a56cfe0b0e7c5755bd7';

abstract class _$BellScheduleNotifier
    extends $AsyncNotifier<List<BellSchedule>> {
  FutureOr<List<BellSchedule>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<BellSchedule>>, List<BellSchedule>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<BellSchedule>>, List<BellSchedule>>,
              AsyncValue<List<BellSchedule>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
