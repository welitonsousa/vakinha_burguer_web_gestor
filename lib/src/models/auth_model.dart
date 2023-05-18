class AuthModel {
  final String accessToken;

  AuthModel({required this.accessToken});

  factory AuthModel.fromMap(map) {
    return AuthModel(
      accessToken: map['access_token'] ?? '',
    );
  }
}
