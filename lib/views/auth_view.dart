import 'package:chatapp2/helper/constant.dart';
import 'package:chatapp2/views/auth/login_view.dart';
import 'package:chatapp2/views/auth/register_view.dart';
import 'package:chatapp2/widget/custom_text.dart';
import 'package:chatapp2/widget/question_navigate.dart';
import 'package:flutter/material.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80, bottom: 50),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    color: Colors.grey[300],
                  ),
                  height: 80,
                  width: 80,
                  child: Image.asset(
                    kLogoApp,
                    height: 50,
                  ),
                ),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: 'Welcome To Our Store',
                fontSize: 35,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 150),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QuestionNavigate(
                  textBotton: 'Register',
                  textQuestion: '',
                  fontSize: 35,
                  navigator: RegisterView(),
                ),
                const SizedBox(width: 20),
                const QuestionNavigate(
                  textBotton: 'Log In',
                  textQuestion: 'Or',
                  fontSize: 35,
                  navigator: LoginView(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
