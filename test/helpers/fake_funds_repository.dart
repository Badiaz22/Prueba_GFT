import 'package:btg_capital/features/funds/domain/entities/fund_entity.dart';
import 'package:btg_capital/features/funds/domain/entities/portfolio_entry_entity.dart';
import 'package:btg_capital/features/funds/domain/entities/transaction_entity.dart';
import 'package:btg_capital/features/funds/domain/repositories/funds_repository.dart';

import 'test_data.dart';

/// In-memory fake of [FundsRepository] for use in widget and notifier tests.
///
/// Pre-populated with sensible defaults from [test_data.dart].
/// Override individual fields before pumping the widget under test to control
/// the exact scenario you want to exercise.
class FakeFundsRepository implements FundsRepository {
  int balance;
  List<FundEntity> fundsToReturn;
  List<PortfolioEntryEntity> portfolio;
  List<TransactionEntity> transactions;

  /// When non-null, [subscribeToFund] throws this exception instead of succeeding.
  Exception? subscribeError;

  /// When non-null, [cancelFundSubscription] throws this exception instead of succeeding.
  Exception? cancelError;

  FakeFundsRepository({
    this.balance = 500000,
    List<FundEntity>? fundsToReturn,
    List<PortfolioEntryEntity>? portfolio,
    List<TransactionEntity>? transactions,
  }) : fundsToReturn = fundsToReturn ?? kTestFunds,
       portfolio = portfolio ?? [],
       transactions = transactions ?? [];

  @override
  Future<List<FundEntity>> getFunds() async => fundsToReturn;

  @override
  Future<void> subscribeToFund({
    required FundEntity fund,
    required int amount,
    required NotificationMethodEnum notificationMethod,
  }) async {
    if (subscribeError != null) throw subscribeError!;
    balance -= amount;
    portfolio = [
      ...portfolio,
      PortfolioEntryEntity(
        fund: fund,
        investedAmount: amount,
        subscribedDate: DateTime.now(),
      ),
    ];
    transactions = [
      TransactionEntity(
        id: 'TXN-FAKE-${transactions.length + 1}',
        fundId: fund.id,
        fundName: fund.name,
        amount: amount,
        type: TransactionTypeEnum.subscription,
        notificationMethod: notificationMethod,
        date: DateTime.now(),
      ),
      ...transactions,
    ];
  }

  @override
  Future<void> cancelFundSubscription({required int fundId}) async {
    if (cancelError != null) throw cancelError!;
    final entry = portfolio.firstWhere((e) => e.fund.id == fundId);
    balance += entry.investedAmount;
    portfolio = portfolio.where((e) => e.fund.id != fundId).toList();
    transactions = [
      TransactionEntity(
        id: 'TXN-FAKE-${transactions.length + 1}',
        fundId: entry.fund.id,
        fundName: entry.fund.name,
        amount: entry.investedAmount,
        type: TransactionTypeEnum.cancellation,
        notificationMethod: null,
        date: DateTime.now(),
      ),
      ...transactions,
    ];
  }

  @override
  List<TransactionEntity> getTransactions() => transactions;

  @override
  List<PortfolioEntryEntity> getPortfolio() => portfolio;

  @override
  int getBalance() => balance;
}
