import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? email;
  final String? username;
  final String? uid;
  final String? password;

  const UserEntity({this.email, this.username, this.uid, this.password});

  @override
  List<Object?> get props => [
        email,
        username,
        uid,
        password,
      ];
}
