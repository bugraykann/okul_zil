// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volume_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VolumeController)
final volumeControllerProvider = VolumeControllerProvider._();

final class VolumeControllerProvider
    extends $NotifierProvider<VolumeController, double> {
  VolumeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'volumeControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$volumeControllerHash();

  @$internal
  @override
  VolumeController create() => VolumeController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(double value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<double>(value),
    );
  }
}

String _$volumeControllerHash() => r'7ad8d5d63b51f4ba60543fb43135d0b603d31093';

abstract class _$VolumeController extends $Notifier<double> {
  double build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<double, double>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<double, double>,
              double,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
