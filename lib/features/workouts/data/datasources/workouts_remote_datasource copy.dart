// lib/features/workouts/data/datasources/workouts_remote_datasource.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/core/errors/exceptions.dart';
import 'package:fitness/features/workouts/data/models/workout_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class WorkoutsRemoteDatasource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  WorkoutsRemoteDatasource(this._firestore, this._auth);

  static const String _workoutsCollection = 'workouts';

  String get _currentUid {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      throw ServerException(message: 'User is not authenticated.');
    }
    return uid;
  }

  /// Fetch workouts based on gender and location preference
  /// The data structure in Firebase is: workouts/{DayName_location}
  /// Example: "Sunday_gym", "Monday_home"
  Future<List<WorkoutModel>> getWorkouts({
    required String gender,
    String? location,
  }) async {
    try {
      print('🔍 === FETCHING WORKOUTS ===');
      print('🔍 Gender: $gender');
      print('🔍 Location: $location');

      // Get all documents in the workouts collection
      final snapshot = await _firestore.collection(_workoutsCollection).get();

      print('📦 Found ${snapshot.docs.length} total workout documents');

      if (snapshot.docs.isEmpty) {
        print('⚠️  WARNING: workouts collection is EMPTY!');
        return [];
      }

      List<WorkoutModel> allWorkouts = [];

      for (final doc in snapshot.docs) {
        try {
          final data = doc.data();

          print('📄 Processing document: ${doc.id}');
          print('   Has exercises: ${data.containsKey('exercises')}');
          print('   Location: ${data['location']}');

          // Handle Firestore timestamp conversion
          if (data['lastUpdated'] != null) {
            if (data['lastUpdated'] is Timestamp) {
              final timestamp = data['lastUpdated'] as Timestamp;
              data['lastUpdated'] = timestamp.toDate().toIso8601String();
            }
          }

          // Parse the workout
          final workout = WorkoutModel.fromJson(data);

          print('   Parsed workout: ${workout.day} - ${workout.location}');

          // Filter by location if specified
          if (location == null || location.toLowerCase() == 'both') {
            // Include all locations
            allWorkouts.add(workout);
            print('   ✅ Added (showing all)');
          } else if (workout.location.toLowerCase() == location.toLowerCase() ||
              workout.location.toLowerCase() == 'both') {
            // Include if location matches or workout is marked as 'both'
            allWorkouts.add(workout);
            print('   ✅ Added (location match)');
          } else {
            print(
                '   ⏭️  Skipped (location mismatch: ${workout.location} != $location)');
          }
        } catch (e, stackTrace) {
          print('❌ Error parsing document ${doc.id}: $e');
          print('   Stack: $stackTrace');
          // Skip this document and continue with others
          continue;
        }
      }

      print('🎉 Total workouts loaded: ${allWorkouts.length}');
      return allWorkouts;
    } on FirebaseException catch (e) {
      print('❌ Firebase error: ${e.message}');
      throw ServerException(message: 'Firestore error: ${e.message}');
    } catch (e, stackTrace) {
      print('❌ Unexpected error: $e');
      print('   Stack: $stackTrace');
      throw ServerException(message: 'Error fetching workouts: $e');
    }
  }

  /// Fetch a specific workout by day and location
  /// Document ID format: "DayName_location"
  /// Example: "Sunday_gym"
  Future<WorkoutModel?> getWorkoutByDay({
    required String gender,
    required String day,
    required String location,
  }) async {
    try {
      // Create document ID in the format: "DayName_location"
      final docId = '${day}_$location';

      print('🔍 Fetching workout document: $docId');

      final doc =
          await _firestore.collection(_workoutsCollection).doc(docId).get();

      if (!doc.exists || doc.data() == null) {
        print('❌ Workout not found: $docId');
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

      print('✅ Workout found: $docId');
      return WorkoutModel.fromJson(data);
    } on FirebaseException catch (e) {
      print('❌ Firebase error: ${e.message}');
      throw ServerException(message: 'Firestore error: ${e.message}');
    } catch (e) {
      print('❌ Unexpected error: $e');
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
