// To parse this JSON data, do
//
//     final UserModel = UserModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.company,
    required this.age,
    required this.address,
    required this.geo,
  });

  final int? id;
  final String name;
  final String email;
  final String photoUrl;
  final String company;
  final int age;
  final Address address;
  final Geo geo;

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? photoUrl,
    String? company,
    int? age,
    Address? address,
    Geo? geo,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      company: company ?? this.company,
      age: age ?? this.age,
      address: address ?? this.address,
      geo: geo ?? this.geo,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        photoUrl: json["photoUrl"],
        company: json["company"],
        age: json["age"],
        address: Address.fromJson(json["address"]),
        geo: Geo.fromJson(json["geo"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "photoUrl": photoUrl,
        "company": company,
        "age": age,
        "address": address.toJson(),
        "geo": geo.toJson(),
      };

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'company': company,
      'age': age,
      'address': address.toMap(),
      'geo': geo.toMap(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      photoUrl: map['photoUrl'],
      company: map['company'],
      age: map['age'],
      address: Address.fromMap(map['address']),
      geo: Geo.fromMap(map['geo']),
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, photoUrl: $photoUrl, company: $company, age: $age, address: $address, geo: $geo)';
  }
}

class Address {
  Address({
    this.street,
    this.city,
  });

  final String? street;
  final String? city;

  Address copyWith({
    String? street,
    String? city,
  }) =>
      Address(
        street: street ?? this.street,
        city: city ?? this.city,
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json["street"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "street": street,
        "city": city,
      };

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'city': city,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      street: map['street'],
      city: map['city'],
    );
  }

  @override
  String toString() => 'Address(street: $street, city: $city)';
}

class Geo {
  Geo({
    this.lat,
    this.lng,
  });

  final String? lat;
  final String? lng;

  Geo copyWith({
    String? lat,
    String? lng,
  }) =>
      Geo(
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
      );

  factory Geo.fromJson(Map<String, dynamic> json) => Geo(
        lat: json["lat"],
        lng: json["lng"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  factory Geo.fromMap(Map<String, dynamic> map) {
    return Geo(
      lat: map['lat'],
      lng: map['lng'],
    );
  }


  @override
  String toString() => 'Geo(lat: $lat, lng: $lng)';
}
