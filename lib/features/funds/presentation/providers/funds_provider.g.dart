// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funds_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fundsLocalDatasourceHash() =>
    r'817daaaafffceb98cb252ed6df1b286a5a9fd333';

/// Provider de la fuente de datos local de fondos.
///
/// Copied from [fundsLocalDatasource].
@ProviderFor(fundsLocalDatasource)
final fundsLocalDatasourceProvider =
    AutoDisposeProvider<FundsLocalDatasource>.internal(
      fundsLocalDatasource,
      name: r'fundsLocalDatasourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$fundsLocalDatasourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FundsLocalDatasourceRef = AutoDisposeProviderRef<FundsLocalDatasource>;
String _$getFundsUseCaseHash() => r'8fd42126e5c810b32aefbcd38d5c6378feea7d96';

/// Provider del caso de uso de obtención de fondos.
///
/// Copied from [getFundsUseCase].
@ProviderFor(getFundsUseCase)
final getFundsUseCaseProvider = AutoDisposeProvider<GetFundsUseCase>.internal(
  getFundsUseCase,
  name: r'getFundsUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getFundsUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetFundsUseCaseRef = AutoDisposeProviderRef<GetFundsUseCase>;
String _$subscribeToFundUseCaseHash() =>
    r'f94e4a9eb2d6924860ee248916ddac59a980eae5';

/// Provider del caso de uso de suscripción a un fondo.
///
/// Copied from [subscribeToFundUseCase].
@ProviderFor(subscribeToFundUseCase)
final subscribeToFundUseCaseProvider =
    AutoDisposeProvider<SubscribeToFundUseCase>.internal(
      subscribeToFundUseCase,
      name: r'subscribeToFundUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$subscribeToFundUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SubscribeToFundUseCaseRef =
    AutoDisposeProviderRef<SubscribeToFundUseCase>;
String _$cancelFundSubscriptionUseCaseHash() =>
    r'479d53f985d5393be12ae757dea882ac3c58d44e';

/// Provider del caso de uso de cancelación de suscripción.
///
/// Copied from [cancelFundSubscriptionUseCase].
@ProviderFor(cancelFundSubscriptionUseCase)
final cancelFundSubscriptionUseCaseProvider =
    AutoDisposeProvider<CancelFundSubscriptionUseCase>.internal(
      cancelFundSubscriptionUseCase,
      name: r'cancelFundSubscriptionUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$cancelFundSubscriptionUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CancelFundSubscriptionUseCaseRef =
    AutoDisposeProviderRef<CancelFundSubscriptionUseCase>;
String _$fundsHash() => r'0a0ee1c13190ca470524c59ee37b8457956437fa';

/// FutureProvider que expone de forma reactiva la lista de fondos disponibles.
///
/// Copied from [funds].
@ProviderFor(funds)
final fundsProvider = AutoDisposeFutureProvider<List<FundEntity>>.internal(
  funds,
  name: r'fundsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fundsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FundsRef = AutoDisposeFutureProviderRef<List<FundEntity>>;
String _$fundsRepositoryNotifierHash() =>
    r'd664a8b4a758795610e1afe41ad6521e62380b32';

/// Notifier que mantiene viva la única instancia de [FundsRepositoryImpl].
///
/// [keepAlive: true] garantiza que el repositorio —y su estado en memoria
/// (saldo, portafolio, transacciones)— nunca sea descartado durante la sesión.
/// Se usa [ref.read] para la fuente de datos porque [FundsLocalDatasource]
/// es inmutable; vigilarla provocaría recreaciones en cascada.
///
/// Copied from [FundsRepositoryNotifier].
@ProviderFor(FundsRepositoryNotifier)
final fundsRepositoryNotifierProvider =
    NotifierProvider<FundsRepositoryNotifier, FundsRepository>.internal(
      FundsRepositoryNotifier.new,
      name: r'fundsRepositoryNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$fundsRepositoryNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FundsRepositoryNotifier = Notifier<FundsRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
