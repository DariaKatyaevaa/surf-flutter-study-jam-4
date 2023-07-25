import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:surf_practice_magic_ball/models/magic_ball_response.dart';

class MagicBallApiClient {
  final _baseURL = Uri.https('eightballapi.com', '/api');

  MagicBallApiClient();

  Future<MagicBallResponse?> askQuestion() async {
    try {
      final response = await http.get(_baseURL);
      // if (response.statusCode == 200) {
      //   var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      //   return MagicBallResponse.fromJson(jsonResponse);
      // }
      return null;
    } on Error catch (error) {
      if (kDebugMode) {
        print(error);
      }
      return null;
    }
  }
}
