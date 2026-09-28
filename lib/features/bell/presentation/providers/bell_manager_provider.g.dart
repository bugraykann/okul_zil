// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bell_manager_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BellManager)
final bellManagerProvider = BellManagerProvider._();

final class BellManagerProvider
    extends $NotifierProvider<BellManager, BellSchedule?> {
  BellManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bellManagerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bellManagerHash();

  @$internal
  @override
  BellManager create() => BellManager();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BellSchedule? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BellSchedule?>(value),
    );
  }
}

String _$bellManagerHash() => r'2a64ab5f1e4c834ac05c199e23e79e3978271e67';

abstract class _$BellManager extends $Notifier<BellSchedule?> {
  BellSchedule? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<BellSchedule?, BellSchedule?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BellSchedule?, BellSchedule?>,
              BellSchedule?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
