import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/presentation/cubits/auth/cubit/auth_cubit.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/presentation/widgets/button_widget.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/utils/consts/page_consts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Home Page'), actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<AuthCubit>(context).loggedOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    PageConst.signInPage, (route) => false);
              },
              icon: const Icon(Icons.logout))
        ]),
        body: const HomePageBody());
  }
}

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}
