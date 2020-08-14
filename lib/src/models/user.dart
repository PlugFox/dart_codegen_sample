import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
      int id,
      String name,
      String username,
      String email,
      Address address,
      String phone,
      String website,
      Company company,
  }) = _User;

  /// Generate Class from Map<String, dynamic>
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
abstract class Company with _$Company {
  const factory Company({
      String name,
      String catchPhrase,
      String bs,
  }) = _Company;
  
  /// Generate Class from Map<String, dynamic>
  factory Company.fromJson(Map<String, dynamic> json) => _$CompanyFromJson(json);
}

@freezed
abstract class Address with _$Address {
  const factory Address({
      String street,
      String suite,
      String city,
      String zipcode,
      Geo geo,
  }) = _Address;
  
  /// Generate Class from Map<String, dynamic>
  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
}

@freezed
abstract class Geo with _$Geo {
  const factory Geo({
      @JsonKey(name: 'lat') String latitude,
      @JsonKey(name: 'lng') String longitude,
  }) = _Geo;
  
  /// Generate Class from Map<String, dynamic>
  factory Geo.fromJson(Map<String, dynamic> json) => _$GeoFromJson(json);
}