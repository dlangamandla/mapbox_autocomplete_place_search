// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) => Place(
  id: _idFromJson(json['id']),
  type: _typeFromJson(json['type']),
  placeType: _placeTypeFromJson(json['place_type']),
  relevance: _relevanceFromJson(json['relevance']),
  properties: _propertiesFromJson(json['properties'] as Map<String, dynamic>),
  text: _textFromJson(json['text']),
  placeName: _placeNameFromJson(json['place_name']),
  center: _centerFromJson(json['center']),
  geometry: _geometryFromJson(json['geometry'] as Map<String, dynamic>),
  context: _contextFromJson(json['context'] as List),
  bbox: _bboxFromJson(json['bbox']),
);

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
  'id': _idToJson(instance.id),
  'type': _typeToJson(instance.type),
  'place_type': _placeTypeToJson(instance.placeType),
  'relevance': _relevanceToJson(instance.relevance),
  'properties': _propertiesToJson(instance.properties),
  'text': _textToJson(instance.text),
  'place_name': _placeNameToJson(instance.placeName),
  'center': _centerToJson(instance.center),
  'geometry': _geometryToJson(instance.geometry),
  'context': _contextToJson(instance.context),
  'bbox': _bboxToJson(instance.bbox),
};

Properties _$PropertiesFromJson(Map<String, dynamic> json) => Properties(
  wikidata: _wikidataFromJson(json['wikidata']),
  shortcode: _shortcodeFromJson(json['shortcode']),
  foursquare: _foursquareFromJson(json['foursquare']),
  landmark: _landmarkFromJson(json['landmark']),
  address: _addressFromJson(json['address']),
  category: _categoryFromJson(json['category']),
  maki: _makiFromJson(json['maki']),
);

Map<String, dynamic> _$PropertiesToJson(Properties instance) =>
    <String, dynamic>{
      'wikidata': _wikidataToJson(instance.wikidata),
      'shortcode': _shortcodeToJson(instance.shortcode),
      'foursquare': _foursquareToJson(instance.foursquare),
      'landmark': _landmarkToJson(instance.landmark),
      'address': _addressToJson(instance.address),
      'category': _categoryToJson(instance.category),
      'maki': _makiToJson(instance.maki),
    };

Geometry _$GeometryFromJson(Map<String, dynamic> json) => Geometry(
  type: _geometryTypeFromJson(json['type']),
  coordinates: _geometryCoordinatesFromJson(json['coordinates']),
);

Map<String, dynamic> _$GeometryToJson(Geometry instance) => <String, dynamic>{
  'type': _geometryTypeToJson(instance.type),
  'coordinates': _geometryCoordinatesToJson(instance.coordinates),
};

Context _$ContextFromJson(Map<String, dynamic> json) => Context(
  id: _contextIdFromJson(json['id']),
  shortCode: json['short_code'] == null
      ? ''
      : _contextShortCodeFromJson(json['short_code']),
  wikidata: json['wikidata'] == null
      ? ''
      : _contextWikidataFromJson(json['wikidata']),
  text: _contextTextFromJson(json['text']),
);

Map<String, dynamic> _$ContextToJson(Context instance) => <String, dynamic>{
  'id': _contextIdToJson(instance.id),
  'short_code': _contextShortCodeToJson(instance.shortCode),
  'wikidata': _contextWikidataToJson(instance.wikidata),
  'text': _contextTextToJson(instance.text),
};
