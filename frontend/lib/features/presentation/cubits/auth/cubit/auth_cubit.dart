import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/usecases/user/is_signed_in_usecase.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/usecases/user/sign_out_usecase.dart';

import '../../../../domain/usecases/user/get_current_uid_usecase.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.isSignedInUseCase,
    required this.getCurrentUidUseCase,
    required this.signOutUserUseCase,
  }) : super(AuthInitial());
  final SignOutUserUseCase signOutUserUseCase;
  final IsSignedInUseCase isSignedInUseCase;
  final GetCurrentUidUseCase getCurrentUidUseCase;

  Future<void> appStarted() async {
    //TODO: need try catch, but try catch shouldn't be in presentation layer but in data layer
    try {
      bool isSignedIn = await isSignedInUseCase.call();
      if (isSignedIn) {
        final uid = await getCurrentUidUseCase.call();
        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticated());
      }
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUidUseCase.call();
      emit(Authenticated(uid: uid));
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedOut() async {
    try {
      await signOutUserUseCase.call();
      emit(UnAuthenticated());
    } catch (_) {
      emit(UnAuthenticated());
    }
  }
}
