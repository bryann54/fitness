// lib/features/meals/data/datasources/meals_remote_datasource.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/core/errors/exceptions.dart';
import 'package:injectable/injectable.dart';
import '../models/meal_model.dart';

@LazySingleton()
class MealsRemoteDatasource {
  final FirebaseFirestore _firestore;
  MealsRemoteDatasource(this._firestore);

  static const String _mealsCollection = 'mealPlans';
  static const String _categoriesCollection = 'mealCategories';

  /// Fetch all meals
  Future<List<MealModel>> getAllMeals() async {
    try {
      print('🔍 Fetching all meals from Firebase...');

      final snapshot = await _firestore.collection(_mealsCollection).get();

      print('📦 Found ${snapshot.docs.length} meal documents');

      final meals = snapshot.docs
          .map((doc) {
            try {
              return MealModel.fromJson(doc.data());
            } catch (e) {
              print('❌ Error parsing meal ${doc.id}: $e');
              return null;
            }
          })
          .whereType<MealModel>()
          .toList();

      print('✅ Successfully parsed ${meals.length} meals');
      return meals;
    } on FirebaseException catch (e) {
      print('❌ Firebase error: ${e.message}');
      throw ServerException(message: 'Firestore error: ${e.message}');
    } catch (e) {
      print('❌ Unexpected error: $e');
      throw ServerException(message: 'Error fetching meals: $e');
    }
  }

  /// Fetch meals by category
  Future<List<MealModel>> getMealsByCategory(String category) async {
    try {
      print('🔍 Fetching meals for category: $category');

      final snapshot = await _firestore
          .collection(_mealsCollection)
          .where('category', isEqualTo: category)
          .get();

      print('📦 Found ${snapshot.docs.length} meals in category: $category');

      final meals = snapshot.docs
          .map((doc) {
            try {
              return MealModel.fromJson(doc.data());
            } catch (e) {
              print('❌ Error parsing meal ${doc.id}: $e');
              return null;
            }
          })
          .whereType<MealModel>()
          .toList();

      return meals;
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }

  /// Fetch meals by diet tag (Vegan, Keto, Traditional)
  Future<List<MealModel>> getMealsByDietTag(String dietTag) async {
    try {
      print('🔍 Fetching meals for diet tag: $dietTag');

      final snapshot = await _firestore
          .collection(_mealsCollection)
          .where('dietTag', isEqualTo: dietTag)
          .get();

      final meals =
          snapshot.docs.map((doc) => MealModel.fromJson(doc.data())).toList();

      print('✅ Found ${meals.length} $dietTag meals');
      return meals;
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }

  /// Fetch available categories
  Future<List<String>> getCategories() async {
    try {
      final snapshot = await _firestore.collection(_categoriesCollection).get();
      return snapshot.docs.map((doc) => doc.id).toList();
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }

  /// Fetch specific meal by ID
  Future<MealModel?> getMealById(String mealId) async {
    try {
      final doc =
          await _firestore.collection(_mealsCollection).doc(mealId).get();

      if (!doc.exists || doc.data() == null) {
        return null;
      }

      return MealModel.fromJson(doc.data()!);
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }
}
