import '../../../../domain/entities/user/user_entity.dart';

abstract class FirebaseRemoteDataSource {
  //credential
  Future<void> signInUser(UserEntity user);
  Future<void> signUpUser(UserEntity user);
  Future<bool> isSignedIn();
  Future<void> signOut();

  //user
  Future<UserEntity> getSingleUser(String uid);
  Future<List<UserEntity>> getAllUsers();
  Future<String> getCurrentUid();
  Future<void> createUser(UserEntity user);
  Future<void> updateUser(UserEntity user);
  Future<void> deleteUser(UserEntity user);
}
