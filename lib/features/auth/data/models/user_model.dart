import 'package:blog_demo/core/common/entities/user.dart';

// Follows liskov substitution principle
// USerModel can be replaced by User :
//subclasses can replace their superclasses without altering the program's behavior or introducing errors
class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.name,
  });

  // it same as we did above is a shorter method to update the fields
  // UserModel({
  //   required String id,
  //   required String email,
  //   required String name,
  // }) : super(id: id, email: email, name: name);

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
    );
  }
  UserModel copyWith({
    String? id,
    String? email,
    String? name,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }
}
