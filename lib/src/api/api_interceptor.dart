import 'package:dio/dio.dart';
import 'package:flutter_twitch/src/api/api.dart';
import 'package:flutter_twitch/src/api/auth/auth_response.dart';
import 'package:flutter_twitch/src/flutter_twitch_controller.dart';

class AuthInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(options, handler) async {
    options.headers = await getHeaders();
    return super.onRequest(options, handler);
  }

  Future<Map<String, String>> getHeaders() async {
    AuthResponse authResponse = await TwitchApi.instance.apiAuth();
    return {
      'Authorization': 'Bearer ${authResponse.accessToken}',
      'Client-Id': FlutterTwitch.instance.TWITCH_CLIENT_ID
    };
  }
}
