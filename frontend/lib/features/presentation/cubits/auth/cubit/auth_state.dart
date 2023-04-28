part of 'auth_cubit.dart';

@immutable
abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthState {
  Authenticated({required this.uid});
  final String uid;

  @override
  List<Object?> get props => [];
}

class UnAuthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}
