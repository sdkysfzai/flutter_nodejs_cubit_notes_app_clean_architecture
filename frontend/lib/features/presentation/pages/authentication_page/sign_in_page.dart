import 'package:flutter/material.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/presentation/pages/authentication_page/sign_up_page.dart';

import '../../../../consts.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/form_container_widget.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: backGroundColor,
      body: SignInPageBody(),
    );
  }
}

class SignInPageBody extends StatefulWidget {
  const SignInPageBody({super.key});

  @override
  State<SignInPageBody> createState() => _SignInPageBodyState();
}

class _SignInPageBodyState extends State<SignInPageBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            child: Container(),
          ),
          sizeVer(30),
          const FormContainerWidget(
            hintText: "Email",
          ),
          sizeVer(15),
          const FormContainerWidget(
            hintText: "Password",
            isPasswordField: true,
          ),
          sizeVer(15),
          ButtonContainerWidget(
            color: blueColor,
            text: "Sign In",
            onTapListener: () {},
          ),
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
                "Don't have and account? ",
                style: TextStyle(color: primaryColor),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()),
                      (route) => false);
                },
                child: const Text(
                  "Sign Up.",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: primaryColor),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
