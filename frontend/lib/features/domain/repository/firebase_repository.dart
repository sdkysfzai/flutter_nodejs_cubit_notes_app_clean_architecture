import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/entities/user/user_entity.dart';

abstract class FirebaseRepository {
  //credential
  Future<void> signInUser(UserEntity user);
  Future<void> signUpUser(UserEntity user);
  Future<void> isSinedIn();
  Future<void> signOut();

  //user
  Future<UserEntity> getSingleUser(String uid);
  Future<String> getCurrentUid();
  Future<void> createUser();
  Future<void> updateUser();
  Future<void> deleteUser();
}
