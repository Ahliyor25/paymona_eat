// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_eat_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularEatRes _$PopularEatResFromJson(Map<String, dynamic> json) {
  return PopularEatRes(
    eats: (json['mainslider'] as List<dynamic>)
        .map((e) => Eat.fromJson(e as Map<String, dynamic>))
        .toList(),
    count: json['count'] as int,
  );
}

Map<String, dynamic> _$PopularEatResToJson(PopularEatRes instance) =>
    <String, dynamic>{
      'mainslider': instance.eats.map((e) => e.toJson()).toList(),
      'count': instance.count,
    };
