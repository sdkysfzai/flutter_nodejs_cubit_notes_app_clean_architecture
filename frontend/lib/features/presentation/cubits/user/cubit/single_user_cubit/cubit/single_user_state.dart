part of 'single_user_cubit.dart';

abstract class GetSingleUserCubitState extends Equatable {
  const GetSingleUserCubitState();
}

class GetSingleUserCubitInitial extends GetSingleUserCubitState {
  @override
  List<Object> get props => [];
}

class GetSingleUserCubitLoading extends GetSingleUserCubitState {
  @override
  List<Object> get props => [];
}

class GetSingleUserCubitLoaded extends GetSingleUserCubitState {
  final UserEntity user;

  const GetSingleUserCubitLoaded({required this.user});
  @override
  List<Object> get props => [
        user,
      ];
}

class GetSingleUserCubitFailure extends GetSingleUserCubitState {
  @override
  List<Object> get props => [];
}
