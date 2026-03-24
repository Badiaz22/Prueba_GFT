import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:btg_capital/core/constants/app_constants.dart';
import 'package:btg_capital/core/errors/already_subscribed_exception.dart';
import 'package:btg_capital/core/errors/insufficient_balance_exception.dart';
import 'package:btg_capital/core/errors/minimum_amount_exception.dart';
import 'package:btg_capital/features/funds/domain/entities/portfolio_entry_entity.dart';
import 'package:btg_capital/features/funds/domain/enums/notification_method_enum.dart';
import 'package:btg_capital/features/funds/domain/usecases/subscribe_to_fund_usecase.dart';

import '../../../../helpers/mocks.mocks.dart';
import '../../../../helpers/test_data.dart';

void main() {
  late MockFundsRepository mockRepository;
  late SubscribeToFundUseCase useCase;

  setUp(() {
    mockRepository = MockFundsRepository();
    useCase = SubscribeToFundUseCase(mockRepository);
  });

  group('SubscribeToFundUseCase', () {
    test('should subscribe successfully with valid amount', () async {
      when(mockRepository.getBalance()).thenReturn(AppConstants.initialBalance);
      when(mockRepository.getPortfolio()).thenReturn([]);
      when(
        mockRepository.subscribeToFund(
          fund: anyNamed('fund'),
          amount: anyNamed('amount'),
          notificationMethod: anyNamed('notificationMethod'),
        ),
      ).thenAnswer((_) async {});

      final result = await useCase(
        fund: kTestFundFpv,
        amount: 100000,
        notificationMethod: NotificationMethodEnum.email,
      );

      expect(result, const Right(unit));
      verify(
        mockRepository.subscribeToFund(
          fund: kTestFundFpv,
          amount: 100000,
          notificationMethod: NotificationMethodEnum.email,
        ),
      ).called(1);
    });

    test(
      'returns Left(InsufficientBalanceException) when amount exceeds balance',
      () async {
        when(
          mockRepository.getBalance(),
        ).thenReturn(AppConstants.initialBalance);
        when(mockRepository.getPortfolio()).thenReturn([]);

        final result = await useCase(
          fund: kTestFundFpv,
          amount: 600000,
          notificationMethod: NotificationMethodEnum.email,
        );

        expect(result.isLeft(), true);
        result.fold(
          (f) => expect(f, isA<InsufficientBalanceException>()),
          (_) => fail('Expected Left'),
        );
        verifyNever(
          mockRepository.subscribeToFund(
            fund: anyNamed('fund'),
            amount: anyNamed('amount'),
            notificationMethod: anyNamed('notificationMethod'),
          ),
        );
      },
    );

    test(
      'returns Left(MinimumAmountException) when amount is below fund minimum',
      () async {
        when(
          mockRepository.getBalance(),
        ).thenReturn(AppConstants.initialBalance);
        when(mockRepository.getPortfolio()).thenReturn([]);

        final result = await useCase(
          fund: kTestFundFpv,
          amount: 50000,
          notificationMethod: NotificationMethodEnum.sms,
        );

        expect(result.isLeft(), true);
        result.fold(
          (f) => expect(f, isA<MinimumAmountException>()),
          (_) => fail('Expected Left'),
        );
        verifyNever(
          mockRepository.subscribeToFund(
            fund: anyNamed('fund'),
            amount: anyNamed('amount'),
            notificationMethod: anyNamed('notificationMethod'),
          ),
        );
      },
    );

    test(
      'returns Left(AlreadySubscribedException) when already subscribed',
      () async {
        final existingEntry = PortfolioEntryEntity(
          fund: kTestFundFpv,
          investedAmount: 100000,
          subscribedDate: kFixedDate,
        );
        when(mockRepository.getPortfolio()).thenReturn([existingEntry]);
        when(
          mockRepository.getBalance(),
        ).thenReturn(AppConstants.initialBalance);

        final result = await useCase(
          fund: kTestFundFpv,
          amount: 100000,
          notificationMethod: NotificationMethodEnum.email,
        );

        expect(result.isLeft(), true);
        result.fold(
          (f) => expect(f, isA<AlreadySubscribedException>()),
          (_) => fail('Expected Left'),
        );
        verifyNever(
          mockRepository.subscribeToFund(
            fund: anyNamed('fund'),
            amount: anyNamed('amount'),
            notificationMethod: anyNamed('notificationMethod'),
          ),
        );
      },
    );

    test('passes the chosen notification method to the repository', () async {
      when(mockRepository.getBalance()).thenReturn(AppConstants.initialBalance);
      when(mockRepository.getPortfolio()).thenReturn([]);
      when(
        mockRepository.subscribeToFund(
          fund: anyNamed('fund'),
          amount: anyNamed('amount'),
          notificationMethod: anyNamed('notificationMethod'),
        ),
      ).thenAnswer((_) async {
        return;
      });

      await useCase(
        fund: kTestFundFpv,
        amount: 75000,
        notificationMethod: NotificationMethodEnum.sms,
      );

      verify(
        mockRepository.subscribeToFund(
          fund: kTestFundFpv,
          amount: 75000,
          notificationMethod: NotificationMethodEnum.sms,
        ),
      ).called(1);
    });
  });
}
