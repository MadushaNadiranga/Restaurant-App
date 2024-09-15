import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future<void> addUser(String username, String email, String password) async {
    try {
      // Hashing the password before saving it (You need to import the package for hashing)
      String hashedPassword = hashPassword(password);

      // Getting a reference to the 'users' node and pushing the user data
      await _database.reference().child('users').push().set({
        'username': username,
        'email': email,
        'password': hashedPassword,
      });
    } catch (e) {
      print('Error adding user: $e');
      throw 'Failed to add user: $e';
    }
  }

  // Function for hashing password (replace this with your actual hashing implementation)
  String hashPassword(String password) {
    // Your password hashing logic here
    return password;
  }
}
