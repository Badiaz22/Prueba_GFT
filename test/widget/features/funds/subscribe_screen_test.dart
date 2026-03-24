import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:btg_capital/features/funds/domain/enums/notification_method_enum.dart';
import 'package:btg_capital/features/funds/presentation/screens/subscribe_screen.dart';

import '../../../helpers/pump_app.dart';
import '../../../helpers/test_data.dart';

void main() {
  group('SubscribeScreen', () {
    testWidgets('shows fund minimum amount as pre-filled value', (
      tester,
    ) async {
      await tester.pumpApp(
        Builder(
          builder: (context) => Scaffold(
            body: ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SubscribeScreen(
                    fund: kTestFundFpv,
                    currentBalance: 500000,
                  ),
                  fullscreenDialog: true,
                ),
              ),
              child: const Text('open'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      expect(find.text('Monto a invertir'), findsOneWidget);
      // kTestFundFpv.minimumAmount == 75000
      expect(find.text('75000'), findsOneWidget);
    });

    testWidgets(
      'returns correct amount and notification method when confirmed',
      (tester) async {
        Map<String, dynamic>? result;

        await tester.pumpApp(
          Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () async {
                  result = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SubscribeScreen(
                        fund: kTestFundFpv,
                        currentBalance: 500000,
                      ),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: const Text('open'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('open'));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextField).first, '100000');
        await tester.ensureVisible(find.text('SMS'));
        await tester.tap(find.text('SMS'));
        await tester.pumpAndSettle();

        final confirmBtn = find.text('Confirmar subscripcion');
        await tester.ensureVisible(confirmBtn);
        await tester.pumpAndSettle();
        await tester.tap(confirmBtn);
        await tester.pumpAndSettle();

        expect(result, isNotNull);
        expect(result!['amount'], 100000);
        expect(result!['notificationMethod'], NotificationMethodEnum.sms);
      },
    );
  });
}
