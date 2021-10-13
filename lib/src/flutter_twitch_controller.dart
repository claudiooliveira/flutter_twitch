import 'package:flutter_twitch/src/api/api.dart';
import 'package:flutter_twitch/src/api/users/users.dart';

class FlutterTwitch {
  static FlutterTwitch? _instance;
  // ignore: non_constant_identifier_names
  String TWITCH_CLIENT_ID = "";
  // ignore: non_constant_identifier_names
  String TWITCH_CLIENT_SECRET = "";
  // ignore: non_constant_identifier_names
  String TWITCH_REDIRECT_URI = "";

  static String _accessToken = "";
  static String _userAccessToken = "";

  String scope = "user:read:email";

  static initialize({
    required String twitchClientId,
    required String twitchClientSecret,
    required String twitchRedirectUri,
    String? scope,
  }) {
    _instance = _instance == null ? FlutterTwitch() : _instance!;
    _instance?.TWITCH_CLIENT_ID = twitchClientId;
    _instance?.TWITCH_CLIENT_SECRET = twitchClientSecret;
    _instance?.TWITCH_REDIRECT_URI = twitchRedirectUri;
    if (scope != null) {
      _instance?.scope = scope;
    }
    TwitchApi.initialize();
  }

  static FlutterTwitch get instance => _instance!;

  static setAccessToken(String accessToken) => _accessToken = accessToken;
  static setUserAccessToken(String accessToken) =>
      _userAccessToken = accessToken;

  static String? get getAccessToken => _accessToken;
  static String? get getUserAccessToken => _userAccessToken;

  static Users get users => TwitchApi.users;
}
