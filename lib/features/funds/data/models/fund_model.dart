import '../../domain/entities/fund_entity.dart';

/// Modelo de datos para serialización/deserialización de fondos.
///
/// Actúa como adaptador entre la fuente de datos (JSON) y la capa de dominio.
/// No extiende [FundEntity]; en su lugar expone [toEntity] para la conversión.
class FundModel {
  final int id;
  final String name;
  final int minimumAmount;

  /// Valor crudo de la categoría tal como viene del JSON (ej. `'FPV'`, `'FIC'`).
  final String category;

  const FundModel({
    required this.id,
    required this.name,
    required this.minimumAmount,
    required this.category,
  });

  /// Crea un [FundModel] desde un mapa JSON proveniente de la API o assets.
  factory FundModel.fromJson(Map<String, dynamic> json) {
    return FundModel(
      id: json['id'] as int,
      name: json['name'] as String,
      minimumAmount: json['minimum_amount'] as int,
      category: json['category'] as String,
    );
  }

  /// Serializa el modelo al formato JSON esperado por la API.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'minimum_amount': minimumAmount,
      'category': category,
    };
  }

  /// Convierte este modelo a la entidad de dominio [FundEntity].
  FundEntity toEntity() {
    return FundEntity(
      id: id,
      name: name,
      minimumAmount: minimumAmount,
      category: category == 'FPV' ? FundCategoryEnum.fpv : FundCategoryEnum.fic,
    );
  }
}
