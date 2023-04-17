import 'package:flutter/material.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/presentation/pages/authentication_page/sign_in_page.dart';

import '../../../../consts.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/form_container_widget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: backGroundColor,
      body: SignUpPageBody(),
    );
  }
}

class SignUpPageBody extends StatelessWidget {
  const SignUpPageBody({super.key});

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
          const FormContainerWidget(
            hintText: "Username",
          ),
          sizeVer(15),
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
            text: "Sign Up",
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
                "Already have an account? ",
                style: TextStyle(color: primaryColor),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInPage()),
                      (route) => false);
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
    );
  }
}
