// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eat_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EatDetails _$EatDetailsFromJson(Map<String, dynamic> json) {
  return EatDetails(
    des: json['des'] as String,
    id: json['id'] as int,
    img: json['img'] as String,
    price: json['price'] as String,
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$EatDetailsToJson(EatDetails instance) =>
    <String, dynamic>{
      'des': instance.des,
      'id': instance.id,
      'img': instance.img,
      'price': instance.price,
      'title': instance.title,
    };
