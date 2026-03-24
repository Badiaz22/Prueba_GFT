/// Constantes globales compartidas en toda la aplicación.
///
/// La clase no puede instanciarse; todos sus miembros son estáticos.
class AppConstants {
  AppConstants._();

  /// Saldo inicial del usuario en COP al arrancar la aplicación.
  static const int initialBalance = 500000;

  /// Símbolo de la moneda utilizado en la formatación de importes.
  static const String currencySymbol = 'COP';

  /// Retardo en milisegundos que simula la latencia de una llamada a la API.
  static const int apiSimulatedDelay = 700;
}
