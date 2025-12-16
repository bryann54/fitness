// lib/features/onboarding/data/datasources/onboarding_remote_datasource.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/core/errors/exceptions.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class OnboardingRemoteDatasource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  OnboardingRemoteDatasource(this._firestore, this._auth);

  static const String _collection = 'userProfiles';

  String get _currentUid {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      throw ServerException(message: 'User is not authenticated.');
    }
    return uid;
  }

  Future<void> saveProfile(FitnessProfileModel profile) async {
    try {
      final uid = _currentUid;

      // Ensure the profile has the correct UID
      final profileWithUid = profile.copyWith(uid: uid);

      await _firestore
          .collection(_collection)
          .doc(uid)
          .set(profileWithUid.toJson(), SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }

  Future<FitnessProfileModel?> getProfile() async {
    try {
      final uid = _currentUid;
      final doc = await _firestore.collection(_collection).doc(uid).get();

      if (!doc.exists || doc.data() == null) {
        return null;
      }
      return FitnessProfileModel.fromJson(doc.data()!);
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }
}
