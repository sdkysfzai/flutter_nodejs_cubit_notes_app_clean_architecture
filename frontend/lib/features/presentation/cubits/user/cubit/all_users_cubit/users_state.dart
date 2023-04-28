part of 'users_cubit.dart';

@immutable
abstract class UsersState extends Equatable {}

class UsersInitial extends UsersState {
  @override
  List<Object?> get props => [];
}

class UsersLoading extends UsersState {
  @override
  List<Object?> get props => [];
}

class UsersLoaded extends UsersState {
  UsersLoaded({required this.users});
  final List<UserEntity> users;
  @override
  List<Object?> get props => [users];
}

class UsersFailure extends UsersState {
  @override
  List<Object?> get props => [];
}
