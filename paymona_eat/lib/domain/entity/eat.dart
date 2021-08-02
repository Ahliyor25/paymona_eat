import 'package:json_annotation/json_annotation.dart';

part 'eat.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Eat {
  final int id;
  final String title;
  final String des;
  final String price;
  final String? img;

  Eat(
      {required this.id,
      required this.title,
      required this.des,
      required this.price,
      required this.img});
  factory Eat.fromJson(Map<String, dynamic> json) => _$EatFromJson(json);
  Map<String, dynamic> toJson() => _$EatToJson(this);
}
