import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant/admin/menuPage.dart';

class FirestoreService {
  final CollectionReference<Map<String, dynamic>> menu =
  FirebaseFirestore.instance.collection('menu');

  Future<DocumentReference<Map<String, dynamic>>> addNote(
      String note, String imageUrl, double price) async {
    var data = {
      'note': note,
      'price': price,
      'imageUrl': imageUrl,
      'timestamp': Timestamp.now(),
    };

    return menu.add(data);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getNotesStream() {
    final notesStream =
    menu.orderBy('timestamp', descending: true).snapshots();
    return notesStream;
  }

  Future<void> updateNote(String docID, String newNote, double newPrice) {
    return menu.doc(docID).update({
      'note': newNote,
      'price': newPrice,
      'timestamp': Timestamp.now(),
    });
  }

  Future<void> deleteNote(String docID) {
    return menu.doc(docID).delete();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();
  Uint8List? _imageBytes;

  @override
  void dispose() {
    _textController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _openNoteBox({String? docID, required String existingNote}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _textController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter Food Name...',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            TextField(
              controller: _priceController,
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter the price...',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                final pickedFile = await ImagePicker()
                    .pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  final bytes = await pickedFile.readAsBytes();
                  setState(() {
                    _imageBytes = bytes;
                  });
                }
              },
              icon: Icon(Icons.camera),
              label: Text('Add Image'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              String imageUrl = '';
              if (_imageBytes != null) {
                imageUrl = await _uploadImage(_imageBytes!);
              }
              double price = double.tryParse(_priceController.text) ?? 0.0;
              if (docID == null) {
                await _firestoreService.addNote(
                    _textController.text, imageUrl, price);
              } else {
                await _firestoreService.updateNote(
                    docID, _textController.text, price);
              }
              setState(() {
                _imageBytes = null; // Reset image after adding or updating note
              });
              _textController.clear();
              _priceController.clear();
              Navigator.pop(context); // Close dialog
            },
            child: const Text("Add"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Future<String> _uploadImage(Uint8List bytes) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now()}.jpg');
    UploadTask uploadTask = storageReference.putData(bytes);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(''),
          backgroundColor: Colors.black,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _openNoteBox(existingNote: ''),
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        SizedBox(height: 20),
                Center(
                child: Text(
                'Food Data',
                style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                ),
                ),
                ),
                SizedBox(height: 20),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: _firestoreService.getNotesStream(),
                builder: (context, snapshot) {
                if (snapshot.hasData) {
                List<QueryDocumentSnapshot<Map<String, dynamic>>>
                notesList = snapshot.data!.docs;
                return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: notesList.length,
                itemBuilder: (context, index) {
                DocumentSnapshot<Map<String, dynamic>> document =
                notesList[index];
                String docID = document.id;

                Map<String, dynamic> data =
                document.data() as Map<String, dynamic>;

                String imageUrl = data['imageUrl'] ?? '';
                String noteText = data['note'];
                double price = (data['price'] ?? 0).toDouble();


                return Card(
                color: Colors.grey[900],
                margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
                ),
                child: ListTile(
                title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                if (imageUrl.isNotEmpty)
                Image.network(
                imageUrl,
                width: 200, // Adjust width as needed
                height: 200, // Adjust height as needed
                fit: BoxFit.cover,
                ),
                  Text(
                    noteText,
                    style: TextStyle(color: Colors.white),
                  ),
                Text(
                'Price: \$${price.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.white),
                ),
                ],
                ),
                trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                IconButton(
                onPressed: () => _openNoteBox(
                docID: docID,
                existingNote: noteText,
                ),
                icon: const Icon(Icons.edit,
                color: Colors.blue),
                ),
                IconButton(
                onPressed: () =>
                _firestoreService.deleteNote(docID),
                icon: const Icon(Icons.delete,
                color: Colors.red),
                ),
                ],
                ),
                ),
                );
                },
                );
                } else {
                return const Center(child: CircularProgressIndicator());
                }
                },
                ),

                    ],
                    ),
                    ),
                );
              }
            }

            void main() {
              runApp(MaterialApp(
                debugShowCheckedModeBanner: false,
                home: HomePage(),
              ));
            }

