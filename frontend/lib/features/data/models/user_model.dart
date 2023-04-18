import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/user/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.email,
    super.username,
    super.uid,
    super.password,
  });

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;

    return UserModel(
      email: data['email'],
      username: data['username'],
      uid: snapshot.id,
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "username": username,
      };
}
