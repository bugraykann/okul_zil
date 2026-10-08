
part of 'bell_manager_provider.dart';



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

  Override overrideWithValue(BellSchedule? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BellSchedule?>(value),
    );
  }
}

String _$bellManagerHash() => r'6cc23de0d921f7f856bc43a3ff703a0a3e16c3d3';

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
