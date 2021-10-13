import 'package:dio/dio.dart';
import 'package:flutter_twitch/flutter_twitch.dart';
import 'package:flutter_twitch/src/api/api_interceptor.dart';
import 'package:flutter_twitch/src/api/auth/auth_response.dart';
import 'package:flutter_twitch/src/api/users/users.dart';

class TwitchApi {
  static Dio? _dioInstance;
  static InterceptorsWrapper? _dioInterceptor;
  static TwitchApi? _instance;
  BaseOptions? _opt;
  FlutterTwitch flutterTwitch = FlutterTwitch.instance;
  AuthResponse? _authData;

  static Users users = UsersApi();
  static String baseUrl = "https://api.twitch.tv/helix";

  static TwitchApi initialize() {
    if (_instance == null) {
      _instance = TwitchApi();
      _instance!._opt = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 120 * 1000,
      );
    }

    _initDio();
    _instance!.apiAuth();

    return _instance!;
  }

  static Dio _initDio() {
    _dioInstance = (_dioInstance ?? Dio(_instance!._opt));
    if (_dioInterceptor == null) {
      _dioInterceptor = AuthInterceptors();
      _dioInstance!.interceptors.add(_dioInterceptor!);
    }
    return _dioInstance!;
  }

  static TwitchApi get instance => _instance ?? initialize();
  static Dio get dio => _dioInstance ?? _initDio();

  // API Auth

  Future<AuthResponse> apiAuth() async {
    if (_authData != null) {
      return _authData!;
    }
    var response = await Dio().post(
      "https://id.twitch.tv/oauth2/token?"
      "client_id=${flutterTwitch.TWITCH_CLIENT_ID}"
      "&client_secret=${flutterTwitch.TWITCH_CLIENT_SECRET}"
      "&grant_type=client_credentials&scope=${flutterTwitch.scope}",
    );
    _authData = AuthResponse.fromJson(response.data);
    FlutterTwitch.setAccessToken(_authData!.accessToken);
    return _authData!;
  }
}
