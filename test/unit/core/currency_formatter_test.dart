import 'package:flutter_test/flutter_test.dart';
import 'package:btg_capital/core/utils/currency_formatter.dart';

void main() {
  group('CurrencyFormatter.format', () {
    test('formats typical amount with thousand separator', () {
      expect(CurrencyFormatter.format(500000), 'COP \$500.000');
    });

    test('formats zero', () {
      expect(CurrencyFormatter.format(0), 'COP \$0');
    });

    test('formats amount without thousand separator when below 1000', () {
      expect(CurrencyFormatter.format(999), 'COP \$999');
    });

    test('formats large amount with multiple separators', () {
      expect(CurrencyFormatter.format(1500000), 'COP \$1.500.000');
    });

    test('formats exact thousand boundary', () {
      expect(CurrencyFormatter.format(1000), 'COP \$1.000');
    });
  });
}
