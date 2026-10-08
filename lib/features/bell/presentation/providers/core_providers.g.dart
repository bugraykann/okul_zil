
part of 'core_providers.dart';



@ProviderFor(audioService)
final audioServiceProvider = AudioServiceProvider._();

final class AudioServiceProvider
    extends $FunctionalProvider<AudioService, AudioService, AudioService>
    with $Provider<AudioService> {
  AudioServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'audioServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$audioServiceHash();

  @$internal
  @override
  $ProviderElement<AudioService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AudioService create(Ref ref) {
    return audioService(ref);
  }

  Override overrideWithValue(AudioService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AudioService>(value),
    );
  }
}

String _$audioServiceHash() => r'65dbd403796591c75d7ad4a9db885d5865ab899d';

@ProviderFor(timerService)
final timerServiceProvider = TimerServiceProvider._();

final class TimerServiceProvider
    extends $FunctionalProvider<TimerService, TimerService, TimerService>
    with $Provider<TimerService> {
  TimerServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'timerServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$timerServiceHash();

  @$internal
  @override
  $ProviderElement<TimerService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TimerService create(Ref ref) {
    return timerService(ref);
  }

  Override overrideWithValue(TimerService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TimerService>(value),
    );
  }
}

String _$timerServiceHash() => r'47a4512615896defd685fd6217024167ea27cd90';
