// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Eat _$EatFromJson(Map<String, dynamic> json) {
  return Eat(
    id: json['id'] as int,
    title: json['title'] as String,
    des: json['des'] as String,
    price: json['price'] as String,
    img: json['img'] as String?,
  );
}

Map<String, dynamic> _$EatToJson(Eat instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'des': instance.des,
      'price': instance.price,
      'img': instance.img,
    };
