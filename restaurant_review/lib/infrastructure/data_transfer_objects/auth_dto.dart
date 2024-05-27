import '../../domain/entities/auth.dart';

class AuthDto {
  // final String username;
  final String token;

  AuthDto({
    // required this.username,
    required this.token,
  });

  factory AuthDto.fromJson(Map<String, dynamic> json) {
    return AuthDto(
      // username: json['username'],
      token: json['access_token'],
    );
  }

  Map<String, dynamic> toJson() {
    // print("username $username");
    print("token $token");
    return {
      // 'username': username,
      'token': token,
    };
  }

  Auth toDomain() {
    // print(username);
    print(token);
    return Auth(
      // username: username,
      accessToken: token,
    );
  }
}
