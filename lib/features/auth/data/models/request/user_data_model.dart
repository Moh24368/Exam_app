import 'package:exam/features/auth/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_data_model.g.dart';

@JsonSerializable()
class UserDataModel {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String role;
  final bool isVerified;

  @JsonKey(name: '_id')
  final String id;

  final DateTime createdAt;

  UserDataModel({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.role,
    required this.isVerified,
    required this.id,
    required this.createdAt,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataModelToJson(this);
}

extension UserDataModelMapper on UserDataModel {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      username: username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      role: role,
      isVerified: isVerified,
      createdAt: createdAt,
    );
  }
}