const String usersTable = 'users';

class UserFields {
  static final List<String> values = [
    "firstname",
    "lastname",
    "birthday",
    "address",
    "phone",
    "email",
    "gender",
    "picture",
    "citation",
  ];
}

class User {
  final int? id;
  final String firstname;
  final String lastname;
  final String birthday;
  final String address;
  final String phone;
  final String email;
  final String gender;
  final String picture;
  final String citation;

  User({
    this.id,
    required this.firstname,
    required this.lastname,
    required this.birthday,
    required this.address,
    required this.phone,
    required this.email,
    required this.gender,
    required this.picture,
    required this.citation,
  });

  Map<String, Object?> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "birthday": birthday,
        "address": address,
        "phone": phone,
        "email": email,
        "gender": gender,
        "picture": picture,
        "citation": citation,
      };

  static User fromJson(Map<String, Object?> json) => User(
        id: json["id"] as int,
        firstname: json["firstname"] as String,
        lastname: json["lastname"] as String,
        birthday: json["birthday"] as String,
        address: json["address"] as String,
        phone: json["phone"] as String,
        email: json["email"] as String,
        gender: json["gender"] as String,
        picture: json["picture"] as String,
        citation: json["citation"] as String,
      );
}
