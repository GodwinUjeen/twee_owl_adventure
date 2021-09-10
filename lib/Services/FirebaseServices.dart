import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twee_owl_adventure/game/audio_manager.dart';

class FirebaseServices extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  String? _link;

  String? get link => _link;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;
    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // print(_user);
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User? authUser = userCredential.user;

    var collectionRef = firebaseFirestore.collection('users');

    var doc = await collectionRef.doc(authUser!.uid).get();
    // print('Exists: ${doc.exists}');

    if (doc.exists) {
      // print("Score");
      // print(doc.data()!['score']);
      AudioManager.instance.setHighScore(doc.data()!['score']);
    } else {
      await firebaseFirestore
          .collection('users')
          .doc(authUser.uid)
          .set({"name": authUser.displayName, "score": 0});
    }

    return authUser;
  }

  Future logOut() async {
    await googleSignIn.signOut();
    await _auth.signOut();
  }

  Future<String?> getLink() async {
    var data = await firebaseFirestore.collection('share').doc('share').get();
    _link = data.data()!['link'];

    return link;
  }

  Stream<QuerySnapshot> getScores() {
    CollectionReference notesItemCollection =
        FirebaseFirestore.instance.collection('users');

    return notesItemCollection.orderBy('score', descending: true).snapshots();
  }
}
