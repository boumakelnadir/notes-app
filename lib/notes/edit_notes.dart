import 'dart:developer';
import 'package:chatapp2/notes/firestore_note.dart';
import 'package:chatapp2/notes/notes_view.dart';
import 'package:chatapp2/widget/custom_botton.dart';
import 'package:chatapp2/widget/custom_text_form_field.dart';

import 'package:flutter/material.dart';

class EditNotes extends StatefulWidget {
  const EditNotes({
    super.key,
    required this.noteDocId,
    required this.oldNotes,
    required this.categoriesDocId,
  });
  final String noteDocId;
  final String categoriesDocId;
  final String oldNotes;

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final TextEditingController notes = TextEditingController();

  late bool isloading = false;
  @override
  void initState() {
    notes.text = widget.oldNotes;

    super.initState();
  }

  @override
  void dispose() {
    notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
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
                        text: 'Save Edit',
                        onTap: () async {
                          if (formkey.currentState!.validate()) {
                            try {
                              isloading = true;
                              setState(() {});
                              log(widget.noteDocId);
                              await editNotes(
                                  note: notes.text,
                                  noteDocId: widget.noteDocId,
                                  categoriesDocId: widget.categoriesDocId);
                              log(notes.text);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => NotesView(
                                      categoriesDocId: widget.categoriesDocId),
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
