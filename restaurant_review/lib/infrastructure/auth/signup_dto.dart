class SignUpDTO {
  final String username;
  final String email;
  final String password;
  final String role;

  SignUpDTO(
      {required this.username,
      required this.email,
      required this.password,
      required this.role});

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'password': password,
        'role': role,
      };
}
