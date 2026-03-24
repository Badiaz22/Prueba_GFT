import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:btg_capital/core/errors/fund_not_found_exception.dart';
import 'package:btg_capital/features/funds/domain/entities/portfolio_entry_entity.dart';
import 'package:btg_capital/features/funds/domain/usecases/cancel_fund_subscription_usecase.dart';

import '../../../../helpers/mocks.mocks.dart';
import '../../../../helpers/test_data.dart';

void main() {
  late MockFundsRepository mockRepository;
  late CancelFundSubscriptionUseCase useCase;

  setUp(() {
    mockRepository = MockFundsRepository();
    useCase = CancelFundSubscriptionUseCase(mockRepository);
  });

  group('CancelFundSubscriptionUseCase', () {
    test(
      'returns Right and calls repository when fund is in portfolio',
      () async {
        final entry = PortfolioEntryEntity(
          fund: kTestFundFpv,
          investedAmount: 100000,
          subscribedDate: kFixedDate,
        );
        when(mockRepository.getPortfolio()).thenReturn([entry]);
        when(
          mockRepository.cancelFundSubscription(fundId: anyNamed('fundId')),
        ).thenAnswer((_) async {});

        final result = await useCase(fundId: kTestFundFpv.id);

        expect(result, const Right(unit));
        verify(
          mockRepository.cancelFundSubscription(fundId: kTestFundFpv.id),
        ).called(1);
      },
    );

    test(
      'returns Left(FundNotFoundException) and never calls repository when not subscribed',
      () async {
        when(mockRepository.getPortfolio()).thenReturn([]);

        final result = await useCase(fundId: 999);

        expect(result.isLeft(), true);
        result.fold(
          (f) => expect(f, isA<FundNotFoundException>()),
          (_) => fail('Expected Left'),
        );
        verifyNever(
          mockRepository.cancelFundSubscription(fundId: anyNamed('fundId')),
        );
      },
    );

    test('passes the correct fund ID to the repository', () async {
      final entry = PortfolioEntryEntity(
        fund: kTestFundFpv,
        investedAmount: 100000,
        subscribedDate: kFixedDate,
      );
      when(mockRepository.getPortfolio()).thenReturn([entry]);
      when(
        mockRepository.cancelFundSubscription(fundId: anyNamed('fundId')),
      ).thenAnswer((_) async {
        return;
      });

      await useCase(fundId: kTestFundFpv.id);

      verify(
        mockRepository.cancelFundSubscription(fundId: kTestFundFpv.id),
      ).called(1);
    });
  });
}
