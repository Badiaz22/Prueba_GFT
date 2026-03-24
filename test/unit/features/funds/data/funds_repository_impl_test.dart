import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:btg_capital/core/constants/app_constants.dart';
import 'package:btg_capital/features/funds/data/repositories/funds_repository_impl.dart';
import 'package:btg_capital/features/funds/domain/enums/notification_method_enum.dart';
import 'package:btg_capital/features/funds/domain/enums/transaction_type_enum.dart';

import '../../../../helpers/mocks.mocks.dart';
import '../../../../helpers/test_data.dart';

// FundsRepositoryImpl tiene dos responsabilidades que se prueban de forma
// diferente:
//
// 1. getFunds → delega al datasource (I/O). Se usa MockFundsLocalDatasource
//    para aislar el test del archivo JSON real y verificar el contrato con
//    el datasource (verify). En una app con API real, aquí evitaríamos la
//    llamada de red.
//
// 2. Estado en memoria (balance, portfolio, transacciones) → lógica propia
//    del repositorio que no toca el datasource. El mock se inyecta de todos
//    modos para respetar la firma del constructor, pero no se le hace stub.

void main() {
  late MockFundsLocalDatasource mockDatasource;
  late FundsRepositoryImpl repository;

  setUp(() {
    mockDatasource = MockFundsLocalDatasource();
    repository = FundsRepositoryImpl(mockDatasource);
  });

  group('FundsRepositoryImpl', () {
    // ── getFunds: stub the datasource to control the data returned ──────────
    group('getFunds', () {
      test('delegates to datasource and maps models to entities', () async {
        when(
          mockDatasource.getFunds(),
        ).thenAnswer((_) async => [kTestFundModelFpv]);

        final result = await repository.getFunds();

        expect(result.length, 1);
        expect(result.first, equals(kTestFundFpv));
        // verify the repository actually called the datasource (not a cache)
        verify(mockDatasource.getFunds()).called(1);
      });

      test('returns empty list when datasource returns no funds', () async {
        when(mockDatasource.getFunds()).thenAnswer((_) async => []);

        final result = await repository.getFunds();

        expect(result, isEmpty);
        verify(mockDatasource.getFunds()).called(1);
      });
    });

    // ── in-memory state: datasource is not involved ────────────────────────

    group('initial state', () {
      test('balance equals AppConstants.initialBalance', () {
        expect(repository.getBalance(), AppConstants.initialBalance);
      });

      test('portfolio is empty', () {
        expect(repository.getPortfolio(), isEmpty);
      });

      test('transactions list is empty', () {
        expect(repository.getTransactions(), isEmpty);
      });
    });

    group('subscribeToFund', () {
      test('decrements balance by invested amount', () async {
        await repository.subscribeToFund(
          fund: kTestFundFpv,
          amount: 100000,
          notificationMethod: NotificationMethodEnum.email,
        );

        expect(repository.getBalance(), AppConstants.initialBalance - 100000);
      });

      test('adds entry to portfolio', () async {
        await repository.subscribeToFund(
          fund: kTestFundFpv,
          amount: 100000,
          notificationMethod: NotificationMethodEnum.email,
        );

        final portfolio = repository.getPortfolio();
        expect(portfolio.length, 1);
        expect(portfolio.first.fund, equals(kTestFundFpv));
        expect(portfolio.first.investedAmount, 100000);
      });

      test('records subscription transaction', () async {
        await repository.subscribeToFund(
          fund: kTestFundFpv,
          amount: 100000,
          notificationMethod: NotificationMethodEnum.sms,
        );

        final transactions = repository.getTransactions();
        expect(transactions.length, 1);
        expect(transactions.first.type, TransactionTypeEnum.subscription);
        expect(transactions.first.fundId, kTestFundFpv.id);
        expect(
          transactions.first.notificationMethod,
          NotificationMethodEnum.sms,
        );
      });
    });

    group('cancelFundSubscription', () {
      setUp(() async {
        await repository.subscribeToFund(
          fund: kTestFundFpv,
          amount: 100000,
          notificationMethod: NotificationMethodEnum.email,
        );
      });

      test('restores balance after cancellation', () async {
        await repository.cancelFundSubscription(fundId: kTestFundFpv.id);

        expect(repository.getBalance(), AppConstants.initialBalance);
      });

      test('removes entry from portfolio', () async {
        await repository.cancelFundSubscription(fundId: kTestFundFpv.id);

        expect(repository.getPortfolio(), isEmpty);
      });

      test('records cancellation transaction (most recent first)', () async {
        await repository.cancelFundSubscription(fundId: kTestFundFpv.id);

        final transactions = repository.getTransactions();
        expect(transactions.length, 2);
        expect(transactions.first.type, TransactionTypeEnum.cancellation);
      });

      test('does nothing when fund is not in portfolio', () async {
        final balanceBefore = repository.getBalance();
        await repository.cancelFundSubscription(fundId: 999);

        expect(repository.getBalance(), balanceBefore);
        expect(repository.getPortfolio().length, 1);
      });
    });
  });
}
