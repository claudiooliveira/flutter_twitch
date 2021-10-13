import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AuthResponse {
  AuthResponse({
    required this.accessToken,
    required this.expiresIn,
    this.refreshToken,
    this.tokenType,
  });

  String accessToken;
  int expiresIn;
  String? refreshToken;
  String? tokenType;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
