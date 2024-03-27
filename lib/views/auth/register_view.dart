// ignore_for_file: use_build_context_synchronously
import 'package:chatapp2/helper/constant.dart';
import 'package:chatapp2/helper/dialog.dart';
import 'package:chatapp2/helper/snack_bar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chatapp2/widget/custom_botton.dart';
import 'package:chatapp2/widget/custom_text.dart';
import 'package:chatapp2/widget/custom_text_form_field.dart';
import 'package:chatapp2/widget/question_navigate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey();
  bool isloading = false;
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60, bottom: 35),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                          text: 'Register', fontSize: 30, color: Colors.black),
                      const CustomText(
                          text: 'Register To Continue Using The App',
                          fontSize: 18,
                          color: Colors.grey),
                      const CustomText(text: 'Email', fontSize: 20),
                      CustomTextFormField(
                        hintText: 'Enter Email',
                        iconData: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        mycontroller: email,
                      ),
                      const CustomText(text: 'Password', fontSize: 20),
                      CustomTextFormField(
                        hintText: 'Enter Password',
                        iconData: Icons.remove_red_eye_outlined,
                        keyboardType: TextInputType.number,
                        mycontroller: password,
                      ),
                      CustomBotton(
                        text: 'Register',
                        onTap: () async {
                          if (formkey.currentState!.validate()) {
                            try {
                              isloading = true;
                              setState(() {});
                              await createAccount();
                              FirebaseAuth.instance.currentUser!
                                  .sendEmailVerification();
                              Navigator.of(context).pushNamed('LoginView');
                              showSnackBar(
                                  context, 'please verified your email');
                              isloading = false;
                              setState(() {});
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                dialogAwesome(
                                    context: context,
                                    description: 'weak password',
                                    dialogType: DialogType.error,
                                    title: 'error');
                              } else if (e.code == 'email-already-in-use') {
                                dialogAwesome(
                                  context: context,
                                  description: 'Email already in use',
                                  dialogType: DialogType.error,
                                  title: 'error',
                                );
                              }
                            } catch (e) {
                              showSnackBar(context, e.toString());
                            }
                          }
                        },
                      ),
                      const QuestionNavigate(
                        textBotton: 'Log In',
                        textQuestion: 'already have an account',
                        fontSize: 17,

                        // fontSize: 18,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> createAccount() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.text,
      password: password.text,
    );
  }
}
