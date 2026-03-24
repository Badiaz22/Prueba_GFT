import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:btg_capital/core/constants/app_constants.dart';
import 'package:btg_capital/core/errors/already_subscribed_exception.dart';
import 'package:btg_capital/core/errors/fund_not_found_exception.dart';
import 'package:btg_capital/core/errors/insufficient_balance_exception.dart';
import 'package:btg_capital/features/funds/domain/enums/notification_method_enum.dart';
import 'package:btg_capital/features/funds/presentation/providers/funds_provider.dart';
import 'package:btg_capital/features/funds/presentation/providers/portfolio_notifier.dart';

import '../../../../helpers/fake_funds_repository.dart';
import '../../../../helpers/test_data.dart';

/// Minimal [FundsRepositoryNotifier] subclass that delegates to a
/// [FakeFundsRepository], allowing tests to isolate [PortfolioNotifier]
/// without requiring a real datasource.
class _FakeRepositoryNotifier extends FundsRepositoryNotifier {
  _FakeRepositoryNotifier(this._repo);
  final FakeFundsRepository _repo;

  @override
  build() => _repo;
}

void main() {
  late FakeFundsRepository fakeRepo;
  late ProviderContainer container;

  setUp(() {
    fakeRepo = FakeFundsRepository(balance: AppConstants.initialBalance);
    container = ProviderContainer(
      overrides: [
        fundsRepositoryNotifierProvider.overrideWith(
          () => _FakeRepositoryNotifier(fakeRepo),
        ),
      ],
    );
    addTearDown(container.dispose);
  });

  group('PortfolioNotifier', () {
    test('initial state has default balance and empty portfolio', () {
      final state = container.read(portfolioNotifierProvider);
      expect(state.balance, AppConstants.initialBalance);
      expect(state.entries, isEmpty);
      expect(state.isLoading, false);
      expect(state.error, isNull);
    });

    test('subscribe updates balance and portfolio on success', () async {
      final notifier = container.read(portfolioNotifierProvider.notifier);
      final result = await notifier.subscribe(
        fund: kTestFundFpv,
        amount: 100000,
        notificationMethod: NotificationMethodEnum.email,
      );

      expect(result.isRight(), true);
      final state = container.read(portfolioNotifierProvider);
      expect(state.balance, AppConstants.initialBalance - 100000);
      expect(state.entries.length, 1);
      expect(state.entries.first.fund, kTestFundFpv);
      expect(state.isLoading, false);
      expect(state.error, isNull);
    });

    test(
      'subscribe returns Left(InsufficientBalanceException) when amount exceeds balance',
      () async {
        final notifier = container.read(portfolioNotifierProvider.notifier);
        final result = await notifier.subscribe(
          fund: kTestFundFpv,
          amount: 600000,
          notificationMethod: NotificationMethodEnum.email,
        );

        expect(result.isLeft(), true);
        result.fold(
          (f) => expect(f, isA<InsufficientBalanceException>()),
          (_) => fail('Expected Left'),
        );
        expect(
          container.read(portfolioNotifierProvider).error,
          isA<InsufficientBalanceException>(),
        );
      },
    );

    test(
      'subscribe returns Left(AlreadySubscribedException) on duplicate subscription',
      () async {
        final notifier = container.read(portfolioNotifierProvider.notifier);
        await notifier.subscribe(
          fund: kTestFundFpv,
          amount: 100000,
          notificationMethod: NotificationMethodEnum.email,
        );
        final result = await notifier.subscribe(
          fund: kTestFundFpv,
          amount: 100000,
          notificationMethod: NotificationMethodEnum.email,
        );

        expect(result.isLeft(), true);
        result.fold(
          (f) => expect(f, isA<AlreadySubscribedException>()),
          (_) => fail('Expected Left'),
        );
      },
    );

    test('cancelSubscription restores balance and clears portfolio', () async {
      final notifier = container.read(portfolioNotifierProvider.notifier);
      await notifier.subscribe(
        fund: kTestFundFpv,
        amount: 100000,
        notificationMethod: NotificationMethodEnum.email,
      );
      final result = await notifier.cancelSubscription(fundId: kTestFundFpv.id);

      expect(result.isRight(), true);
      final state = container.read(portfolioNotifierProvider);
      expect(state.balance, AppConstants.initialBalance);
      expect(state.entries, isEmpty);
      expect(state.isLoading, false);
    });

    test(
      'cancelSubscription returns Left(FundNotFoundException) when not subscribed',
      () async {
        final notifier = container.read(portfolioNotifierProvider.notifier);
        final result = await notifier.cancelSubscription(fundId: 999);

        expect(result.isLeft(), true);
        result.fold(
          (f) => expect(f, isA<FundNotFoundException>()),
          (_) => fail('Expected Left'),
        );
      },
    );

    test('error is cleared on subsequent successful operation', () async {
      final notifier = container.read(portfolioNotifierProvider.notifier);
      // Trigger an error first
      await notifier.subscribe(
        fund: kTestFundFpv,
        amount: 600000,
        notificationMethod: NotificationMethodEnum.email,
      );
      expect(container.read(portfolioNotifierProvider).error, isNotNull);

      // Successful subscribe clears the error
      await notifier.subscribe(
        fund: kTestFundFpv,
        amount: 75000,
        notificationMethod: NotificationMethodEnum.email,
      );
      expect(container.read(portfolioNotifierProvider).error, isNull);
    });
  });
}
