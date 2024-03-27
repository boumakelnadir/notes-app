// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chatapp2/helper/constant.dart';
import 'package:chatapp2/helper/dialog.dart';
import 'package:chatapp2/views/auth/auth_by_logo/sign_in_social.dart';
import 'package:chatapp2/widget/custom_botton.dart';
import 'package:chatapp2/widget/custom_text.dart';
import 'package:chatapp2/widget/custom_text_form_field.dart';
import 'package:chatapp2/widget/logo_auth.dart';
import 'package:chatapp2/widget/question_navigate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
      body: isloading == false
          ? ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 35, bottom: 25),
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
                              height: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Form(
                        key: formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                                text: 'Log In',
                                fontSize: 30,
                                color: Colors.black),
                            const CustomText(
                                text: 'Login To Continue Using The App',
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
                              iconData: Icons.visibility,
                              keyboardType: TextInputType.number,
                              mycontroller: password,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    if (email.text.isEmpty) {
                                      dialogAwesome(
                                        context: context,
                                        description: 'enter your email',
                                        dialogType: DialogType.error,
                                        title: 'Error',
                                      );
                                      return;
                                    }

                                    await FirebaseAuth.instance
                                        .sendPasswordResetEmail(
                                            email: email.text);

                                    dialogAwesome(
                                      context: context,
                                      description:
                                          'We are send link reset to your email',
                                      dialogType: DialogType.info,
                                      title: 'Info',
                                    );
                                  },
                                  child: CustomText(
                                    text: 'forget Password ?',
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            CustomBotton(
                              text: 'Log In',
                              onTap: () async {
                                if (formkey.currentState!.validate()) {
                                  try {
                                    isloading = true;
                                    setState(() {});
                                    await signinAccount();

                                    FirebaseAuth
                                            .instance.currentUser!.emailVerified
                                        ? Navigator.of(context)
                                            .pushNamed('HomeView')
                                        : dialogAwesome(
                                            context: context,
                                            description:
                                                'please verified your email',
                                            dialogType: DialogType.info,
                                            title: 'Info',
                                          );
                                    isloading = false;
                                    setState(() {});
                                  } on FirebaseAuthException catch (e) {
                                    isloading = false;
                                    setState(() {});
                                    if (e.code == 'user-not-found') {
                                      dialogAwesome(
                                          context: context,
                                          description:
                                              'Not Found That Email ,Try Again !',
                                          dialogType: DialogType.error,
                                          title: 'error');
                                    } else if (e.code == 'wrong-password') {
                                      dialogAwesome(
                                        context: context,
                                        description:
                                            'Wrong Password ,Try again !',
                                        dialogType: DialogType.error,
                                        title: 'error',
                                      );
                                    }
                                  } catch (e) {
                                    log(e.toString());
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                CustomText(
                  text: ' Or With',
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        isloading = true;
                        setState(() {});
                        await signInWithGoogle(context);
                        isloading = false;
                        setState(() {});
                      },
                      child: const LogoAuth(logo: kLogoGoogle),
                    ),
                    const LogoAuth(logo: kLogoApple),
                    const LogoAuth(logo: kLogoInstagram),
                  ],
                ),
                const QuestionNavigate(
                  textBotton: 'Register',
                  textQuestion: "dont have an account ?",
                  fontSize: 17,
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> signinAccount() async {
    UserCredential user =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.text,
      password: password.text,
    );
  }
}
