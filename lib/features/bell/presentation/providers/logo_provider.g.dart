
part of 'logo_provider.dart';



@ProviderFor(LogoController)
final logoControllerProvider = LogoControllerProvider._();

final class LogoControllerProvider
    extends $NotifierProvider<LogoController, String?> {
  LogoControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'logoControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$logoControllerHash();

  @$internal
  @override
  LogoController create() => LogoController();

  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$logoControllerHash() => r'7cafa48af53e33cff39d170154a3756c02bcfffb';

abstract class _$LogoController extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
