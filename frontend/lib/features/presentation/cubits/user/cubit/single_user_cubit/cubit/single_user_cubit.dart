import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/entities/user/user_entity.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/usecases/user/get_single_user_usecase.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/usecases/user/update_user_usecase.dart';
part 'single_user_state.dart';

class GetSingleUserCubit extends Cubit<GetSingleUserCubitState> {
  GetSingleUserCubit({
    required this.getUserUsecase,
    required this.updateUserUseCase,
  }) : super(GetSingleUserCubitInitial());
  final GetSingleUserUseCase getUserUsecase;
  final UpdateUserUseCase updateUserUseCase;

  Future<void> getUser({required String uid}) async {
    emit(GetSingleUserCubitLoading());

    try {
      final user = await getUserUsecase.call(uid);
      emit(GetSingleUserCubitLoaded(user: user));
    } on SocketException catch (_) {
      emit(GetSingleUserCubitFailure());
    } catch (_) {
      emit(GetSingleUserCubitFailure());
    }
  }

  Future<void> updateUser({required UserEntity user}) async {
    try {
      await updateUserUseCase.call(user);
    } catch (_) {}
  }
}
