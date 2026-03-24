// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get navDashboard => 'Inicio';

  @override
  String get navFunds => 'Fondos';

  @override
  String get navTransactions => 'Historial';

  @override
  String get breadcrumbHome => 'Inicio';

  @override
  String get breadcrumbFunds => 'Fondos de Inversión';

  @override
  String get breadcrumbTransactions => 'Historial de Transacciones';

  @override
  String get breadcrumbSubscribe => 'Suscripción';

  @override
  String get dashboardTitle => 'Resumen de Cuenta';

  @override
  String get dashboardSubtitle =>
      'Bienvenido de nuevo a su Dashboard de BTG Capital.';

  @override
  String get fundsTitle => 'Fondos de Inversión';

  @override
  String get fundsSubtitle =>
      'Explore y gestione su portafolio con nuestra selección de fondos FPV y FIC.';

  @override
  String get fundsTabLabel => 'Todos los fondos';

  @override
  String get fundCategoryFpv => 'FPV';

  @override
  String get fundCategoryFic => 'FIC';

  @override
  String get fundTypeFpvLabel => 'Fondo Pensiones Voluntarias';

  @override
  String get fundTypeFicLabel => 'Fondo Inversión Colectiva';

  @override
  String get fundSubscribeButton => 'Suscribirse';

  @override
  String get fundSubscribedLabel => 'SUSCRITO';

  @override
  String get fundAvailableLabel => 'Disponible';

  @override
  String get fundAlreadySubscribed => 'Ya suscrito';

  @override
  String get fundWithdrawButton => 'RETIRAR';

  @override
  String get fundMinPrefix => 'Mín: ';

  @override
  String get subscribeTitle => 'Suscribirse al fondo';

  @override
  String subscribeFundSubtitle(String fundName) {
    return 'Invierte en $fundName de BTG Capital.';
  }

  @override
  String get subscribeAmountLabel => 'Monto a invertir';

  @override
  String get subscribeAmountInputLabel => 'Ingresa el monto (COP)';

  @override
  String get subscribeConfirmButton => 'Confirmar subscripcion';

  @override
  String get subscribeCancelButton => 'Cancelar';

  @override
  String get subscribeValidationEnterAmount => 'Ingrese un monto';

  @override
  String get subscribeValidationInvalidAmount => 'Ingrese un monto valido';

  @override
  String get subscribeNotificationMethodLabel => 'Metodo de notificacion';

  @override
  String get subscribeDisclosureTitle => 'Acuerdo de divulgacion';

  @override
  String get subscribeDisclosureBody =>
      'Al continuar, confirmas que has leido y comprendido los terminos de subscripcion al fondo. El valor de la inversion puede fluctuar.';

  @override
  String get transactionsTitle => 'Historial de Transacciones';

  @override
  String get transactionsSubtitle =>
      'Consulte el registro completo de sus suscripciones y cancelaciones.';

  @override
  String get transactionsTabLabel => 'Todas las transacciones';

  @override
  String get transactionSubscriptionLabel => 'SUSCRIPCIÓN';

  @override
  String get transactionCancellationLabel => 'CANCELACIÓN';

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
  String get footerCopyright =>
      '© 2026 BTG Capital. Todos los derechos reservados.';

  @override
  String get footerInvestorLabel => 'Inversionista';

  @override
  String get sidebarDashboardLabel => 'Dashboard';

  @override
  String get sidebarFundsLabel => 'Invertir';

  @override
  String get sidebarTransactionsLabel => 'Historial';

  @override
  String get sidebarLogoutLabel => 'Cerrar sesión';

  @override
  String get languageSwitcherLabel => 'Idioma';

  @override
  String get languageEnglish => 'Inglés';

  @override
  String get languageSpanish => 'Español';

  @override
  String get tableHeaderId => 'ID';

  @override
  String get tableHeaderFund => 'FONDO';

  @override
  String get tableHeaderType => 'TIPO';

  @override
  String get tableHeaderAmount => 'MONTO';

  @override
  String get tableHeaderNotification => 'NOTIFICACIÓN';

  @override
  String get tableHeaderDate => 'FECHA';

  @override
  String get tableShowingPrefix => 'Mostrando ';

  @override
  String get tableTransactionsSuffix => ' transacciones';

  @override
  String get transactionsEmptyTitle => 'Sin transacciones';

  @override
  String get transactionsEmptySubtitle =>
      'Cuando realice suscripciones o cancelaciones, aparecerán aquí.';

  @override
  String get notifEmailDescription => 'Notificaciones al correo';

  @override
  String get notifSmsDescription => 'Alertas al celular';

  @override
  String get subscribeDetailsAccountTitle => 'Resumen de cuenta';

  @override
  String get subscribeDetailsBalanceLabel => 'Saldo disponible';

  @override
  String get subscribeDetailsMinLabel => 'Monto mínimo';

  @override
  String get subscribeDetailsSupportTitle =>
      '¿Necesitas ayuda con tu inversión?';

  @override
  String get subscribeDetailsSupportSubtitle =>
      'Consulta con un asesor BTG Capital';

  @override
  String subscribeValidationBelowMinimum(String amount) {
    return 'El monto mínimo es $amount';
  }

  @override
  String subscribeValidationExceedsBalance(String amount) {
    return 'Supera el saldo disponible de $amount';
  }

  @override
  String get operationResultFundLabel => 'Fondo';

  @override
  String get operationResultAmountSubscribedLabel => 'Monto Suscrito';

  @override
  String get operationResultAmountReturnedLabel => 'Monto Devuelto';

  @override
  String get operationResultDateLabel => 'Fecha';

  @override
  String get operationResultErrorLabel => 'Error';

  @override
  String get operationResultReferenceLabel => 'Referencia';

  @override
  String get operationResultNotificationLabel => 'Notificación';

  @override
  String get operationResultSubscribeTitle => '¡Suscripción Exitosa!';

  @override
  String get operationResultCancelTitle => '¡Cancelación Exitosa!';

  @override
  String get operationResultErrorTitle => 'Error en la Operación';

  @override
  String get operationResultSubscribeDescription =>
      'Tu inversión ha sido procesada correctamente y el fondo se verá reflejado en tu portafolio en breve.';

  @override
  String get operationResultCancelDescription =>
      'Tu suscripción ha sido cancelada. El monto invertido ha sido devuelto a tu saldo disponible.';

  @override
  String get operationResultErrorDescription =>
      'Ocurrió un error al procesar tu solicitud. Por favor intenta nuevamente.';

  @override
  String get operationResultCloseButton => 'Cerrar';

  @override
  String get supportFooterTitle => '¿Necesita ayuda eligiendo un fondo?';

  @override
  String get supportFooterSubtitle =>
      'Nuestros asesores financieros pueden ayudarle a construir un portafolio acorde a su perfil de riesgo.';

  @override
  String get supportFooterButton => 'Contactar asesor';

  @override
  String get cancelDialogTitle =>
      '¿Estás seguro de cancelar\ntu participación?';

  @override
  String get cancelDialogDescriptionPrefix =>
      'Estás a punto de cancelar tu inversión en el ';

  @override
  String get cancelDialogDescriptionSuffix =>
      '. Esta acción no se puede deshacer.';

  @override
  String get cancelDialogBalanceLabel => 'BALANCE A DEVOLVER';

  @override
  String get cancelDialogFeeLabel => 'Comisión por retiro';

  @override
  String get cancelDialogConfirmButton => 'Confirmar Cancelación';

  @override
  String get cancelDialogBackButton => 'Volver';

  @override
  String get dashboardTotalBalanceLabel => 'SALDO TOTAL';

  @override
  String get dashboardInvestButton => 'Invertir';

  @override
  String get dashboardEmptyFundsTitle => 'Aún no tienes fondos suscritos';

  @override
  String get dashboardEmptyFundsSubtitle =>
      'Empieza a invertir en fondos FPV o FIC';

  @override
  String get dashboardMyFundsTitle => 'Mis Fondos';

  @override
  String get tableHeaderFundName => 'NOMBRE DEL FONDO';

  @override
  String get tableHeaderCategory => 'CATEGORÍA';

  @override
  String get tableHeaderMinAmount => 'MONTO MÍNIMO';

  @override
  String get tableHeaderStatus => 'ESTADO';

  @override
  String get tableHeaderAction => 'ACCIÓN';

  @override
  String get tableFundsSuffix => ' fondos disponibles';

  @override
  String get helpCardTitle => '¿Necesitas ayuda?';

  @override
  String get helpCardSubtitle =>
      'Habla con un asesor financiero experto para optimizar tu cartera.';

  @override
  String get helpCardButton => 'Contactar';

  @override
  String get fundsErrorTitle => 'Error al cargar los fondos';
}
