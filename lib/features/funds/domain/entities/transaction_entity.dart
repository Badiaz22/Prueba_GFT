export '../enums/notification_method_enum.dart';
export '../enums/transaction_type_enum.dart';

import '../enums/notification_method_enum.dart';
import '../enums/transaction_type_enum.dart';

/// Entidad de dominio que representa una transacción realizada.
///
/// Puede corresponder tanto a una suscripción como a una cancelación.
class TransactionEntity {
  /// Identificador único de la transacción (ej. `TXN-1234567890`).
  final String id;

  /// ID del fondo asociado a la transacción.
  final int fundId;

  /// Nombre del fondo tal como estaba al momento de la transacción.
  final String fundName;

  /// Monto operado en COP.
  final int amount;

  /// Tipo de operación realizada.
  final TransactionTypeEnum type;

  /// Método de notificación elegido. Puede ser nulo en cancelaciones.
  final NotificationMethodEnum? notificationMethod;

  /// Fecha y hora exacta en que se registró la transacción.
  final DateTime date;

  const TransactionEntity({
    required this.id,
    required this.fundId,
    required this.fundName,
    required this.amount,
    required this.type,
    this.notificationMethod,
    required this.date,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
