export '../enums/fund_category_enum.dart';

import '../enums/fund_category_enum.dart';

/// Entidad de dominio que representa un fondo de inversión disponible.
///
/// Es inmutable; se crea con todos sus campos requeridos.
class FundEntity {
  /// Identificador único del fondo.
  final int id;

  /// Nombre comercial del fondo.
  final String name;

  /// Monto mínimo de inversión requerido, expresado en COP.
  final int minimumAmount;

  /// Categoría del fondo: FPV o FIC.
  final FundCategoryEnum category;

  const FundEntity({
    required this.id,
    required this.name,
    required this.minimumAmount,
    required this.category,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FundEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          minimumAmount == other.minimumAmount &&
          category == other.category;

  @override
  int get hashCode => Object.hash(id, name, minimumAmount, category);
}
