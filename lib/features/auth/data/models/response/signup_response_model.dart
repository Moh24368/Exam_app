import 'package:exam/features/auth/data/models/request/user_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signup_response_model.g.dart';

@JsonSerializable()
class SignupResponseModel {
  final String? message;
  final String token;
  final UserDataModel user;

  const SignupResponseModel({
    this.message,
    required this.token,
    required this.user,
  });

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseModelFromJson(json);
}