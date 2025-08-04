import 'package:jwt_decoder/jwt_decoder.dart';

bool isTokenValid(String token) {
  return !JwtDecoder.isExpired(token);
}