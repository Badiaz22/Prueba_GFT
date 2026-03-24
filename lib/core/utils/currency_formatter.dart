import 'package:intl/intl.dart';

/// Utilidad estática para formatear valores enteros como moneda colombiana (COP).
///
/// No puede instanciarse; se usa a través del método estático [format].
class CurrencyFormatter {
  CurrencyFormatter._();

  /// Formateador con separadores de miles en español (Colombia).
  static final _formatter = NumberFormat('#,###', 'es_CO');

  /// Convierte [amount] a una cadena con formato de moneda COP.
  ///
  /// Ejemplo: `500000` → `'COP $500.000'`.
  static String format(int amount) {
    return 'COP \$${_formatter.format(amount)}';
  }
}
