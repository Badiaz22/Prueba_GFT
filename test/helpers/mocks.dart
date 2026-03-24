import 'package:mockito/annotations.dart';
import 'package:btg_capital/features/funds/domain/repositories/funds_repository.dart';
import 'package:btg_capital/features/funds/data/datasources/funds_local_datasource.dart';

// Run the following command to regenerate the mocks file:
//   dart run build_runner build --delete-conflicting-outputs
@GenerateMocks([FundsRepository, FundsLocalDatasource])
void main() {}
