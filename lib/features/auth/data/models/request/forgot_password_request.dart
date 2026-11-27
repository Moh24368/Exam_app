
import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_request.g.dart';

@JsonSerializable(createFactory: false)
class ForgotPasswordRequest {
  final String email;
  const ForgotPasswordRequest({required this.email});

  Map<String, dynamic> toJson() => _$ForgotPasswordRequestToJson(this);
}

@JsonSerializable(createFactory: false)
class VerifyResetCodeRequest {
  final String resetCode;
  const VerifyResetCodeRequest({required this.resetCode});

  Map<String, dynamic> toJson() => _$VerifyResetCodeRequestToJson(this);
}

@JsonSerializable(createFactory: false)
class ResetPasswordRequest {
  final String email;
  final String newPassword;
  const ResetPasswordRequest({required this.email, required this.newPassword});

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);
}