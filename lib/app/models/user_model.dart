// String get fullName => '$first_name $last_name';
// double get rating => point / rate;

import 'dart:convert';

///****************************************
///region Model UserModelFields
class UserModelFields {
  static const String id = 'id';
  static const String first_name = 'first_name';
  static const String last_name = 'last_name';
  static const String email = 'email';
  static const String password = 'password';
  static const String phone = 'phone';
  static const String location = 'location';
  static const String tags = 'tags';
  static const String description = 'description';
  static const String avatar = 'avatar';
  static const String language = 'language';
  static const String theme = 'theme';
  static const String status = 'status';
  static const String role = 'role';
  static const String token = 'token';
  static const String fcm_token = 'fcm_token';
  static const String image = 'image';
  static const String gender = 'gender';
  static const String rate = 'rate';
  static const String point = 'point';

  static const List<String> list = [
    id,
    first_name,
    last_name,
    email,
    password,
    phone,
    location,
    tags,
    description,
    avatar,
    language,
    theme,
    status,
    role,
    token,
    fcm_token,
    image,
    gender,
    rate,
    point
  ];
}

///endregion Model UserModelFields

///****************************************
///region Model UserModel
class UserModel {
  ///region Fields
  String? id;
  String? first_name;
  String? last_name;
  String? email;
  String? password;
  String? phone;
  String? location;
  String? tags;
  String? description;
  String? avatar;
  String? language;
  String? theme;
  String? status;
  String? role;
  String? token;
  String? fcm_token;
  String? image;
  bool? gender;
  int rate = 1;
  double point = 5.0;

  ///endregion Fields

  ///region FieldsList
  List<String> fieldsList = UserModelFields.list;

  List<dynamic> get toArgs => [id, first_name, last_name, email, password, phone, location, tags, description, avatar, language, theme, status, role, token, fcm_token, image, gender, rate, point];

  ///endregion FieldsList

  String get fullName => '$first_name $last_name';

  double get rating => point / rate;

  ///region newInstance
  UserModel get newInstance => UserModel();

  ///endregion newInstance

  ///region default constructor
  UserModel(
      {this.id,
      this.first_name,
      this.last_name,
      this.email,
      this.password,
      this.phone,
      this.location,
      this.tags,
      this.description,
      this.avatar,
      this.language,
      this.theme,
      this.status,
      this.role,
      this.token,
      this.fcm_token,
      this.image,
      this.gender,
      this.rate = 1,
      this.point = 5.0});

  ///endregion default constructor

  ///region withFields constructor
  UserModel.withFields(this.id, this.first_name, this.last_name, this.email, this.password, this.phone, this.location, this.tags, this.description, this.avatar, this.language, this.theme, this.status,
      this.role, this.token, this.fcm_token, this.image, this.gender, this.rate, this.point);

  ///endregion withFields constructor

  ///region fromMap
  UserModel.fromMap(Map<String, dynamic> map) {
    updateFromMap(map);
  }

  ///endregion fromMap

  ///region fromMapList
  static List<UserModel> fromMapList(List<dynamic> list) {
    return list.map((e) => UserModel.fromMap(e as Map<String, dynamic>)).toList();
  }

  ///endregion fromMapList

  ///region fromJson
  UserModel.fromJson(String jsonInput) : this.fromMap(json.decode(jsonInput));

  ///endregion fromJson

  ///region toMap
  Map<String, dynamic> toMap([bool isDateIso8601String = false]) {
    return {
      if (id != null) UserModelFields.id: id,
      if (first_name != null) UserModelFields.first_name: first_name,
      if (last_name != null) UserModelFields.last_name: last_name,
      if (email != null) UserModelFields.email: email,
      if (password != null) UserModelFields.password: password,
      if (phone != null) UserModelFields.phone: phone,
      if (location != null) UserModelFields.location: location,
      if (tags != null) UserModelFields.tags: tags,
      if (description != null) UserModelFields.description: description,
      if (avatar != null) UserModelFields.avatar: avatar,
      if (language != null) UserModelFields.language: language,
      if (theme != null) UserModelFields.theme: theme,
      if (status != null) UserModelFields.status: status,
      if (role != null) UserModelFields.role: role,
      if (token != null) UserModelFields.token: token,
      if (fcm_token != null) UserModelFields.fcm_token: fcm_token,
      if (image != null) UserModelFields.image: image,
      if (gender != null) UserModelFields.gender: gender,
      UserModelFields.rate: rate,
      UserModelFields.point: point,
    };
//return map;
  }

