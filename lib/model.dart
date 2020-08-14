import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class RefuseEntity {
  factory RefuseEntity.fromJson(Map<String, dynamic> json) => _$RefuseEntityFromJson(json);
  Map<String, dynamic> toJson() => _$RefuseEntityToJson(this);

  RefuseEntity(this.id, this.message, {this.isSelected = false, this.isRequiredPhoto = false});

  @JsonKey(
    name: 'id',
    disallowNullValue: true,
    required: true,
    fromJson: _idFromJsonDecoder,
    toJson: _idToJsonEncoder,
  )
  final int id;

  @JsonKey(
      name: 'message',
      disallowNullValue: true,
      required: true,
  )
  final String message;

  @JsonKey(ignore: true)
  bool isSelected;

  @JsonKey(
      name: 'photoRequired',
      defaultValue: false,
  )
  bool isRequiredPhoto = false;

  static int _idFromJsonDecoder(String id) => int.parse(id);
  static String _idToJsonEncoder(int id) => id.toString();

  @override
  String toString() => toJson().toString();
}
