import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/data/data_sources/remote_data_source/firebase_data_source/firebase_data_source.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/entities/user/user_entity.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/repository/firebase_repository.dart';

class FirebaseRepositoryImplementation extends FirebaseRepository {
  FirebaseRepositoryImplementation({required this.firebaseRemoteDataSource});

  final FirebaseRemoteDataSource firebaseRemoteDataSource;
  @override
  Future<void> createUser(UserEntity user) {
    return firebaseRemoteDataSource.createUser(user);
  }

  @override
  Future<void> deleteUser(UserEntity user) {
    return firebaseRemoteDataSource.deleteUser(user);
  }

  @override
  Future<String> getCurrentUid() {
    return firebaseRemoteDataSource.getCurrentUid();
  }

  @override
  Future<UserEntity> getSingleUser(String uid) {
    return firebaseRemoteDataSource.getSingleUser(uid);
  }

  @override
  Future<void> isSinedIn() {
    return firebaseRemoteDataSource.isSinedIn();
  }

  @override
  Future<void> signInUser(UserEntity user) {
    return firebaseRemoteDataSource.signInUser(user);
  }

  @override
  Future<void> signOut() {
    return firebaseRemoteDataSource.signOut();
  }

  @override
  Future<void> signUpUser(UserEntity user) {
    return firebaseRemoteDataSource.signUpUser(user);
  }

  @override
  Future<void> updateUser(UserEntity user) {
    return firebaseRemoteDataSource.updateUser(user);
  }
}