  ///endregion toMap

  ///region toJson
  String toJson() => json.encode(toMap());

  ///endregion toJson

  ///region toString
  @override
  String toString() => toMap().toString();

  ///endregion toString

  ///region copyWith
  UserModel copyWith(
      {String? id,
      String? first_name,
      String? last_name,
      String? email,
      String? password,
      String? phone,
      String? location,
      String? tags,
      String? description,
      String? avatar,
      String? language,
      String? theme,
      String? status,
      String? role,
      String? token,
      String? fcm_token,
      String? image,
      bool? gender,
      int? rate,
      double? point}) {
    return UserModel()
      ..id = id ?? this.id
      ..first_name = first_name ?? this.first_name
      ..last_name = last_name ?? this.last_name
      ..email = email ?? this.email
      ..password = password ?? this.password
      ..phone = phone ?? this.phone
      ..location = location ?? this.location
      ..tags = tags ?? this.tags
      ..description = description ?? this.description
      ..avatar = avatar ?? this.avatar
      ..language = language ?? this.language
      ..theme = theme ?? this.theme
      ..status = status ?? this.status
      ..role = role ?? this.role
      ..token = token ?? this.token
      ..fcm_token = fcm_token ?? this.fcm_token
      ..image = image ?? this.image
      ..gender = gender ?? this.gender
      ..rate = rate ?? this.rate
      ..point = point ?? this.point;
  }

  ///endregion copyWith

  ///region updateWith
  void updateWith(
      {String? id,
      String? first_name,
      String? last_name,
      String? email,
      String? password,
      String? phone,
      String? location,
      String? tags,
      String? description,
      String? avatar,
      String? language,
      String? theme,
      String? status,
      String? role,
      String? token,
      String? fcm_token,
      String? image,
      bool? gender,
      int? rate,
      double? point}) {
    if (id != null) {
      this.id = id;
    }
    if (first_name != null) {
      this.first_name = first_name;
    }
    if (last_name != null) {
      this.last_name = last_name;
    }
    if (email != null) {
      this.email = email;
    }
    if (password != null) {
      this.password = password;
    }
    if (phone != null) {
      this.phone = phone;
    }
    if (location != null) {
      this.location = location;
    }
    if (tags != null) {
      this.tags = tags;
    }
    if (description != null) {
      this.description = description;
    }
    if (avatar != null) {
      this.avatar = avatar;
    }
    if (language != null) {
      this.language = language;
    }
    if (theme != null) {
      this.theme = theme;
    }
    if (status != null) {
      this.status = status;
    }
    if (role != null) {
      this.role = role;
    }
    if (token != null) {
      this.token = token;
    }
    if (fcm_token != null) {
      this.fcm_token = fcm_token;
    }
    if (image != null) {
      this.image = image;
    }
    if (gender != null) {
      this.gender = gender;
    }
    if (rate != null) {
      this.rate = rate;
    }
    if (point != null) {
      this.point = point;
    }
  }

  ///endregion updateWith

  ///region updateFrom
  void updateFrom({required UserModel another}) {
    if (another.id != null) {
      id = another.id;
    }
    if (another.first_name != null) {
      first_name = another.first_name;
    }
    if (another.last_name != null) {
      last_name = another.last_name;
    }
    if (another.email != null) {
      email = another.email;
    }
    if (another.password != null) {
      password = another.password;
    }
    if (another.phone != null) {
      phone = another.phone;
    }
    if (another.location != null) {
      location = another.location;
    }
    if (another.tags != null) {
      tags = another.tags;
    }
    if (another.description != null) {
      description = another.description;
    }
    if (another.avatar != null) {
      avatar = another.avatar;
    }
    if (another.language != null) {
      language = another.language;
    }
    if (another.theme != null) {
      theme = another.theme;
    }
    if (another.status != null) {
      status = another.status;
    }
    if (another.role != null) {
      role = another.role;
    }
    if (another.token != null) {
      token = another.token;
    }
    if (another.fcm_token != null) {
      fcm_token = another.fcm_token;
    }
    if (another.image != null) {
      image = another.image;
    }
    if (another.gender != null) {
      gender = another.gender;
    }
    rate = another.rate;
    point = another.point;
  }

