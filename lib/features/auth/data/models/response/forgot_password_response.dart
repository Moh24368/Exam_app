import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_response.g.dart';

@JsonSerializable(createToJson: false)
class ForgotPasswordResponse {
  final String? message;
  final String? info;
  const ForgotPasswordResponse({this.message, this.info});

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class VerifyResetCodeResponse {
  final String? status;
  const VerifyResetCodeResponse({this.status});

  factory VerifyResetCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyResetCodeResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class ResetPasswordResponse {
  final String? message;
  final String? token;
  const ResetPasswordResponse({this.message, this.token});

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseFromJson(json);
}