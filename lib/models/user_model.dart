class UserModel {
  final bool status;
  final List<User> userlist;
  final Cursor? cursor;
  UserModel({required this.status, required this.userlist, this.cursor});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    status: json['status'] ?? false,
    userlist: json['users'] != null ? getUserList(json['users']) : [],
    cursor: json.containsKey('nextCursor')
        ? Cursor.fromJson(json['nextCursor'])
        : null,
  );

  static List<User> getUserList(List json) {
    return json.map((e) => User.fromJson(e)).toList();
  }
}

class User {
  final String id;
  final String profilePhotoKey;
  final String profilePhotoUrl;
  final String gender;
  final String age;
  final String userName;
  final String bio;
  final bool isDeleted;

  User({
    required this.userName,
    required this.id,
    required this.profilePhotoKey,
    required this.profilePhotoUrl,
    required this.gender,
    required this.age,
    required this.bio,
    required this.isDeleted,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    userName: json['user_name'] ?? '',
    id: json['_id'],
    profilePhotoKey: json['profile_photo_key'] ?? '',
    profilePhotoUrl: json['profile_photo_url'] ?? '',
    gender: json['gender'] ?? '',
    bio: json['details'] != null ? json['details']['bio'] ?? '' : '',
    age: json['age'] ?? '',
    isDeleted: json['isDeleted'] ?? false,
  );
}

class Cursor {
  final String? createdAt;
  final String? id;
  Cursor({this.createdAt, this.id});

  factory Cursor.fromJson(Map<String, dynamic> json) =>
      Cursor(createdAt: json['createdAt'] ?? '', id: json['_id'] ?? '');
  static Map<String, dynamic> toMap(Cursor? cursor) {
    if (cursor == null) {
      return {};
    } else {
      return {'createdAt': cursor.createdAt, 'id': cursor.id};
    }
  }
}
