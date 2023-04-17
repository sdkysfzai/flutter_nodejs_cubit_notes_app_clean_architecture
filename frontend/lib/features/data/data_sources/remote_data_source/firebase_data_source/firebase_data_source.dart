import '../../../../domain/entities/user/user_entity.dart';

abstract class FirebaseRemoteDataSource {
  //credential
  Future<void> signInUser(UserEntity user);
  Future<void> signUpUser(UserEntity user);
  Future<void> isSinedIn();
  Future<void> signOut();

  //user
  Future<UserEntity> getSingleUser(String uid);
  Future<String> getCurrentUid();
  Future<void> createUser(UserEntity user);
  Future<void> updateUser(UserEntity user);
  Future<void> deleteUser(UserEntity user);
}
