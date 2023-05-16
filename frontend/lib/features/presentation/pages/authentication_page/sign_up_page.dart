import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/presentation/cubits/auth/cubit/auth_cubit.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/presentation/pages/main_screen/main_screen.dart';
import '../../../domain/entities/user/user_entity.dart';
import '../../../utils/consts/color_consts.dart';
import '../../../utils/consts/page_consts.dart';
import '../../../utils/extensions/helper_methods.dart';
import '../../cubits/credential/cubit/credential_cubit.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/form_container_widget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CredentialCubit, CredentialState>(
      listener: (context, credentialState) {
        if (credentialState is CredentialSuccess) {
          BlocProvider.of<AuthCubit>(context).loggedIn();
        } else if (credentialState is CredentialFailure) {
          toast("Invalid email or password");
        }
      },
      builder: (context, credentialState) {
        if (credentialState is CredentialSuccess) {
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              if (authState is Authenticated) {
                return MainScreen(uid: authState.uid);
              } else {
                return const Scaffold(
                  backgroundColor: backGroundColor,
                  body: SignUpPageBody(),
                );
              }
            },
          );
        }
        return const Scaffold(
          backgroundColor: backGroundColor,
          body: SignUpPageBody(),
        );
      },
    );
  }
}

class SignUpPageBody extends StatefulWidget {
  const SignUpPageBody({super.key});

  @override
  State<SignUpPageBody> createState() => _SignUpPageBodyState();
}

class _SignUpPageBodyState extends State<SignUpPageBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isSigningUp = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Container(),
            ),
            sizeVer(15),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    // child: Image.asset("assets/profile_default.png"),
                  ),
                  Positioned(
                    right: -10,
                    bottom: -15,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: blueColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            sizeVer(30),
            FormContainerWidget(
              hintText: "Username",
              controller: _usernameController,
              validator: validateName,
            ),
            sizeVer(15),
            FormContainerWidget(
              hintText: "Email",
              controller: _emailController,
              validator: validateEmail,
            ),
            sizeVer(15),
            FormContainerWidget(
                hintText: "Password",
                isPasswordField: true,
                controller: _passwordController,
                validator: validatePass),
            sizeVer(15),
            _isSigningUp
                ? const CircularProgressIndicator(
                    color: primaryColor,
                  )
                : ButtonContainerWidget(
                    text: 'Sign Up',
                    onTapListener: () {
                      _signUpUser();
                    },
                    color: blueColor),
            Flexible(
              flex: 2,
              child: Container(),
            ),
            const Divider(
              color: secondaryColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(color: primaryColor),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, PageConst.signInPage, (route) => false);
                  },
                  child: const Text(
                    "Sign In.",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: primaryColor),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _signUpUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSigningUp = true;
      });
      BlocProvider.of<CredentialCubit>(context)
          .signUpUser(
              user: UserEntity(
        email: _emailController.text.trim(),
        username: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      ))
          .then((value) {
        setState(() {
          _isSigningUp = false;
        });
      });
    }
  }
}
