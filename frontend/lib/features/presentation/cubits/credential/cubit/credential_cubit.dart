import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/entities/user/user_entity.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/usecases/user/sign_in_user_usecase.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/usecases/user/sign_up_user_usecase.dart';
part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  CredentialCubit({
    required this.signInUserUseCase,
    required this.signUpUserUseCase,
  }) : super(CredentialInitial());
  final SignInUserUseCase signInUserUseCase;
  final SignUpUserUseCase signUpUserUseCase;

  Future<void> signInUser(
      {required String email, required String password}) async {
    emit(CredentialLoading());
    try {
      await signInUserUseCase
          .call(UserEntity(email: email, password: password));
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> signUpUser({required UserEntity user}) async {
    emit(CredentialLoading());
    try {
      await signUpUserUseCase.call(user);
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }
}
