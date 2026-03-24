import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/fund_model.dart';

/// Fuente de datos local que obtiene fondos desde los assets del proyecto.
///
/// Simula una latencia de red definida por [AppConstants.apiSimulatedDelay]
/// para emular el comportamiento de una API real.
class FundsLocalDatasource {
  /// Carga y parsea la lista de fondos desde `assets/mock/funds.json`.
  ///
  /// Retorna una lista de [FundModel] listos para su uso.
  Future<List<FundModel>> getFunds() async {
    // Simulate API latency
    await Future.delayed(
      const Duration(milliseconds: AppConstants.apiSimulatedDelay),
    );

    final jsonString = await rootBundle.loadString('assets/mock/funds.json');
    final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;

    return jsonList
        .map((json) => FundModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
