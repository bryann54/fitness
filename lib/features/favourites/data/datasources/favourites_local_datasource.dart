// lib/features/favourites/data/datasources/favourites_local_datasource.dart
import 'dart:convert';
import 'package:fitness/core/storage/storage_preference_manager.dart';
import 'package:fitness/features/meals/data/models/meal_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/foundation.dart';

@lazySingleton
class FavouritesLocalDatasource {
  final SharedPreferencesManager _sharedPreferencesManager;

  FavouritesLocalDatasource(this._sharedPreferencesManager);

  static const String _favouritesKey = 'meal_favourites';

  /// Get all favorite meals
  Future<List<MealModel>> listFavourites() async {
    try {
      final json = _sharedPreferencesManager.getString(_favouritesKey);
      if (json == null || json.isEmpty) return [];

      final List<dynamic> decoded = jsonDecode(json);
      return decoded
          .map((e) => MealModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (kDebugMode) {}
      return [];
    }
  }

  /// Add meal to favorites
  Future<List<MealModel>?> addFavourite(MealModel meal) async {
    try {
      final favs = await listFavourites();

      // Check if already exists using meal ID
      final exists = favs.any((fav) => fav.id == meal.id);
      if (exists) {
        if (kDebugMode) {}
        return null;
      }

      final newFavs = [...favs, meal];
      await _saveFavourites(newFavs);

      return newFavs;
    } catch (e) {
      if (kDebugMode) {}
      return null;
    }
  }

  /// Remove meal from favorites
  Future<List<MealModel>> deleteFavourite(MealModel meal) async {
    try {
      final favs = await listFavourites();
      final newFavs = favs.where((fav) => fav.id != meal.id).toList();

      await _saveFavourites(newFavs);

      return newFavs;
    } catch (e) {
      return [];
    }
  }

  /// Check if meal is favorite
  Future<bool> checkIfFav(MealModel meal) async {
    try {
      final favs = await listFavourites();
      return favs.any((fav) => fav.id == meal.id);
    } catch (e) {
      if (kDebugMode) {}
      return false;
    }
  }

  /// Save favorites to storage
  Future<void> _saveFavourites(List<MealModel> meals) async {
    try {
      final json = jsonEncode(meals.map((m) => m.toJson()).toList());
      await _sharedPreferencesManager.putString(_favouritesKey, json);
    } catch (e) {
      if (kDebugMode) {}
    }
  }

  /// Clear all favorites
  Future<void> clearFavourites() async {
    await _sharedPreferencesManager.clearAll();
  }
}
