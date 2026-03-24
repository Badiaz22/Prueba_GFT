import 'package:btg_capital/features/funds/domain/entities/fund_entity.dart';
import 'package:btg_capital/features/funds/domain/entities/portfolio_entry_entity.dart';
import 'package:btg_capital/features/funds/domain/entities/transaction_entity.dart';
import 'package:btg_capital/features/funds/data/models/fund_model.dart';

// ──────────────────────────────────────────────────
// Entities
// ──────────────────────────────────────────────────

/// Fixed date used across all test fixtures to avoid DateTime.now() flakiness.
final kFixedDate = DateTime.utc(2024, 1, 15, 10, 30);

const kTestFundFpv = FundEntity(
  id: 1,
  name: 'FPV_BTG_PACTUAL_RECAUDADORA',
  minimumAmount: 75000,
  category: FundCategoryEnum.fpv,
);

const kTestFundFic = FundEntity(
  id: 2,
  name: 'FPV_BTG_PACTUAL_ECOPETROL',
  minimumAmount: 125000,
  category: FundCategoryEnum.fic,
);

final kTestPortfolioEntry = PortfolioEntryEntity(
  fund: kTestFundFpv,
  investedAmount: 75000,
  subscribedDate: kFixedDate,
);

final kTestTransaction = TransactionEntity(
  id: 'TXN-0000000001',
  fundId: 1,
  fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
  amount: 75000,
  type: TransactionTypeEnum.subscription,
  notificationMethod: NotificationMethodEnum.email,
  date: kFixedDate,
);

// ──────────────────────────────────────────────────
// Models
// ──────────────────────────────────────────────────

const kTestFundModelFpv = FundModel(
  id: 1,
  name: 'FPV_BTG_PACTUAL_RECAUDADORA',
  minimumAmount: 75000,
  category: 'FPV',
);

const kTestFundModelFic = FundModel(
  id: 2,
  name: 'FPV_BTG_PACTUAL_ECOPETROL',
  minimumAmount: 125000,
  category: 'FIC',
);

final kTestFundModelFpvJson = {
  'id': 1,
  'name': 'FPV_BTG_PACTUAL_RECAUDADORA',
  'minimum_amount': 75000,
  'category': 'FPV',
};

final kTestFundModelFicJson = {
  'id': 2,
  'name': 'FPV_BTG_PACTUAL_ECOPETROL',
  'minimum_amount': 125000,
  'category': 'FIC',
};

// ──────────────────────────────────────────────────
// Convenience lists
// ──────────────────────────────────────────────────

const kTestFunds = [kTestFundFpv, kTestFundFic];
