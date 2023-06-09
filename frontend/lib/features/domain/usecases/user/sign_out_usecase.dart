import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/repository/firebase_repository.dart';

class SignOutUserUseCase {
  SignOutUserUseCase({required this.repository});
  final FirebaseRepository repository;

  Future<void> call() {
    return repository.signOut();
  }
}
