// ignore_for_file: use_build_context_synchronously
import 'dart:math' as math;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chatapp2/helper/dialog.dart';
import 'package:chatapp2/notes/add_notes.dart';
import 'package:chatapp2/notes/edit_notes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key, required this.categoriesDocId});
  final String categoriesDocId;
  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  bool isloading = true;

  List<QueryDocumentSnapshot> data = [];
  Future<void> getdata() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.categoriesDocId)
        .collection('note')
        .get();

    data.addAll(querySnapshot.docs);
    isloading = false;
    setState(() {});
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color colorsramdom =
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.7);

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddNotes(docid: widget.categoriesDocId),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('Notes View'),
        ),
        body: PopScope(
            child: isloading == true
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onLongPress: () {
                          dialogAwesome(
                              context: context,
                              description: 'Do You Want Delete This Note ?',
                              dialogType: DialogType.warning,
                              title: 'Warning',
                              btnOkText: 'Yes',
                              btnOkOnPress: () async {
                                await FirebaseFirestore.instance
                                    .collection('categories')
                                    .doc(widget.categoriesDocId)
                                    .collection('note')
                                    .doc(data[index].id)
                                    .delete();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => NotesView(
                                        categoriesDocId:
                                            widget.categoriesDocId),
                                  ),
                                );
                              },
                              btnCancelOnPress: () {});
                        },
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditNotes(
                            noteDocId: data[index].id,
                            oldNotes: data[index]['note'],
                            categoriesDocId: widget.categoriesDocId,
                          ),
                        )),
                        child: Card(
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: colorsramdom,
                                borderRadius: BorderRadius.circular(16)),
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Text(
                                  "${data[index]['note']}",
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
            canPop: false,
            onPopInvoked: (val) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('HomeView', (route) => false);
            }));
  }
}
