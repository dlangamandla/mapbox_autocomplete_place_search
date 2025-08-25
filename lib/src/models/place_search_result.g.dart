// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceSearchResult _$PlaceSearchResultFromJson(Map<String, dynamic> json) =>
    PlaceSearchResult(
      type: _typeFromJson(json['type']),
      features: (json['features'] as List<dynamic>)
          .map((e) => Place.fromJson(e as Map<String, dynamic>))
          .toList(),
      query: _queryFromJson(json['query']),
      attribution: _attributionFromJson(json['attribution']),
    );

Map<String, dynamic> _$PlaceSearchResultToJson(PlaceSearchResult instance) =>
    <String, dynamic>{
      'type': _typeToJson(instance.type),
      'features': instance.features,
      'query': _queryToJson(instance.query),
      'attribution': _attributionToJson(instance.attribution),
    };
