import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FirestoreService {
  final CollectionReference<Map<String, dynamic>> menu =
  FirebaseFirestore.instance.collection('menu');

  Future<DocumentReference<Map<String, dynamic>>> addNote(
      String note, double price, {File? image}) async {
    var data = {
      'note': note,
      'price': price,
      'timestamp': Timestamp.now(),
    };
    return menu.add(data);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getNotesStream() {
    final notesStream =
    menu.orderBy('timestamp', descending: true).snapshots();
    return notesStream;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFilteredNotesStream(String query) {
    Query<Map<String, dynamic>> filteredQuery = menu.where('note', isEqualTo: query);
    return filteredQuery.snapshots();
  }

  Future<void> updateNote(
      String docID, String newNote, double newPrice) async {
    return menu.doc(docID).update({
      'note': newNote,
      'price': newPrice,
      'timestamp': Timestamp.now(),
    });
  }

  Future<void> deleteNote(String docID) async {
    return menu.doc(docID).delete();
  }

  Future<String> _uploadImage(Uint8List bytes) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now()}.jpg');
    UploadTask uploadTask = storageReference.putData(bytes);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  Future<String> uploadImage(File file) async {
    Uint8List bytes = await file.readAsBytes();
    return await _uploadImage(bytes);
  }
}
