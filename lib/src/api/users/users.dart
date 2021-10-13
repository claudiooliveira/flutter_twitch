import 'package:dio/dio.dart';
import 'package:flutter_twitch/flutter_twitch.dart';
import 'package:flutter_twitch/src/api/api.dart';
import 'package:flutter_twitch/src/api/api_response/api_response.dart';
import 'package:flutter_twitch/src/api/auth/auth_response.dart';
import 'package:flutter_twitch/src/api/base_api.dart';
import 'package:flutter_twitch/src/api/users/user.dart';

abstract class Users {
  Future<AuthResponse> auth(String code);
  Future<ApiResponse<User>> getUsersByToken(String accessToken);
  Future<ApiResponse<User>> getUsersByCode(String code);
  Future<ApiResponse<User>> getUsersById(String id, {String? accessToken});
}

class UsersApi with BaseApi implements Users {
  @override
  Future<AuthResponse> auth(String code) async {
    var response = await TwitchApi.dio.post(
      "https://id.twitch.tv/oauth2/token"
      "?client_id=${FlutterTwitch.instance.TWITCH_CLIENT_ID}"
      "&client_secret=${FlutterTwitch.instance.TWITCH_CLIENT_SECRET}"
      "&code=$code&grant_type=authorization_code"
      "&redirect_uri=${FlutterTwitch.instance.TWITCH_REDIRECT_URI}",
    );
    var authResponse = AuthResponse.fromJson(response.data);
    FlutterTwitch.setUserAccessToken(authResponse.accessToken);
    return authResponse;
  }

  @override
  Future<ApiResponse<User>> getUsersByToken(String accessToken) async {
    BaseOptions options = getOptions(accessToken);
    var response = await Dio(options).get("${TwitchApi.baseUrl}/users");
    return ApiResponse<User>.fromJson(response.data);
  }

  @override
  Future<ApiResponse<User>> getUsersByCode(String code) async {
    String accessToken = (await auth(code)).accessToken;
    return getUsersByToken(accessToken);
  }

  @override
  Future<ApiResponse<User>> getUsersById(String id,
      {String? accessToken}) async {
    BaseOptions options = getOptions(accessToken);
    var response = await Dio(options).get("${TwitchApi.baseUrl}/users?id=$id");
    return ApiResponse<User>.fromJson(response.data);
  }
}
