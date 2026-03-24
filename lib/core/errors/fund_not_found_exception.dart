import 'app_exception.dart';

/// Se lanza cuando el fondo solicitado no existe en el portafolio activo.
class FundNotFoundException extends AppException {
  const FundNotFoundException() : super('El fondo solicitado no existe');
}
