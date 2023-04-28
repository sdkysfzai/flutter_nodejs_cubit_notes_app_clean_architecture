import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/entities/user/user_entity.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/usecases/get_all_users_usecase.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/usecases/user/update_user_usecase.dart';
part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit({
    required this.getAllUsersUsecase,
    required this.updateUserUseCase,
  }) : super(UsersInitial());
  final UpdateUserUseCase updateUserUseCase;
  final GetAllUsersUsecase getAllUsersUsecase;

  Future<void> getUsers() async {
    final List<UserEntity> users = [];
    emit(UsersLoading());
    try {
      final data = await getAllUsersUsecase.call();
      users.followedBy(data);
      emit(UsersLoaded(users: users));
    } on SocketException catch (_) {
      emit(UsersFailure());
    } catch (_) {
      emit(UsersFailure());
    }
  }
}
