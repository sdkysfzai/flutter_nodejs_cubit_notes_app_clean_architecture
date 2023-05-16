import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/data/data_sources/remote_data_source/firebase_data_source/firebase_data_source.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/data/models/user_model.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/domain/entities/user/user_entity.dart';

import '../../../../utils/consts/firebase_const.dart';
import '../../../../utils/extensions/helper_methods.dart';

class FirebaseRemoteDataSourceImpl extends FirebaseRemoteDataSource {
  FirebaseRemoteDataSourceImpl({required this.auth, required this.firestore});
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<void> createUser(UserEntity user) async {
    final uid = await getCurrentUid();
    await firestore.collection(FirebaseConst.users).doc(uid).set({
      "username": user.username,
      "email": user.email,
      "uid": uid,
    }).then((value) => toast("Registeration Success!"));
  }

  @override
  Future<void> deleteUser(UserEntity user) async {
    final userCollection = firestore.collection(FirebaseConst.users);
    final uid = await getCurrentUid();
    await userCollection.doc(uid).delete();
  }

  @override
  Future<String> getCurrentUid() async => auth.currentUser!.uid;

  @override
  Future<UserEntity> getSingleUser(String uid) async {
    final userDoc = firestore.collection(FirebaseConst.users).doc(uid);
    final user = await userDoc.get();
    return UserModel.fromSnapshot(user);
  }

  @override
  Future<List<UserEntity>> getAllUsers() async {
    final List<UserEntity> allUsers = [];
    final data = await firestore.collection(FirebaseConst.users).get();
    for (var item in data.docs) {
      allUsers.add(UserModel.fromSnapshot(item));
    }
    return allUsers;
  }

  @override
  Future<bool> isSignedIn() async => auth.currentUser?.uid != null;

  @override
  Future<void> signInUser(UserEntity user) async {
    try {
      if (user.email != null && user.password != null) {
        await auth.signInWithEmailAndPassword(
            email: user.email!, password: user.password!);
      } else {
        toast("Username and Password can't be empty");
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
  Future<void> signOut() async => auth.signOut();

  @override
  Future<void> signUpUser(UserEntity user) async {
    try {
      if (user.email != null && user.password != null) {
        await auth
            .createUserWithEmailAndPassword(
                email: user.email!, password: user.password!)
            .then((value) async => {
                  if (value.user != null)
                    {
                      await createUser(user),
                    }
                });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        toast("email is already taken");
      } else if (e.code == "invalid-email") {
        toast("invalid email");
      } else if (e.code == "operation-not-allowed") {
        toast("Not allowed");
      } else if (e.code == "weak-password") {
        toast("Weak Password");
      } else {
        toast("something went wrong ${e.message}");
      }
    }
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    Map<String, dynamic> userInformation = {};

    if (user.username != '' && user.username != null) {
      userInformation['username'] = user.username;
    }

    firestore
        .collection(FirebaseConst.users)
        .doc(user.uid)
        .update(userInformation);
  }
}
