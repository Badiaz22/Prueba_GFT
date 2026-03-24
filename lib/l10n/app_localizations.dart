import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @navDashboard.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navDashboard;

  /// No description provided for @navFunds.
  ///
  /// In en, this message translates to:
  /// **'Funds'**
  String get navFunds;

  /// No description provided for @navTransactions.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get navTransactions;

  /// No description provided for @breadcrumbHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get breadcrumbHome;

  /// No description provided for @breadcrumbFunds.
  ///
  /// In en, this message translates to:
  /// **'Investment Funds'**
  String get breadcrumbFunds;

  /// No description provided for @breadcrumbTransactions.
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get breadcrumbTransactions;

  /// No description provided for @breadcrumbSubscribe.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get breadcrumbSubscribe;

  /// No description provided for @dashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Account Summary'**
  String get dashboardTitle;

  /// No description provided for @dashboardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back to your BTG Capital Dashboard.'**
  String get dashboardSubtitle;

  /// No description provided for @fundsTitle.
  ///
  /// In en, this message translates to:
  /// **'Investment Funds'**
  String get fundsTitle;

  /// No description provided for @fundsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Explore and manage your portfolio with our selection of FPV and FIC funds.'**
  String get fundsSubtitle;

  /// No description provided for @fundsTabLabel.
  ///
  /// In en, this message translates to:
  /// **'All funds'**
  String get fundsTabLabel;

  /// No description provided for @fundCategoryFpv.
  ///
  /// In en, this message translates to:
  /// **'FPV'**
  String get fundCategoryFpv;

  /// No description provided for @fundCategoryFic.
  ///
  /// In en, this message translates to:
  /// **'FIC'**
  String get fundCategoryFic;

  /// No description provided for @fundTypeFpvLabel.
  ///
  /// In en, this message translates to:
  /// **'Voluntary Pension Fund'**
  String get fundTypeFpvLabel;

  /// No description provided for @fundTypeFicLabel.
  ///
  /// In en, this message translates to:
  /// **'Collective Investment Fund'**
  String get fundTypeFicLabel;

  /// No description provided for @fundSubscribeButton.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get fundSubscribeButton;

  /// No description provided for @fundSubscribedLabel.
  ///
  /// In en, this message translates to:
  /// **'SUBSCRIBED'**
  String get fundSubscribedLabel;

  /// No description provided for @fundAvailableLabel.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get fundAvailableLabel;

  /// No description provided for @fundAlreadySubscribed.
  ///
  /// In en, this message translates to:
  /// **'Already subscribed'**
  String get fundAlreadySubscribed;

  /// No description provided for @fundWithdrawButton.
  ///
  /// In en, this message translates to:
  /// **'WITHDRAW'**
  String get fundWithdrawButton;

  /// No description provided for @fundMinPrefix.
  ///
  /// In en, this message translates to:
  /// **'Min: '**
  String get fundMinPrefix;

  /// No description provided for @subscribeTitle.
  ///
  /// In en, this message translates to:
  /// **'Subscribe to fund'**
  String get subscribeTitle;

  /// No description provided for @subscribeFundSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Invest in {fundName} with BTG Capital.'**
  String subscribeFundSubtitle(String fundName);

  /// No description provided for @subscribeAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount to invest'**
  String get subscribeAmountLabel;

  /// No description provided for @subscribeAmountInputLabel.
  ///
  /// In en, this message translates to:
  /// **'Enter the amount (COP)'**
  String get subscribeAmountInputLabel;

  /// No description provided for @subscribeConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm subscription'**
  String get subscribeConfirmButton;

  /// No description provided for @subscribeCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get subscribeCancelButton;

  /// No description provided for @subscribeValidationEnterAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount'**
  String get subscribeValidationEnterAmount;

  /// No description provided for @subscribeValidationInvalidAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid amount'**
  String get subscribeValidationInvalidAmount;

  /// No description provided for @subscribeNotificationMethodLabel.
  ///
  /// In en, this message translates to:
  /// **'Notification method'**
  String get subscribeNotificationMethodLabel;

  /// No description provided for @subscribeDisclosureTitle.
  ///
  /// In en, this message translates to:
  /// **'Disclosure agreement'**
  String get subscribeDisclosureTitle;

  /// No description provided for @subscribeDisclosureBody.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you confirm that you have read and understood the fund subscription terms. The investment value may fluctuate.'**
  String get subscribeDisclosureBody;

  /// No description provided for @transactionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get transactionsTitle;

  /// No description provided for @transactionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View the complete record of your subscriptions and cancellations.'**
  String get transactionsSubtitle;

  /// No description provided for @transactionsTabLabel.
  ///
  /// In en, this message translates to:
  /// **'All transactions'**
  String get transactionsTabLabel;

  /// No description provided for @transactionSubscriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'SUBSCRIPTION'**
  String get transactionSubscriptionLabel;

  /// No description provided for @transactionCancellationLabel.
  ///
  /// In en, this message translates to:
  /// **'CANCELLATION'**
  String get transactionCancellationLabel;

  /// No description provided for @transactionNotifPrefix.
  ///
  /// In en, this message translates to:
  /// **'Notif: '**
  String get transactionNotifPrefix;

  /// No description provided for @transactionNotifEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get transactionNotifEmail;

  /// No description provided for @transactionNotifSms.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get transactionNotifSms;

  /// No description provided for @transactionNotifNone.
  ///
  /// In en, this message translates to:
  /// **'—'**
  String get transactionNotifNone;

  /// No description provided for @footerBrandName.
  ///
  /// In en, this message translates to:
  /// **'BTG Capital'**
  String get footerBrandName;

  /// No description provided for @footerCopyright.
  ///
  /// In en, this message translates to:
  /// **'© 2026 BTG Capital. All rights reserved.'**
  String get footerCopyright;

  /// No description provided for @footerInvestorLabel.
  ///
  /// In en, this message translates to:
  /// **'Investor'**
  String get footerInvestorLabel;

  /// No description provided for @sidebarDashboardLabel.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get sidebarDashboardLabel;

  /// No description provided for @sidebarFundsLabel.
  ///
  /// In en, this message translates to:
  /// **'Invest'**
  String get sidebarFundsLabel;

  /// No description provided for @sidebarTransactionsLabel.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get sidebarTransactionsLabel;

  /// No description provided for @sidebarLogoutLabel.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get sidebarLogoutLabel;

  /// No description provided for @languageSwitcherLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageSwitcherLabel;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get languageSpanish;

  /// No description provided for @tableHeaderId.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get tableHeaderId;

  /// No description provided for @tableHeaderFund.
  ///
  /// In en, this message translates to:
  /// **'FUND'**
  String get tableHeaderFund;

  /// No description provided for @tableHeaderType.
  ///
  /// In en, this message translates to:
  /// **'TYPE'**
  String get tableHeaderType;

  /// No description provided for @tableHeaderAmount.
  ///
  /// In en, this message translates to:
  /// **'AMOUNT'**
  String get tableHeaderAmount;

  /// No description provided for @tableHeaderNotification.
  ///
  /// In en, this message translates to:
  /// **'NOTIFICATION'**
  String get tableHeaderNotification;

  /// No description provided for @tableHeaderDate.
  ///
  /// In en, this message translates to:
  /// **'DATE'**
  String get tableHeaderDate;

  /// No description provided for @tableShowingPrefix.
  ///
  /// In en, this message translates to:
  /// **'Showing '**
  String get tableShowingPrefix;

  /// No description provided for @tableTransactionsSuffix.
  ///
  /// In en, this message translates to:
  /// **' transactions'**
  String get tableTransactionsSuffix;

  /// No description provided for @transactionsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No transactions'**
  String get transactionsEmptyTitle;

  /// No description provided for @transactionsEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'When you make subscriptions or cancellations, they will appear here.'**
  String get transactionsEmptySubtitle;

  /// No description provided for @notifEmailDescription.
  ///
  /// In en, this message translates to:
  /// **'Email notifications'**
  String get notifEmailDescription;

  /// No description provided for @notifSmsDescription.
  ///
  /// In en, this message translates to:
  /// **'Mobile alerts'**
  String get notifSmsDescription;

  /// No description provided for @subscribeDetailsAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Account Summary'**
  String get subscribeDetailsAccountTitle;

  /// No description provided for @subscribeDetailsBalanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Available balance'**
  String get subscribeDetailsBalanceLabel;

  /// No description provided for @subscribeDetailsMinLabel.
  ///
  /// In en, this message translates to:
  /// **'Minimum amount'**
  String get subscribeDetailsMinLabel;

  /// No description provided for @subscribeDetailsSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Need help with your investment?'**
  String get subscribeDetailsSupportTitle;

  /// No description provided for @subscribeDetailsSupportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Consult with a BTG Capital advisor'**
  String get subscribeDetailsSupportSubtitle;

  /// No description provided for @subscribeValidationBelowMinimum.
  ///
  /// In en, this message translates to:
  /// **'The minimum amount is {amount}'**
  String subscribeValidationBelowMinimum(String amount);

  /// No description provided for @subscribeValidationExceedsBalance.
  ///
  /// In en, this message translates to:
  /// **'Exceeds your available balance of {amount}'**
  String subscribeValidationExceedsBalance(String amount);

  /// No description provided for @operationResultFundLabel.
  ///
  /// In en, this message translates to:
  /// **'Fund'**
  String get operationResultFundLabel;

  /// No description provided for @operationResultAmountSubscribedLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount Subscribed'**
  String get operationResultAmountSubscribedLabel;

  /// No description provided for @operationResultAmountReturnedLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount Returned'**
  String get operationResultAmountReturnedLabel;

  /// No description provided for @operationResultDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get operationResultDateLabel;

  /// No description provided for @operationResultErrorLabel.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get operationResultErrorLabel;

  /// No description provided for @operationResultReferenceLabel.
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get operationResultReferenceLabel;

  /// No description provided for @operationResultNotificationLabel.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get operationResultNotificationLabel;

  /// No description provided for @operationResultSubscribeTitle.
  ///
  /// In en, this message translates to:
  /// **'Subscription Successful!'**
  String get operationResultSubscribeTitle;

  /// No description provided for @operationResultCancelTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancellation Successful!'**
  String get operationResultCancelTitle;

  /// No description provided for @operationResultErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Operation Error'**
  String get operationResultErrorTitle;

  /// No description provided for @operationResultSubscribeDescription.
  ///
  /// In en, this message translates to:
  /// **'Your investment has been processed successfully and the fund will be reflected in your portfolio shortly.'**
  String get operationResultSubscribeDescription;

  /// No description provided for @operationResultCancelDescription.
  ///
  /// In en, this message translates to:
  /// **'Your subscription has been cancelled. The invested amount has been returned to your available balance.'**
  String get operationResultCancelDescription;

  /// No description provided for @operationResultErrorDescription.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while processing your request. Please try again.'**
  String get operationResultErrorDescription;

  /// No description provided for @operationResultCloseButton.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get operationResultCloseButton;

  /// No description provided for @supportFooterTitle.
  ///
  /// In en, this message translates to:
  /// **'Need help choosing a fund?'**
  String get supportFooterTitle;

  /// No description provided for @supportFooterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Our financial advisors can help you build a portfolio according to your risk profile.'**
  String get supportFooterSubtitle;

  /// No description provided for @supportFooterButton.
  ///
  /// In en, this message translates to:
  /// **'Contact advisor'**
  String get supportFooterButton;

  /// No description provided for @cancelDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel\nyour participation?'**
  String get cancelDialogTitle;

  /// No description provided for @cancelDialogDescriptionPrefix.
  ///
  /// In en, this message translates to:
  /// **'You are about to cancel your investment in '**
  String get cancelDialogDescriptionPrefix;

  /// No description provided for @cancelDialogDescriptionSuffix.
  ///
  /// In en, this message translates to:
  /// **'. This action cannot be undone.'**
  String get cancelDialogDescriptionSuffix;

  /// No description provided for @cancelDialogBalanceLabel.
  ///
  /// In en, this message translates to:
  /// **'BALANCE TO RETURN'**
  String get cancelDialogBalanceLabel;

  /// No description provided for @cancelDialogFeeLabel.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal fee'**
  String get cancelDialogFeeLabel;

  /// No description provided for @cancelDialogConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm Cancellation'**
  String get cancelDialogConfirmButton;

  /// No description provided for @cancelDialogBackButton.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get cancelDialogBackButton;

  /// No description provided for @dashboardTotalBalanceLabel.
  ///
  /// In en, this message translates to:
  /// **'TOTAL BALANCE'**
  String get dashboardTotalBalanceLabel;

  /// No description provided for @dashboardInvestButton.
  ///
  /// In en, this message translates to:
  /// **'Invest'**
  String get dashboardInvestButton;

  /// No description provided for @dashboardEmptyFundsTitle.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have subscribed funds yet'**
  String get dashboardEmptyFundsTitle;

  /// No description provided for @dashboardEmptyFundsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start investing in FPV or FIC funds'**
  String get dashboardEmptyFundsSubtitle;

  /// No description provided for @dashboardMyFundsTitle.
  ///
  /// In en, this message translates to:
  /// **'My Funds'**
  String get dashboardMyFundsTitle;

  /// No description provided for @tableHeaderFundName.
  ///
  /// In en, this message translates to:
  /// **'FUND NAME'**
  String get tableHeaderFundName;

  /// No description provided for @tableHeaderCategory.
  ///
  /// In en, this message translates to:
  /// **'CATEGORY'**
  String get tableHeaderCategory;

  /// No description provided for @tableHeaderMinAmount.
  ///
  /// In en, this message translates to:
  /// **'MIN. AMOUNT'**
  String get tableHeaderMinAmount;

  /// No description provided for @tableHeaderStatus.
  ///
  /// In en, this message translates to:
  /// **'STATUS'**
  String get tableHeaderStatus;

  /// No description provided for @tableHeaderAction.
  ///
  /// In en, this message translates to:
  /// **'ACTION'**
  String get tableHeaderAction;

  /// No description provided for @tableFundsSuffix.
  ///
  /// In en, this message translates to:
  /// **' available funds'**
  String get tableFundsSuffix;

  /// No description provided for @helpCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Need help?'**
  String get helpCardTitle;

  /// No description provided for @helpCardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Talk with an expert financial advisor to optimize your portfolio.'**
  String get helpCardSubtitle;

  /// No description provided for @helpCardButton.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get helpCardButton;

  /// No description provided for @fundsErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Error loading funds'**
  String get fundsErrorTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
