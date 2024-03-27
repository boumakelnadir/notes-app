import 'dart:developer';
import 'package:chatapp2/categories/firestore.dart';
import 'package:chatapp2/widget/custom_botton.dart';
import 'package:chatapp2/widget/custom_text_form_field.dart';

import 'package:flutter/material.dart';

class EditCategories extends StatefulWidget {
  const EditCategories({super.key, required this.docid, required this.oldName});
  final String docid;
  final String oldName;

  @override
  State<EditCategories> createState() => _EditCategoriesState();
}

class _EditCategoriesState extends State<EditCategories> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final TextEditingController name = TextEditingController();

  late bool isloading = false;
  @override
  void initState() {
    name.text = widget.oldName;
    super.initState();
  }

  @override
  void dispose() {
    name.text;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Categories'),
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
                      hintText: 'Edit Name File',
                      mycontroller: name,
                      keyboardType: TextInputType.text,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: CustomBotton(
                        text: 'Save Edit ',
                        onTap: () async {
                          if (formkey.currentState!.validate()) {
                            try {
                              isloading = true;
                              setState(() {});

                              await editCategories(
                                newName: name.text,
                                docid: widget.docid,
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
