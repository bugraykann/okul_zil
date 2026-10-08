
part of 'log_provider.dart';



@ProviderFor(LogManager)
final logManagerProvider = LogManagerProvider._();

final class LogManagerProvider
    extends $NotifierProvider<LogManager, List<BellLog>> {
  LogManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'logManagerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$logManagerHash();

  @$internal
  @override
  LogManager create() => LogManager();

  Override overrideWithValue(List<BellLog> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<BellLog>>(value),
    );
  }
}

String _$logManagerHash() => r'b924d9c166246a788b5bf56ba40e159d6167fcd1';

abstract class _$LogManager extends $Notifier<List<BellLog>> {
  List<BellLog> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<BellLog>, List<BellLog>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<BellLog>, List<BellLog>>,
              List<BellLog>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
