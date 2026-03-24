// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get navDashboard => 'Home';

  @override
  String get navFunds => 'Funds';

  @override
  String get navTransactions => 'History';

  @override
  String get breadcrumbHome => 'Home';

  @override
  String get breadcrumbFunds => 'Investment Funds';

  @override
  String get breadcrumbTransactions => 'Transaction History';

  @override
  String get breadcrumbSubscribe => 'Subscription';

  @override
  String get dashboardTitle => 'Account Summary';

  @override
  String get dashboardSubtitle => 'Welcome back to your BTG Capital Dashboard.';

  @override
  String get fundsTitle => 'Investment Funds';

  @override
  String get fundsSubtitle =>
      'Explore and manage your portfolio with our selection of FPV and FIC funds.';

  @override
  String get fundsTabLabel => 'All funds';

  @override
  String get fundCategoryFpv => 'FPV';

  @override
  String get fundCategoryFic => 'FIC';

  @override
  String get fundTypeFpvLabel => 'Voluntary Pension Fund';

  @override
  String get fundTypeFicLabel => 'Collective Investment Fund';

  @override
  String get fundSubscribeButton => 'Subscribe';

  @override
  String get fundSubscribedLabel => 'SUBSCRIBED';

  @override
  String get fundAvailableLabel => 'Available';

  @override
  String get fundAlreadySubscribed => 'Already subscribed';

  @override
  String get fundWithdrawButton => 'WITHDRAW';

  @override
  String get fundMinPrefix => 'Min: ';

  @override
  String get subscribeTitle => 'Subscribe to fund';

  @override
  String subscribeFundSubtitle(String fundName) {
    return 'Invest in $fundName with BTG Capital.';
  }

  @override
  String get subscribeAmountLabel => 'Amount to invest';

  @override
  String get subscribeAmountInputLabel => 'Enter the amount (COP)';

  @override
  String get subscribeConfirmButton => 'Confirm subscription';

  @override
  String get subscribeCancelButton => 'Cancel';

  @override
  String get subscribeValidationEnterAmount => 'Enter an amount';

  @override
  String get subscribeValidationInvalidAmount => 'Enter a valid amount';

  @override
  String get subscribeNotificationMethodLabel => 'Notification method';

  @override
  String get subscribeDisclosureTitle => 'Disclosure agreement';

  @override
  String get subscribeDisclosureBody =>
      'By continuing, you confirm that you have read and understood the fund subscription terms. The investment value may fluctuate.';

  @override
  String get transactionsTitle => 'Transaction History';

  @override
  String get transactionsSubtitle =>
      'View the complete record of your subscriptions and cancellations.';

  @override
  String get transactionsTabLabel => 'All transactions';

  @override
  String get transactionSubscriptionLabel => 'SUBSCRIPTION';

  @override
  String get transactionCancellationLabel => 'CANCELLATION';

  @override
  String get transactionNotifPrefix => 'Notif: ';

  @override
  String get transactionNotifEmail => 'Email';

  @override
  String get transactionNotifSms => 'SMS';

  @override
  String get transactionNotifNone => '—';

  @override
  String get footerBrandName => 'BTG Capital';

  @override
  String get footerCopyright => '© 2026 BTG Capital. All rights reserved.';

  @override
  String get footerInvestorLabel => 'Investor';

  @override
  String get sidebarDashboardLabel => 'Dashboard';

  @override
  String get sidebarFundsLabel => 'Invest';

  @override
  String get sidebarTransactionsLabel => 'History';

  @override
  String get sidebarLogoutLabel => 'Log out';

  @override
  String get languageSwitcherLabel => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSpanish => 'Spanish';

  @override
  String get tableHeaderId => 'ID';

  @override
  String get tableHeaderFund => 'FUND';

  @override
  String get tableHeaderType => 'TYPE';

  @override
  String get tableHeaderAmount => 'AMOUNT';

  @override
  String get tableHeaderNotification => 'NOTIFICATION';

  @override
  String get tableHeaderDate => 'DATE';

  @override
  String get tableShowingPrefix => 'Showing ';

  @override
  String get tableTransactionsSuffix => ' transactions';

  @override
  String get transactionsEmptyTitle => 'No transactions';

  @override
  String get transactionsEmptySubtitle =>
      'When you make subscriptions or cancellations, they will appear here.';

  @override
  String get notifEmailDescription => 'Email notifications';

  @override
  String get notifSmsDescription => 'Mobile alerts';

  @override
  String get subscribeDetailsAccountTitle => 'Account Summary';

  @override
  String get subscribeDetailsBalanceLabel => 'Available balance';

  @override
  String get subscribeDetailsMinLabel => 'Minimum amount';

  @override
  String get subscribeDetailsSupportTitle => 'Need help with your investment?';

  @override
  String get subscribeDetailsSupportSubtitle =>
      'Consult with a BTG Capital advisor';

  @override
  String subscribeValidationBelowMinimum(String amount) {
    return 'The minimum amount is $amount';
  }

  @override
  String subscribeValidationExceedsBalance(String amount) {
    return 'Exceeds your available balance of $amount';
  }

  @override
  String get operationResultFundLabel => 'Fund';

  @override
  String get operationResultAmountSubscribedLabel => 'Amount Subscribed';

  @override
  String get operationResultAmountReturnedLabel => 'Amount Returned';

  @override
  String get operationResultDateLabel => 'Date';

  @override
  String get operationResultErrorLabel => 'Error';

  @override
  String get operationResultReferenceLabel => 'Reference';

  @override
  String get operationResultNotificationLabel => 'Notification';

  @override
  String get operationResultSubscribeTitle => 'Subscription Successful!';

  @override
  String get operationResultCancelTitle => 'Cancellation Successful!';

  @override
  String get operationResultErrorTitle => 'Operation Error';

  @override
  String get operationResultSubscribeDescription =>
      'Your investment has been processed successfully and the fund will be reflected in your portfolio shortly.';

  @override
  String get operationResultCancelDescription =>
      'Your subscription has been cancelled. The invested amount has been returned to your available balance.';

  @override
  String get operationResultErrorDescription =>
      'An error occurred while processing your request. Please try again.';

  @override
  String get operationResultCloseButton => 'Close';

  @override
  String get supportFooterTitle => 'Need help choosing a fund?';

  @override
  String get supportFooterSubtitle =>
      'Our financial advisors can help you build a portfolio according to your risk profile.';

  @override
  String get supportFooterButton => 'Contact advisor';

  @override
  String get cancelDialogTitle =>
      'Are you sure you want to cancel\nyour participation?';

  @override
  String get cancelDialogDescriptionPrefix =>
      'You are about to cancel your investment in ';

  @override
  String get cancelDialogDescriptionSuffix => '. This action cannot be undone.';

  @override
  String get cancelDialogBalanceLabel => 'BALANCE TO RETURN';

  @override
  String get cancelDialogFeeLabel => 'Withdrawal fee';

  @override
  String get cancelDialogConfirmButton => 'Confirm Cancellation';

  @override
  String get cancelDialogBackButton => 'Go back';

  @override
  String get dashboardTotalBalanceLabel => 'TOTAL BALANCE';

  @override
  String get dashboardInvestButton => 'Invest';

  @override
  String get dashboardEmptyFundsTitle => 'You don\'t have subscribed funds yet';

  @override
  String get dashboardEmptyFundsSubtitle =>
      'Start investing in FPV or FIC funds';

  @override
  String get dashboardMyFundsTitle => 'My Funds';

  @override
  String get tableHeaderFundName => 'FUND NAME';

  @override
  String get tableHeaderCategory => 'CATEGORY';

  @override
  String get tableHeaderMinAmount => 'MIN. AMOUNT';

  @override
  String get tableHeaderStatus => 'STATUS';

  @override
  String get tableHeaderAction => 'ACTION';

  @override
  String get tableFundsSuffix => ' available funds';

  @override
  String get helpCardTitle => 'Need help?';

  @override
  String get helpCardSubtitle =>
      'Talk with an expert financial advisor to optimize your portfolio.';

  @override
  String get helpCardButton => 'Contact';

  @override
  String get fundsErrorTitle => 'Error loading funds';
}
