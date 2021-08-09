import 'package:json_annotation/json_annotation.dart';
part 'eat_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class EatDetails {
  final String des;
  final int id;
  final String img;
  final String price;
  final String title;
  EatDetails({
    required this.des,
    required this.id,
    required this.img,
    required this.price,
    required this.title,
  });

   factory EatDetails.fromJson(Map<String, dynamic> json) => _$EatDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$EatDetailsToJson(this);
}
