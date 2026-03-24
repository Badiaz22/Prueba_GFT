import 'app_exception.dart';

/// Se lanza cuando el usuario intenta suscribirse a un fondo
/// en el que ya tiene una participación activa.
class AlreadySubscribedException extends AppException {
  const AlreadySubscribedException() : super('Ya está suscrito a este fondo');
}
