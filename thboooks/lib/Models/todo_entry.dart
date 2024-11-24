class TodoEntry {
  Map<dynamic, dynamic> readers;
  String username;
  String? objectId;
  DateTime? created;
  DateTime? updated;

  TodoEntry({
    required this.readers,
    required this.username,
    this.objectId,
    this.created,
    this.updated,
  });

  Map<String, Object?> toJson() => {
        'username': username,
        'todos': readers,
        'created': created,
        'updated': updated,
        'objectId': objectId,
      };

  static TodoEntry fromJson(Map<dynamic, dynamic>? json) => TodoEntry(
        username: json!['username'] as String,
        readers: json['todos'] as Map<dynamic, dynamic>,
        objectId: json['objectId'] as String,
        created: json['created'] as DateTime,
      );
}

class Userinfo {
  Map<dynamic, dynamic> userinfo;
  String name;
  String email;
  String phone;
  String bio;
  Userinfo({
    required this.userinfo,
    required this.name,
    required this.email,
    required this.phone,
    required this.bio,
  });

  Map<String, Object?> toJson() => {
        'name': name,
        'userinfo': userinfo,
        'email': email,
        'phone': phone,
        'bio': bio,
      };
  static Userinfo fromJson(Map<dynamic, dynamic>? json) => Userinfo(
        name: json!['name'] as String,
        userinfo: json['userinfo'] as Map<dynamic, dynamic>,
        email: json['email'] as String,
        phone: json['phone'] as String,
        bio: json['bio'] as String,
      );
}
