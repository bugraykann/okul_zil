// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_active_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SystemActive)
final systemActiveProvider = SystemActiveProvider._();

final class SystemActiveProvider extends $NotifierProvider<SystemActive, bool> {
  SystemActiveProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'systemActiveProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$systemActiveHash();

  @$internal
  @override
  SystemActive create() => SystemActive();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$systemActiveHash() => r'c77ba397c6831d24dd650d339cb59935e3726841';

abstract class _$SystemActive extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
