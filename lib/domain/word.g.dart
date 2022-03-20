// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Word _$WordFromJson(Map<String, dynamic> json) => Word(
      json['word'] as String,
      json['japanese'] as String,
      json['commentary'] as String,
    );

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
      'word': instance.word,
      'japanese': instance.japanese,
      'commentary': instance.commentary,
    };
