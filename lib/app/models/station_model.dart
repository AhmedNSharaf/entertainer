import 'dart:convert';

///****************************************
///region Model StationModelFields
class StationModelFields {
  static const String id = 'id';
  static const String name = 'name';
  static const String latLong = 'latLong';
  static const String description = 'description';
  static const String address = 'address';

  static const List<String> list = [id, name, latLong, description, address];
}

///endregion Model StationModelFields

///****************************************
///region Model StationModel
class StationModel {
  ///region Fields
  int? id;
  String? name;
  LatLongModel? latLong;
  String? description;
  String? address;
  String? filterCategory;

  ///endregion Fields

  ///region FieldsList
  List<String> fieldsList = StationModelFields.list;
  List<dynamic> get toArgs => [id, name, latLong, description, address];

  ///endregion FieldsList

  ///region newInstance
  StationModel get newInstance => StationModel();

  ///endregion newInstance

  ///region default constructor
  StationModel({
    this.id,
    this.name,
    this.latLong,
    this.description,
    this.address,
    this.filterCategory,
  });

  ///endregion default constructor

  ///region withFields constructor
  StationModel.withFields(
    this.id,
    this.name,
    this.latLong,
    this.description,
    this.address, [
    this.filterCategory,
  ]);

  ///endregion withFields constructor

  ///region fromMap
  StationModel.fromMap(Map<String, dynamic> map) {
    updateFromMap(map);
  }

  ///endregion fromMap

  ///region fromMapList
  static List<StationModel> fromMapList(List<dynamic> list) {
    return list
        .map((e) => StationModel.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  ///endregion fromMapList

  ///region fromJson
  StationModel.fromJson(String jsonInput)
    : this.fromMap(json.decode(jsonInput));

  ///endregion fromJson

  ///region toMap
  Map<String, dynamic> toMap([bool isDateIso8601String = false]) {
    return {
      if (id != null) StationModelFields.id: id,
      if (name != null) StationModelFields.name: name,
      if (latLong != null)
        StationModelFields.latLong: latLong!.toMap(isDateIso8601String),
      if (description != null) StationModelFields.description: description,
      if (address != null) StationModelFields.address: address,
      if (filterCategory != null) 'filterCategory': filterCategory,
    };
    //return map;
  }

  ///endregion toMap

  ///region toJson
  String toJson([bool isDateIso8601String = false]) =>
      json.encode(toMap(isDateIso8601String));

  ///endregion toJson

  ///region toString
  @override
  String toString() => toMap(true).toString();

  ///endregion toString

  ///region copyWith
  StationModel copyWith({
    int? id,
    String? name,
    LatLongModel? latLong,
    String? description,
    String? address,
    String? filterCategory,
  }) {
    return StationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      latLong: latLong ?? this.latLong,
      description: description ?? this.description,
      address: address ?? this.address,
      filterCategory: filterCategory ?? this.filterCategory,
    );
  }

  ///endregion copyWith

  ///region updateWith
  void updateWith({
    int? id,
    String? name,
    LatLongModel? latLong,
    String? description,
    String? address,
    String? filterCategory,
  }) {
    if (id != null) {
      this.id = id;
    }
    if (name != null) {
      this.name = name;
    }
    if (latLong != null) {
      this.latLong = latLong;
    }
    if (description != null) {
      this.description = description;
    }
    if (address != null) {
      this.address = address;
    }
    if (filterCategory != null) {
      this.filterCategory = filterCategory;
    }
  }

  ///endregion updateWith

  ///region updateFrom
  void updateFrom(StationModel stationModel) {
    if (stationModel.id != null) {
      id = stationModel.id;
    }
    if (stationModel.name != null) {
      name = stationModel.name;
    }
    if (stationModel.latLong != null) {
      latLong = stationModel.latLong;
    }
    if (stationModel.description != null) {
      description = stationModel.description;
    }
    if (stationModel.address != null) {
      address = stationModel.address;
    }
  }

  ///endregion updateFrom

  ///region updateFromMap
  void updateFromMap(Map<String, dynamic> map) {
    id = map[StationModelFields.id];
    name = map[StationModelFields.name];
    latLong =
        map[StationModelFields.latLong] != null
            ? LatLongModel.fromMap(map[StationModelFields.latLong])
            : null;
    description = map[StationModelFields.description];
    address = map[StationModelFields.address];
    filterCategory = map['filterCategory'];
  }

  ///endregion updateFromMap

  ///region Equality
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StationModel &&
        id == other.id &&
        name == other.name &&
        latLong == other.latLong &&
        description == other.description &&
        address == other.address;
  }

