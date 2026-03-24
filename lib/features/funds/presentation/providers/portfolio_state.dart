import '../../../../core/errors/app_exception.dart';
import '../../domain/entities/portfolio_entry_entity.dart';

/// Estado inmutable del portafolio del usuario.
class PortfolioState {
  /// Saldo disponible actual en COP.
  final int balance;

  /// Lista de fondos activos en el portafolio del usuario.
  final List<PortfolioEntryEntity> entries;

  /// Indica si hay una operación asincrónica en progreso.
  final bool isLoading;

  /// Último error de dominio ocurrido, o `null` si no hay errores.
  final AppException? error;

  const PortfolioState({
    required this.balance,
    this.entries = const [],
    this.isLoading = false,
    this.error,
  });

  PortfolioState copyWith({
    int? balance,
    List<PortfolioEntryEntity>? entries,
    bool? isLoading,
    AppException? error,
  }) {
    return PortfolioState(
      balance: balance ?? this.balance,
      entries: entries ?? this.entries,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
