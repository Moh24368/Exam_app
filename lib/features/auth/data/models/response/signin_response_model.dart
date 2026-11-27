import 'package:exam/features/auth/data/models/request/user_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signin_response_model.g.dart';

@JsonSerializable()
class SigninResponseModel {
  final String message;
  final String token;
  final UserDataModel user;

  SigninResponseModel({
    required this.message,
    required this.token,
    required this.user,
  });

  factory SigninResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SigninResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SigninResponseModelToJson(this);
}