  bool isTheSameObjectID(StationModel other) =>
      id != null && other.id != null && id == other.id;
  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      latLong.hashCode ^
      description.hashCode ^
      address.hashCode;

  ///endregion Equality
}

///endregion Model StationModel

///****************************************
///region Model LatLongModelFields
class LatLongModelFields {
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';

  static const List<String> list = [latitude, longitude];
}

///endregion Model LatLongModelFields

///****************************************
///region Model LatLongModel
class LatLongModel {
  ///region Fields
  double? latitude;
  double? longitude;

  ///endregion Fields

  ///region FieldsList
  List<String> fieldsList = LatLongModelFields.list;
  List<dynamic> get toArgs => [latitude, longitude];

  ///endregion FieldsList

  ///region newInstance
  LatLongModel get newInstance => LatLongModel();

  ///endregion newInstance

  ///region default constructor
  LatLongModel({this.latitude, this.longitude});

  ///endregion default constructor

  ///region withFields constructor
  LatLongModel.withFields(this.latitude, this.longitude);

  ///endregion withFields constructor

  ///region fromMap
  LatLongModel.fromMap(Map<String, dynamic> map) {
    updateFromMap(map);
  }

  ///endregion fromMap

  ///region fromMapList
  static List<LatLongModel> fromMapList(List<dynamic> list) {
    return list
        .map((e) => LatLongModel.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  ///endregion fromMapList

  ///region fromJson
  LatLongModel.fromJson(String jsonInput)
    : this.fromMap(json.decode(jsonInput));

  ///endregion fromJson

  ///region toMap
  Map<String, dynamic> toMap([bool isDateIso8601String = false]) {
    return {
      if (latitude != null) LatLongModelFields.latitude: latitude,
      if (longitude != null) LatLongModelFields.longitude: longitude,
    };
    //return map;
  }

  ///endregion toMap

  ///region toJson
  String toJson([bool isDateIso8601String = false]) =>
      json.encode(toMap(isDateIso8601String));

  ///endregion toJson

  ///region toString
  @override
  String toString() => toMap(true).toString();

  ///endregion toString

  ///region copyWith
  LatLongModel copyWith({double? latitude, double? longitude}) {
    return LatLongModel(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  ///endregion copyWith

  ///region updateWith
  void updateWith({double? latitude, double? longitude}) {
    if (latitude != null) {
      this.latitude = latitude;
    }
    if (longitude != null) {
      this.longitude = longitude;
    }
  }

  ///endregion updateWith

  ///region updateFrom
  void updateFrom(LatLongModel latLongModel) {
    if (latLongModel.latitude != null) {
      latitude = latLongModel.latitude;
    }
    if (latLongModel.longitude != null) {
      longitude = latLongModel.longitude;
    }
  }

  ///endregion updateFrom

  ///region updateFromMap
  void updateFromMap(Map<String, dynamic> map) {
    if (map[LatLongModelFields.latitude] != null) {
      latitude = double.tryParse(map[LatLongModelFields.latitude].toString());
    }
    if (map[LatLongModelFields.longitude] != null) {
      longitude = double.tryParse(map[LatLongModelFields.longitude].toString());
    }
  }

  ///endregion updateFromMap

  ///region Equality
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LatLongModel &&
        latitude == other.latitude &&
        longitude == other.longitude;
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;

  ///endregion Equality
}

///endregion Model LatLongModel
