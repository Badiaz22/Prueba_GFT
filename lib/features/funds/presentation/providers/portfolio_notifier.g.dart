// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$portfolioNotifierHash() => r'42ef1a60b746efc630cb3836bf8370213aa05d77';

/// Notifier que gestiona el estado del portafolio del usuario.
///
/// Expone operaciones de suscripción y cancelación que retornan
/// [Either<AppException, Unit>] en lugar de lanzar excepciones.
///
/// Copied from [PortfolioNotifier].
@ProviderFor(PortfolioNotifier)
final portfolioNotifierProvider =
    NotifierProvider<PortfolioNotifier, PortfolioState>.internal(
      PortfolioNotifier.new,
      name: r'portfolioNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$portfolioNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PortfolioNotifier = Notifier<PortfolioState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