  ///endregion updateFrom

  ///region updateFromMap
  void updateFromMap(Map<String, dynamic> map) {
    if (map[UserModelFields.id] != null) {
      id = map[UserModelFields.id].toString();
    }
    if (map[UserModelFields.first_name] != null) {
      first_name = map[UserModelFields.first_name].toString();
    }
    if (map[UserModelFields.last_name] != null) {
      last_name = map[UserModelFields.last_name].toString();
    }
    if (map[UserModelFields.email] != null) {
      email = map[UserModelFields.email].toString();
    }
    if (map[UserModelFields.password] != null) {
      password = map[UserModelFields.password].toString();
    }
    if (map[UserModelFields.phone] != null) {
      phone = map[UserModelFields.phone].toString();
    }
    if (map[UserModelFields.location] != null) {
      location = map[UserModelFields.location].toString();
    }
    if (map[UserModelFields.tags] != null) {
      tags = map[UserModelFields.tags].toString();
    }
    if (map[UserModelFields.description] != null) {
      description = map[UserModelFields.description].toString();
    }
    if (map[UserModelFields.avatar] != null) {
      avatar = map[UserModelFields.avatar].toString();
    }
    if (map[UserModelFields.language] != null) {
      language = map[UserModelFields.language].toString();
    }
    if (map[UserModelFields.theme] != null) {
      theme = map[UserModelFields.theme].toString();
    }
    if (map[UserModelFields.status] != null) {
      status = map[UserModelFields.status].toString();
    }
    if (map[UserModelFields.role] != null) {
      role = map[UserModelFields.role].toString();
    }
    if (map[UserModelFields.token] != null) {
      token = map[UserModelFields.token].toString();
    }
    if (map[UserModelFields.fcm_token] != null) {
      fcm_token = map[UserModelFields.fcm_token].toString();
    }
    if (map[UserModelFields.image] != null) {
      image = map[UserModelFields.image].toString();
    }
    if (map[UserModelFields.gender] != null) {
      gender = ['1', 'true'].contains(map[UserModelFields.gender].toString().toLowerCase());
    }
    rate = int.tryParse(map[UserModelFields.rate].toString()) ?? 1;
    point = double.tryParse(map[UserModelFields.point].toString()) ?? 5.0;
  }

  ///endregion updateFromMap

  ///region Equality
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel &&
        id == other.id &&
        first_name == other.first_name &&
        last_name == other.last_name &&
        email == other.email &&
        password == other.password &&
        phone == other.phone &&
        location == other.location &&
        tags == other.tags &&
        description == other.description &&
        avatar == other.avatar &&
        language == other.language &&
        theme == other.theme &&
        status == other.status &&
        role == other.role &&
        token == other.token &&
        fcm_token == other.fcm_token &&
        image == other.image &&
        gender == other.gender &&
        rate == other.rate &&
        point == other.point;
  }

  bool isTheSameObjectID(UserModel other) => id != null && other.id != null && id == other.id;
  @override
  int get hashCode =>
      id.hashCode ^
      first_name.hashCode ^
      last_name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      phone.hashCode ^
      location.hashCode ^
      tags.hashCode ^
      description.hashCode ^
      avatar.hashCode ^
      language.hashCode ^
      theme.hashCode ^
      status.hashCode ^
      role.hashCode ^
      token.hashCode ^
      fcm_token.hashCode ^
      image.hashCode ^
      gender.hashCode ^
      rate.hashCode ^
      point.hashCode;

  ///endregion Equality
}

///endregion Model UserModel
