// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transactionsHash() => r'119ed33e33651015ea98279197a5b18f154bec86';

/// Provider reactivo que expone el historial de transacciones del usuario.
///
/// Escucha cambios en [portfolioNotifierProvider] para refrescarse
/// automáticamente tras cada suscripción o cancelación.
///
/// Copied from [transactions].
@ProviderFor(transactions)
final transactionsProvider =
    AutoDisposeProvider<List<TransactionEntity>>.internal(
      transactions,
      name: r'transactionsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$transactionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TransactionsRef = AutoDisposeProviderRef<List<TransactionEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
