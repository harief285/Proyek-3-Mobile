class User {
  String? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? password;
  String? type;
  String? rememberToken;
  String? createdAt;
  String? updateAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.password,
    required this.type,
    required this.rememberToken,
    required this.createdAt,
    required this.updateAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    password: json["password"],
    type: json["type"],
    rememberToken: json["remember_token"],
    createdAt: json["created_at"],
    updateAt: json["update_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "password": password,
    "type": type,
    "remember_token": rememberToken,
    "created_at": createdAt,
    "update_at": updateAt,
  };
}