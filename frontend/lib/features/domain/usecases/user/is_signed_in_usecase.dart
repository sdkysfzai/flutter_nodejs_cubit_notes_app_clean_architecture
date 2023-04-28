import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/repository/firebase_repository.dart';

class IsSignedInUseCase {
  IsSignedInUseCase({required this.repository});
  final FirebaseRepository repository;

  Future<bool> call() {
    return repository.isSignedIn();
  }
}
