// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chatapp2/categories/edit_categories.dart';
import 'package:chatapp2/helper/constant.dart';
import 'package:chatapp2/helper/dialog.dart';
import 'package:chatapp2/notes/notes_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isloading = true;

  List<QueryDocumentSnapshot> data = [];
  Future<void> getdata() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('AddCategories');
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Home page'),
        actions: [
          IconButton(
            onPressed: () async {
              try {
                GoogleSignIn googleSignIn = GoogleSignIn();
                googleSignIn.disconnect();

                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamed('AuthView');
              } catch (e) {
                log(e.toString());
              }
            },
            icon: const Icon(
              Icons.exit_to_app_outlined,
            ),
          )
        ],
      ),
      body: isloading == true
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NotesView(
                        categoriesDocId: data[index].id,
                      ),
                    ),
                  ),
                  onLongPress: () {
                    dialogAwesome(
                      context: context,
                      description: 'Do You Want Delete The Filed ?',
                      dialogType: DialogType.warning,
                      title: 'Warning',
                      btnOkText: 'Yes',
                      btnOkColor: Colors.red,
                      btnOkOnPress: () async {
                        await FirebaseFirestore.instance
                            .collection('categories')
                            .doc(data[index].id)
                            .delete();
                        Navigator.of(context).pushNamed('HomeView');
                      },
                      btnCancelColor: Colors.green,
                      btnCancelText: 'Edit',
                      btnCancelOnPress: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditCategories(
                            docid: data[index].id,
                            oldName: data[index]['name'],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Image.asset(kLogoFolderPng),
                          Text(
                            "${data[index]['name']}",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
