import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference categories =
    FirebaseFirestore.instance.collection('categories');

Future<void> addCategories({required String name, required String id}) {
  // Call the categories CollectionReference to add a new categories
  return categories.add({
    'name': name,
    'id': id,
  });
}

Future<void> editCategories({required String docid, required String newName}) {
  // Call the categories CollectionReference to edit categories
  return categories.doc(docid).set(
    {
      'name': newName,
    },
    SetOptions(merge: true),
  );
}
