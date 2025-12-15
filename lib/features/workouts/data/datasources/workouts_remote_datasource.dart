// lib/features/workouts/data/datasources/workouts_remote_datasource.dart

import 'package:fitness/core/api_client/client_provider.dart';
import 'package:fitness/core/api_client/endpoints/wger_api_endpoints.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WorkoutsRemoteDatasource {
  final ClientProvider _clientProvider;

  WorkoutsRemoteDatasource(this._clientProvider);

  /// Fetches a list of all exercise categories (e.g., Yoga, Cardio, Strength).
  Future<dynamic> getExerciseCategories() async {
    try {
      // WgerApiEndpoints.exerciseCategories is '/exercisecategory/'
      return await _clientProvider.get(
          url: WgerApiEndpoints.exerciseCategories);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('getExerciseCategories response: $e');
      }
      rethrow;
    }
  }

  // Future<dynamic> getExercises({int? categoryId, int? languageId}) async {
  //   // ... implementation for exercises endpoint ...
  // }
}
