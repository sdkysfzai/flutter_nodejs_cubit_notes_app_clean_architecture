import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/presentation/cubits/auth/cubit/auth_cubit.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/presentation/cubits/credential/cubit/credential_cubit.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/presentation/cubits/user/cubit/all_users_cubit/users_cubit.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/presentation/cubits/user/cubit/single_user_cubit/cubit/single_user_cubit.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/presentation/pages/authentication_page/sign_in_page.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/config/routes/on_generate_route.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/presentation/pages/main_screen/home_page/home_page.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/presentation/pages/main_screen/main_screen.dart';
import '../injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthCubit>()..appStarted()),
        BlocProvider(create: (_) => di.sl<CredentialCubit>()),
        BlocProvider(create: (_) => di.sl<UsersCubit>()),
        BlocProvider(create: (_) => di.sl<GetSingleUserCubit>()),

        /*
        We use GetIt as DI to easily access all the required dependencies
        BlocProvider(
            create: (context) => AuthCubit(
                  isSignedInUseCase: isSignedInUseCase, <- These dependencies
                  getCurrentUidUseCase: getCurrentUidUseCase,
                  signOutUserUseCase: signOutUserUseCase,
                ))
                */
      ],
      child: MaterialApp(
        title: 'Flutter Notes App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        onGenerateRoute: OnGenerateRoute.route,
        initialRoute: "/",
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
              if (authState is Authenticated) {
                return MainScreen(
                  uid: authState.uid,
                );
              } else {
                return const SignInPage();
              }
            });
          },
        },
      ),
    );
  }
}


/*
Watched thoroughly your code
What I didn't liked 
1. You have features folder but you didn't separated features
Like you have everything inside one file 
What you could have done is that having 
Auth 
Comment
Post
Profile
These kind of subfeatures inside feature folder 
And having domain data and presentation layer inside each subfeature 
This could really make file leaner and more maintainable
2. Showing toast directly from data layer 
Your data layer should only be responsible for handling data related task 
Like fetching data and handling exception nothing else 
3. Your cubit are also handling exception logics
Which shouldn't be done 
Instead handle exception in data layer 
And pass in failure to domain layer usecases 
4. Having more than one usecase dependency inside single cubit 
Eg. DeleteUsecase
CommentUsecase
Replyusecase inside a cubit 
Rater create one major usecase 
And have those injected inside that usecase 
And use single usecase in cubit 
Overall code looks clean. That's my feedback. Hope you don't mind
*/