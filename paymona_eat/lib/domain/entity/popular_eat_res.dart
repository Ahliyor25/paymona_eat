import 'package:dart_lesson/domain/entity/eat.dart';
import 'package:json_annotation/json_annotation.dart';

part 'popular_eat_res.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PopularEatRes {
  // final int page;
  @JsonKey(name: 'mainslider')
  final List<Eat> eats;
  final int count;

  PopularEatRes({
    required this.eats,
    required this.count,
  });

  factory PopularEatRes.fromJson(Map<String, dynamic> json) =>
      _$PopularEatResFromJson(json);

  Map<String, dynamic> toJson() => _$PopularEatResToJson(this);
}
