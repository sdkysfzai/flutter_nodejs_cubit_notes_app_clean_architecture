import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/entities/user/user_entity.dart';

import '../../repository/firebase_repository.dart';

class GetAllUsersUsecase {
  final FirebaseRepository repository;

  GetAllUsersUsecase({required this.repository});

  Future<List<UserEntity>> call() {
    return repository.getAllUsers();
  }
}
