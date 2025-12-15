// lib/features/onboarding/data/datasources/onboarding_remote_datasource.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // To get current UID
import 'package:fitness/core/errors/exceptions.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class OnboardingRemoteDatasource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  // Injecting FirebaseAuth for UID access, ensuring a clean dependency
  OnboardingRemoteDatasource(this._firestore, this._auth);

  // Collection name constant (a good practice)
  static const String _collection = 'userProfiles';

  /// Retrieves the current user's UID safely.
  String get _currentUid {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      throw ServerException(message: 'User is not authenticated.');
    }
    return uid;
  }

  /// Saves the user's fitness profile data to Firestore.
  Future<void> saveProfile(FitnessProfileModel profile) async {
    try {
      // Use the current UID as the document ID (pro approach)
      await _firestore
          .collection(_collection)
          .doc(_currentUid)
          .set(profile.toJson());
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }

  /// Retrieves the current user's fitness profile data.
  Future<FitnessProfileModel?> getProfile() async {
    try {
      final uid = _currentUid;
      final doc = await _firestore.collection(_collection).doc(uid).get();

      if (!doc.exists || doc.data() == null) {
        return null; // Profile not completed yet
      }
      return FitnessProfileModel.fromJson(doc.data()!);
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }
}
