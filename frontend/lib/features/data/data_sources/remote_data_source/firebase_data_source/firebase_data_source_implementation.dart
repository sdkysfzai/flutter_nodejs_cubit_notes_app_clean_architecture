import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/data/data_sources/remote_data_source/firebase_data_source/firebase_data_source.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/data/models/user_model.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/entities/user/user_entity.dart';

import '../../../../../consts.dart';

class FirebaseRemoteDataSourceImpl extends FirebaseRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  Future<void> createUser(UserEntity user) async {
    final userCollection = _firestore.collection(FirebaseConst.users);
    final uid = await getCurrentUid();
    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
        email: user.email,
        uid: uid,
        username: user.username,
      ).toJson();

      if (!userDoc.exists) {
        userCollection.doc(uid).set(newUser);
      } else {
        userCollection.doc(uid).update(newUser);
      }
    }).catchError((error) {
      toast("Something went wrong!");
    });
  }

  @override
  Future<void> deleteUser(UserEntity user) async {
    final userCollection = _firestore.collection(FirebaseConst.users);
    final uid = await getCurrentUid();
    await userCollection.doc(uid).delete();
  }

  @override
  Future<String> getCurrentUid() async => _auth.currentUser!.uid;

  @override
  Future<UserEntity> getSingleUser(String uid) async {
    final userDoc = _firestore.collection(FirebaseConst.users).doc(uid);
    final user = await userDoc.get();
    return UserModel.fromSnapshot(user);
  }

  @override
  Future<bool> isSinedIn() async => _auth.currentUser?.uid != null;

  @override
  Future<void> signInUser(UserEntity user) async {
    try {
      if (user.email != null && user.password != null) {
        await _auth.signInWithEmailAndPassword(
            email: user.email!, password: user.password!);
      } else {
        print("Fields can't be empty");
      }
    } on FirebaseAuthException catch (e) {
      //TODO toast shouldn't be shown from Data Layer
      if (e.code == 'user-not-found') {
        toast('User not found');
      } else if (e.code == 'wrong-password') {
        toast('Incorrect password');
      }
    }
  }

  @override
  Future<void> signOut() async => _auth.signOut();

  @override
  Future<void> signUpUser(UserEntity user) async {
    try {
      if (user.email != null && user.password != null) {
        await _auth.createUserWithEmailAndPassword(
            email: user.email!, password: user.password!);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        toast("email is already taken");
      } else {
        toast("something went wrong");
      }
    }
  }

  @override
  Future<void> updateUser(UserEntity user) {
    //TODO: use copywith method to update user
    throw UnimplementedError();
  }
}
