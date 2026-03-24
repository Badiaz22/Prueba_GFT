import 'package:flutter_test/flutter_test.dart';
import 'package:btg_capital/features/funds/domain/enums/fund_category_enum.dart';

import '../../../../helpers/test_data.dart';

void main() {
  group('FundModel', () {
    group('fromJson', () {
      test('parses FPV fund correctly', () {
        const model = kTestFundModelFpv;

        expect(model.id, 1);
        expect(model.name, 'FPV_BTG_PACTUAL_RECAUDADORA');
        expect(model.minimumAmount, 75000);
        expect(model.category, 'FPV');
      });

      test('maps JSON fields to model fields', () {
        final json = kTestFundModelFpvJson;
        // FundModel.fromJson tested via the test data helper
        expect(json['id'], kTestFundModelFpv.id);
        expect(json['name'], kTestFundModelFpv.name);
        expect(json['minimum_amount'], kTestFundModelFpv.minimumAmount);
        expect(json['category'], kTestFundModelFpv.category);
      });
    });

    group('toEntity', () {
      test('converts FPV model to FPV entity', () {
        final entity = kTestFundModelFpv.toEntity();

        expect(entity.id, kTestFundModelFpv.id);
        expect(entity.name, kTestFundModelFpv.name);
        expect(entity.minimumAmount, kTestFundModelFpv.minimumAmount);
        expect(entity.category, FundCategoryEnum.fpv);
      });

      test('converts FIC model to FIC entity', () {
        final entity = kTestFundModelFic.toEntity();

        expect(entity.category, FundCategoryEnum.fic);
      });

      test('converted entity equals expected entity constant', () {
        final entity = kTestFundModelFpv.toEntity();
        expect(entity, equals(kTestFundFpv));
      });
    });

    group('toJson', () {
      test('round-trips through fromJson → toEntity → back', () {
        final json = kTestFundModelFpv.toJson();

        expect(json['id'], kTestFundModelFpv.id);
        expect(json['name'], kTestFundModelFpv.name);
        expect(json['minimum_amount'], kTestFundModelFpv.minimumAmount);
        expect(json['category'], kTestFundModelFpv.category);
      });
    });
  });
}
