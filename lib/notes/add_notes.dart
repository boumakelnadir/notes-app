import 'dart:developer';
import 'package:chatapp2/notes/firestore_note.dart';
import 'package:chatapp2/notes/notes_view.dart';
import 'package:chatapp2/widget/custom_botton.dart';
import 'package:chatapp2/widget/custom_text_form_field.dart';

import 'package:flutter/material.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key, required this.docid});
  final String docid;

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final TextEditingController notes = TextEditingController();

  late bool isloading = false;
  @override
  void dispose() {
    notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
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
                      hintText: 'Write Notes',
                      mycontroller: notes,
                      keyboardType: TextInputType.text,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: CustomBotton(
                        text: 'Add Notes',
                        onTap: () async {
                          if (formkey.currentState!.validate()) {
                            try {
                              isloading = true;
                              setState(() {});

                              await addNotes(
                                noteText: notes.text,
                                docid: widget.docid,
                              );

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      NotesView(categoriesDocId: widget.docid),
                                ),
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
