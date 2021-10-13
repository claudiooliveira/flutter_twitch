import 'package:dio/dio.dart';
import 'package:flutter_twitch/flutter_twitch.dart';
import 'package:flutter_twitch/src/flutter_twitch_controller.dart';

class BaseApi {
  BaseOptions getOptions(String? accessToken) {
    accessToken ??= FlutterTwitch.getAccessToken;
    return BaseOptions(headers: {
      'Authorization': 'Bearer $accessToken',
      'Client-Id': FlutterTwitch.instance.TWITCH_CLIENT_ID
    });
  }
}
