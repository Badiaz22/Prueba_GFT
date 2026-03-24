import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:btg_capital/features/funds/presentation/widgets/common/app_breadcrumb.dart';

import '../../../helpers/pump_app.dart';

void main() {
  testWidgets('golden: AppBreadcrumb — Home > Fondos de Inversión', (
    WidgetTester tester,
  ) async {
    await tester.pumpApp(
      const Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16),
          child: AppBreadcrumb(currentPage: 'Fondos de Inversión'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(AppBreadcrumb),
      matchesGoldenFile('goldens/app_breadcrumb.png'),
    );
  });
}
