import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/repository/firebase_repository.dart';

class GetCurrentUidUseCase {
  final FirebaseRepository repository;
  GetCurrentUidUseCase({required this.repository});

  Future<String> call() {
    return repository.getCurrentUid();
  }
}
