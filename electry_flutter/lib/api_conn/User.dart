class User {
  int id;
  String username;
  String email;
  String privileges;

  User({this.id, this.username, this.email, this.privileges});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] as int,
      username: json["username"] as String,
      email: json["email"] as String,
      privileges: json["privileges"] as String,
    );
  }
}
