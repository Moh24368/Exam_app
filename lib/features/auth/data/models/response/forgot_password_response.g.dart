// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPasswordResponse _$ForgotPasswordResponseFromJson(
  Map<String, dynamic> json,
) => ForgotPasswordResponse(
  message: json['message'] as String?,
  info: json['info'] as String?,
);

VerifyResetCodeResponse _$VerifyResetCodeResponseFromJson(
  Map<String, dynamic> json,
) => VerifyResetCodeResponse(status: json['status'] as String?);

ResetPasswordResponse _$ResetPasswordResponseFromJson(
  Map<String, dynamic> json,
) => ResetPasswordResponse(
  message: json['message'] as String?,
  token: json['token'] as String?,
);
