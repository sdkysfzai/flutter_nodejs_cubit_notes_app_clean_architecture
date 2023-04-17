import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/entities/user/user_entity.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/repository/firebase_repository.dart';

class CreateUserUseCase {
  CreateUserUseCase({required this.repository});
  final FirebaseRepository repository;

  Future<void> call(UserEntity user) {
    return repository.createUser(user);
  }
}
