import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:btg_capital/core/errors/app_exception.dart';
import 'package:btg_capital/features/funds/domain/usecases/get_funds_usecase.dart';

import '../../../../helpers/mocks.mocks.dart';
import '../../../../helpers/test_data.dart';

void main() {
  late MockFundsRepository mockRepository;
  late GetFundsUseCase useCase;

  setUp(() {
    mockRepository = MockFundsRepository();
    useCase = GetFundsUseCase(mockRepository);
  });

  group('GetFundsUseCase', () {
    test('returns Right with funds list when repository succeeds', () async {
      when(mockRepository.getFunds()).thenAnswer((_) async => kTestFunds);

      final result = await useCase();

      expect(result.isRight(), true);
      result.fold((_) => fail('Expected Right'), (funds) {
        expect(funds.length, kTestFunds.length);
        expect(funds, equals(kTestFunds));
      });
      verify(mockRepository.getFunds()).called(1);
    });

    test('returns Right with empty list when no funds are available', () async {
      when(mockRepository.getFunds()).thenAnswer((_) async => []);

      final result = await useCase();

      expect(result.isRight(), true);
      result.fold(
        (_) => fail('Expected Right'),
        (funds) => expect(funds, isEmpty),
      );
    });

    test(
      'returns Left(AppException) when repository throws AppException',
      () async {
        when(mockRepository.getFunds()).thenThrow(const AppException('error'));

        final result = await useCase();

        expect(result.isLeft(), true);
        result.fold(
          (f) => expect(f, isA<AppException>()),
          (_) => fail('Expected Left'),
        );
      },
    );

    test('wraps generic exceptions in Left(AppException)', () async {
      when(mockRepository.getFunds()).thenThrow(Exception('unexpected error'));

      final result = await useCase();

      expect(result.isLeft(), true);
      result.fold(
        (f) => expect(f, isA<AppException>()),
        (_) => fail('Expected Left'),
      );
    });
  });
}
