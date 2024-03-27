import 'dart:developer';
import 'package:chatapp2/categories/firestore.dart';
import 'package:chatapp2/widget/custom_botton.dart';
import 'package:chatapp2/widget/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class AddCategories extends StatefulWidget {
  const AddCategories({super.key});

  @override
  State<AddCategories> createState() => _AddCategoriesState();
}

class _AddCategoriesState extends State<AddCategories> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final TextEditingController name = TextEditingController();

  late bool isloading = false;
  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Categories'),
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: isloading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      hintText: 'Name File',
                      mycontroller: name,
                      keyboardType: TextInputType.text,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: CustomBotton(
                        text: 'Add ',
                        onTap: () async {
                          if (formkey.currentState!.validate()) {
                            try {
                              isloading = true;
                              setState(() {});

                              await addCategories(
                                name: name.text,
                                id: FirebaseAuth.instance.currentUser!.uid,
                              );

                              Navigator.of(context).pushNamedAndRemoveUntil(
                                'HomeView',
                                (route) => false,
                              );
                            } catch (e) {
                              isloading = false;
                              setState(() {});
                              log(e.toString());
                            }
                          }
                        },
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
