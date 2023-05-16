import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/data/data_sources/remote_data_source/firebase_data_source/firebase_data_source.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/data/data_sources/remote_data_source/firebase_data_source/firebase_data_source_implementation.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/data/repository/firebase_repository_implementation.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/repository/firebase_repository.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/usecases/user/create_user_usecase.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/usecases/user/delete_user_usecase.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/usecases/user/get_all_users_usecase.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/usecases/user/get_current_uid_usecase.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/usecases/user/get_single_user_usecase.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/usecases/user/is_signed_in_usecase.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/usecases/user/sign_in_user_usecase.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/usecases/user/sign_out_usecase.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/usecases/user/sign_up_user_usecase.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/usecases/user/update_user_usecase.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/presentation/cubits/auth/cubit/auth_cubit.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/presentation/cubits/credential/cubit/credential_cubit.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/presentation/cubits/user/cubit/all_users_cubit/users_cubit.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/presentation/cubits/user/cubit/single_user_cubit/cubit/single_user_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //cubits
  sl.registerFactory(() => AuthCubit(
        isSignedInUseCase: sl.call(),
        getCurrentUidUseCase: sl.call(),
        signOutUserUseCase: sl.call(),
      ));

  sl.registerFactory(() => CredentialCubit(
        signInUserUseCase: sl.call(),
        signUpUserUseCase: sl.call(),
      ));

  sl.registerFactory(() => UsersCubit(
        getAllUsersUsecase: sl.call(),
        updateUserUseCase: sl.call(),
      ));
  sl.registerFactory(() => GetSingleUserCubit(
      getUserUsecase: sl.call(), updateUserUseCase: sl.call()));

  //usecases
  sl.registerLazySingleton(() => CreateUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => DeleteUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetAllUsersUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetSingleUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => IsSignedInUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => SignInUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => SignOutUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => SignUpUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdateUserUseCase(repository: sl.call()));

  //repositories
  sl.registerLazySingleton<FirebaseRepository>(() =>
      FirebaseRepositoryImplementation(firebaseRemoteDataSource: sl.call()));
  //remote data source
  sl.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(auth: sl.call(), firestore: sl.call()));

  //externals
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;

  sl.registerLazySingleton(() => firebaseFirestore);
  sl.registerLazySingleton(() => firebaseAuth);
}
