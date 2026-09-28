// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bell_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bellLocalDataSource)
final bellLocalDataSourceProvider = BellLocalDataSourceProvider._();

final class BellLocalDataSourceProvider
    extends
        $FunctionalProvider<
          BellLocalDataSource,
          BellLocalDataSource,
          BellLocalDataSource
        >
    with $Provider<BellLocalDataSource> {
  BellLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bellLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bellLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<BellLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BellLocalDataSource create(Ref ref) {
    return bellLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BellLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BellLocalDataSource>(value),
    );
  }
}

String _$bellLocalDataSourceHash() =>
    r'b90d936a271f183794537ada605c82298fceecdb';

@ProviderFor(bellRepository)
final bellRepositoryProvider = BellRepositoryProvider._();

final class BellRepositoryProvider
    extends $FunctionalProvider<BellRepository, BellRepository, BellRepository>
    with $Provider<BellRepository> {
  BellRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bellRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bellRepositoryHash();

  @$internal
  @override
  $ProviderElement<BellRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BellRepository create(Ref ref) {
    return bellRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BellRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BellRepository>(value),
    );
  }
}

String _$bellRepositoryHash() => r'97d858448ced6aa5449c085d424f6adcc3cae06c';

@ProviderFor(getSchedulesUseCase)
final getSchedulesUseCaseProvider = GetSchedulesUseCaseProvider._();

final class GetSchedulesUseCaseProvider
    extends
        $FunctionalProvider<
          GetSchedulesUseCase,
          GetSchedulesUseCase,
          GetSchedulesUseCase
        >
    with $Provider<GetSchedulesUseCase> {
  GetSchedulesUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getSchedulesUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getSchedulesUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetSchedulesUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetSchedulesUseCase create(Ref ref) {
    return getSchedulesUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetSchedulesUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetSchedulesUseCase>(value),
    );
  }
}

String _$getSchedulesUseCaseHash() =>
    r'79c91f6885a69668ef36d0a36689547b4fde653b';
