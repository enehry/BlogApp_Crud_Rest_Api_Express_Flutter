class User {
  final String? username;
  final String? id;
  final String? password;

  User({this.username, this.id, this.password});

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
      id: parsedJson['id'].toString(),
      username: parsedJson['name'].toString(),
      password: parsedJson['password'].toString(),
    );
  }
}
