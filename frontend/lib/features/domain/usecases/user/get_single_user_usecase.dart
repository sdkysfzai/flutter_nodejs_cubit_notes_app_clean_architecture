import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/entities/user/user_entity.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/repository/firebase_repository.dart';

class GetSingleUserUseCase {
  final FirebaseRepository repository;

  GetSingleUserUseCase({required this.repository});

  Future<UserEntity> call(String uid) {
    return repository.getSingleUser(uid);
  }
}
