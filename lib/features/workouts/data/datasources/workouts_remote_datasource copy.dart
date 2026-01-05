// lib/features/workouts/data/datasources/workouts_remote_datasource.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/core/errors/exceptions.dart';
import 'package:fitness/features/workouts/data/models/workout_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class WorkoutsRemoteDatasource {
  final FirebaseFirestore _firestore;

  WorkoutsRemoteDatasource(
    this._firestore,
  );

  static const String _workoutsCollection = 'workouts';

  Future<List<WorkoutModel>> getWorkouts({
    required String gender,
    String? location,
  }) async {
    try {
      // Get all documents in the workouts collection
      final snapshot = await _firestore.collection(_workoutsCollection).get();

      if (snapshot.docs.isEmpty) {
        return [];
      }

      List<WorkoutModel> allWorkouts = [];

      for (final doc in snapshot.docs) {
        try {
          final data = doc.data();

          // Handle Firestore timestamp conversion
          if (data['lastUpdated'] != null) {
            if (data['lastUpdated'] is Timestamp) {
              final timestamp = data['lastUpdated'] as Timestamp;
              data['lastUpdated'] = timestamp.toDate().toIso8601String();
            }
          }

          // Parse the workout
          final workout = WorkoutModel.fromJson(data);

          // Filter by location if specified
          if (location == null || location.toLowerCase() == 'both') {
            // Include all locations
            allWorkouts.add(workout);
          } else if (workout.location.toLowerCase() == location.toLowerCase() ||
              workout.location.toLowerCase() == 'both') {
            // Include if location matches or workout is marked as 'both'
            allWorkouts.add(workout);
          } else {}
        } catch (e) {
          // Skip this document and continue with others
          continue;
        }
      }

      return allWorkouts;
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    } catch (e) {
      throw ServerException(message: 'Error fetching workouts: $e');
    }
  }

  Future<WorkoutModel?> getWorkoutByDay({
    required String gender,
    required String day,
    required String location,
  }) async {
    try {
      // Create document ID in the format: "DayName_location"
      final docId = '${day}_$location';

      final doc =
          await _firestore.collection(_workoutsCollection).doc(docId).get();

      if (!doc.exists || doc.data() == null) {
        return null;
      }

      final data = doc.data()!;

      // Handle Firestore timestamp conversion
      if (data['lastUpdated'] != null) {
        if (data['lastUpdated'] is Timestamp) {
          final timestamp = data['lastUpdated'] as Timestamp;
          data['lastUpdated'] = timestamp.toDate().toIso8601String();
        }
      }

      return WorkoutModel.fromJson(data);
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    } catch (e) {
      throw ServerException(message: 'Error fetching workout: $e');
    }
  }

  /// Get all available workout days
  Future<List<String>> getAvailableDays({
    required String gender,
    String? location,
  }) async {
    try {
      final workouts = await getWorkouts(gender: gender, location: location);
      final days = workouts.map((w) => w.day).toSet().toList();

      // Sort days in week order
      final daysOrder = [
        'Sunday',
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday'
      ];

      days.sort((a, b) => daysOrder.indexOf(a).compareTo(daysOrder.indexOf(b)));

      return days;
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }

  /// Filter workouts by muscle category
  Future<List<WorkoutModel>> getWorkoutsByMuscleGroup({
    required String gender,
    required String muscleCategory,
    String? location,
  }) async {
    try {
      final allWorkouts = await getWorkouts(gender: gender, location: location);
      return allWorkouts
          .where((w) =>
              w.muscleCategory.toLowerCase() == muscleCategory.toLowerCase())
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }
}
