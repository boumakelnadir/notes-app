import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference notes = FirebaseFirestore.instance.collection('categories');

Future<void> addNotes({required String docid, required String noteText}) {
  // Call the categories CollectionReference to add a new categories
  return notes.doc(docid).collection('note').add({
    'note': noteText,
  });
}

Future<void> editNotes({
  required String noteDocId,
  required String note,
  required String categoriesDocId,
}) {
  // Call the categories CollectionReference to edit categories
  return notes.doc(categoriesDocId).collection('note').doc(noteDocId).update(
    {
      'note': note,
    },
  );
}
