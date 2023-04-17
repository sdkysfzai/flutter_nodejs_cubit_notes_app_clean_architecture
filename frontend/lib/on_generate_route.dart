import 'package:flutter/material.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/consts.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/presentation/pages/authentication_page/sign_in_page.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/presentation/pages/authentication_page/sign_up_page.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/presentation/pages/main_screen/add_note_page/add_note_page.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/presentation/pages/main_screen/favorite_notes_page/favorite_notes_page.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/presentation/pages/main_screen/home_page/home_page.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/presentation/pages/main_screen/profile_page/profile_page.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case PageConst.signInPage:
        {
          return routeBuilder(const SignInPage());
        }
      case PageConst.signupPage:
        {
          return routeBuilder(const SignUpPage());
        }
      case PageConst.homePage:
        {
          return routeBuilder(const HomePage());
        }
      case PageConst.favoritePage:
        {
          return routeBuilder(const FavoriteNotesPage());
        }
      case PageConst.addNotePage:
        {
          return routeBuilder(const AddNotePage());
        }
      case PageConst.profilePage:
        {
          return routeBuilder(const ProfilePage());
        }
      default:
        {
          return routeBuilder(const NoPageFound());
        }
    }
  }
}

dynamic routeBuilder(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

class NoPageFound extends StatelessWidget {
  const NoPageFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page not found"),
      ),
      body: const Center(
        child: Text("Page not found"),
      ),
    );
  }
}
