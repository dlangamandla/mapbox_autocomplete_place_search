import 'package:json_annotation/json_annotation.dart';

part 'place.g.dart';

@JsonSerializable()
class Place {
  @JsonKey(fromJson: _idFromJson, toJson: _idToJson)
  final String id;
  @JsonKey(fromJson: _typeFromJson, toJson: _typeToJson)
  final String type;
  @JsonKey(
    name: 'place_type',
    fromJson: _placeTypeFromJson,
    toJson: _placeTypeToJson,
  )
  final String placeType;
  @JsonKey(fromJson: _relevanceFromJson, toJson: _relevanceToJson)
  final double relevance;
  @JsonKey(toJson: _propertiesToJson, fromJson: _propertiesFromJson)
  final Properties properties;
  @JsonKey(fromJson: _textFromJson, toJson: _textToJson)
  final String text;
  @JsonKey(
    name: 'place_name',
    fromJson: _placeNameFromJson,
    toJson: _placeNameToJson,
  )
  final String placeName;
  @JsonKey(fromJson: _centerFromJson, toJson: _centerToJson)
  final List<double> center;
  @JsonKey(toJson: _geometryToJson, fromJson: _geometryFromJson)
  final Geometry geometry;
  @JsonKey(toJson: _contextToJson, fromJson: _contextFromJson)
  final List<Context> context;
  @JsonKey(fromJson: _bboxFromJson, toJson: _bboxToJson)
  final List<double> bbox;

  const Place({
    required this.id,
    required this.type,
    required this.placeType,
    required this.relevance,
    required this.properties,
    required this.text,
    required this.placeName,
    required this.center,
    required this.geometry,
    required this.context,
    required this.bbox,
  });

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceToJson(this);

  double? get latitude => center.isNotEmpty ? center[1] : null;
  double? get longitude => center.isNotEmpty ? center[0] : null;
}

@JsonSerializable()
class Properties {
  @JsonKey(fromJson: _wikidataFromJson, toJson: _wikidataToJson)
  final String? wikidata;
  @JsonKey(fromJson: _shortcodeFromJson, toJson: _shortcodeToJson)
  final String? shortcode;
  @JsonKey(fromJson: _foursquareFromJson, toJson: _foursquareToJson)
  final String? foursquare;
  @JsonKey(fromJson: _landmarkFromJson, toJson: _landmarkToJson)
  final String? landmark;
  @JsonKey(fromJson: _addressFromJson, toJson: _addressToJson)
  final String? address;
  @JsonKey(fromJson: _categoryFromJson, toJson: _categoryToJson)
  final String? category;
  @JsonKey(fromJson: _makiFromJson, toJson: _makiToJson)
  final String? maki;

  const Properties({
    this.wikidata,
    this.shortcode,
    this.foursquare,
    this.landmark,
    this.address,
    this.category,
    this.maki,
  });

  factory Properties.fromJson(Map<String, dynamic> json) =>
      _$PropertiesFromJson(json);
  Map<String, dynamic> toJson() => _$PropertiesToJson(this);
}

@JsonSerializable()
class Geometry {
  @JsonKey(fromJson: _geometryTypeFromJson, toJson: _geometryTypeToJson)
  final String type;
  @JsonKey(
    fromJson: _geometryCoordinatesFromJson,
    toJson: _geometryCoordinatesToJson,
  )
  final List<double> coordinates;

  const Geometry({required this.type, required this.coordinates});

  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);
  Map<String, dynamic> toJson() => _$GeometryToJson(this);
}

@JsonSerializable()
class Context {
  @JsonKey(fromJson: _contextIdFromJson, toJson: _contextIdToJson)
  final String id;
  @JsonKey(
    name: 'short_code',
    defaultValue: '',
    fromJson: _contextShortCodeFromJson,
    toJson: _contextShortCodeToJson,
  )
  final String shortCode;
  @JsonKey(
    defaultValue: '',
    fromJson: _contextWikidataFromJson,
    toJson: _contextWikidataToJson,
  )
  final String wikidata;
  @JsonKey(fromJson: _contextTextFromJson, toJson: _contextTextToJson)
  final String text;

  const Context({
    required this.id,
    required this.shortCode,
    required this.wikidata,
    required this.text,
  });

  factory Context.fromJson(Map<String, dynamic> json) =>
      _$ContextFromJson(json);
  Map<String, dynamic> toJson() => _$ContextToJson(this);
}

// Helper functions for JSON serialization
Map<String, dynamic> _propertiesToJson(Properties properties) =>
    properties.toJson();
Properties _propertiesFromJson(Map<String, dynamic> json) =>
    Properties.fromJson(json);

Map<String, dynamic> _geometryToJson(Geometry geometry) => geometry.toJson();
Geometry _geometryFromJson(Map<String, dynamic> json) =>
    Geometry.fromJson(json);

List<Map<String, dynamic>> _contextToJson(List<Context> context) =>
    context.map((c) => c.toJson()).toList();
List<Context> _contextFromJson(List<dynamic> json) {
  if (json.isEmpty) return [];

  try {
    return json.map((c) {
      if (c is Map<String, dynamic>) {
        return Context.fromJson(c);
      }
      return const Context(id: '', shortCode: '', wikidata: '', text: '');
    }).toList();
  } catch (e) {
    return [];
  }
}

// Helper functions for bbox field conversion
List<double> _bboxFromJson(dynamic json) {
  if (json is List) {
    return json.map((e) => (e is num) ? e.toDouble() : 0.0).toList();
  }
  if (json is String) {
    // If bbox is a string, try to parse it or return empty list
    try {
      final parts = json
          .split(',')
          .map((e) => double.tryParse(e.trim()) ?? 0.0)
          .toList();
      return parts;
    } catch (e) {
      return [];
    }
  }
  return [];
}

List<double> _bboxToJson(List<double> bbox) {
  return bbox;
}

// Helper functions for center field conversion
List<double> _centerFromJson(dynamic json) {
  if (json is List) {
    return json.map((e) => (e is num) ? e.toDouble() : 0.0).toList();
  }
  if (json is String) {
    // If center is a string, try to parse it or return empty list
    try {
      final parts = json
          .split(',')
          .map((e) => double.tryParse(e.trim()) ?? 0.0)
          .toList();
      return parts;
    } catch (e) {
      return [];
    }
  }
  return [];
}

List<double> _centerToJson(List<double> center) {
  return center;
}

// Helper functions for relevance field conversion
double _relevanceFromJson(dynamic json) {
  if (json is num) {
    return json.toDouble();
  }
  if (json is String) {
    return double.tryParse(json) ?? 0.0;
  }
  return 0.0;
}

double _relevanceToJson(double relevance) {
  return relevance;
}

// Helper functions for id field conversion
String _idFromJson(dynamic json) {
  if (json is String) {
    return json;
  }
  if (json is num) {
    return json.toString();
  }
  return json?.toString() ?? '';
}

String _idToJson(String id) {
  return id;
}

// Helper functions for type field conversion
String _typeFromJson(dynamic json) {
  if (json is String) {
    return json;
  }
  if (json is num) {
    return json.toString();
  }
  return json?.toString() ?? '';
}

String _typeToJson(String type) {
  return type;
}

// Helper functions for place_type field conversion
String _placeTypeFromJson(dynamic json) {
  if (json is String) {
    return json;
  }
  if (json is num) {
    return json.toString();
  }
  if (json is List) {
    return json.join(',');
  }
  return json?.toString() ?? '';
}

String _placeTypeToJson(String placeType) {
  return placeType;
}

// Helper functions for text field conversion
String _textFromJson(dynamic json) {
  if (json is String) {
    return json;
  }
  if (json is num) {
    return json.toString();
  }
  if (json is List) {
    return json.join(',');
  }
  return json?.toString() ?? '';
}

String _textToJson(String text) {
  return text;
}

// Helper functions for place_name field conversion
String _placeNameFromJson(dynamic json) {
  if (json is String) {
    return json;
  }
  if (json is num) {
    return json.toString();
  }
  if (json is List) {
    return json.join(',');
  }
  return json?.toString() ?? '';
}

String _placeNameToJson(String placeName) {
  return placeName;
}

// Helper functions for Geometry type field conversion
String _geometryTypeFromJson(dynamic json) {
  if (json is String) {
    return json;
  }
  if (json is num) {
    return json.toString();
  }
  return json?.toString() ?? '';
}

String _geometryTypeToJson(String type) {
  return type;
}

// Helper functions for Geometry coordinates field conversion
List<double> _geometryCoordinatesFromJson(dynamic json) {
  if (json is List) {
    return json.map((e) => (e is num) ? e.toDouble() : 0.0).toList();
  }
  if (json is String) {
    try {
      final parts = json
          .split(',')
          .map((e) => double.tryParse(e.trim()) ?? 0.0)
          .toList();
      return parts;
    } catch (e) {
      return [];
    }
  }
  return [];
}

List<double> _geometryCoordinatesToJson(List<double> coordinates) {
  return coordinates;
}

// Helper functions for Properties fields conversion
String? _wikidataFromJson(dynamic json) {
  if (json == null) return null;
  if (json is String) return json;
  return json.toString();
}

String? _wikidataToJson(String? wikidata) => wikidata;

String? _shortcodeFromJson(dynamic json) {
  if (json == null) return null;
  if (json is String) return json;
  return json.toString();
}

String? _shortcodeToJson(String? shortcode) => shortcode;

String? _foursquareFromJson(dynamic json) {
  if (json == null) return null;
  if (json is String) return json;
  return json.toString();
}

String? _foursquareToJson(String? foursquare) => foursquare;

String? _landmarkFromJson(dynamic json) {
  if (json == null) return null;
  if (json is String) return json;
  return json.toString();
}

String? _landmarkToJson(String? landmark) => landmark;

String? _addressFromJson(dynamic json) {
  if (json == null) return null;
  if (json is String) return json;
  return json.toString();
}

String? _addressToJson(String? address) => address;

String? _categoryFromJson(dynamic json) {
  if (json == null) return null;
  if (json is String) return json;
  return json.toString();
}

String? _categoryToJson(String? category) => category;

String? _makiFromJson(dynamic json) {
  if (json == null) return null;
  if (json is String) return json;
  return json.toString();
}

String? _makiToJson(String? maki) => maki;

// Helper functions for Context fields conversion
String _contextIdFromJson(dynamic json) {
  if (json is String) return json;
  if (json is num) return json.toString();
  return json?.toString() ?? '';
}

String _contextIdToJson(String id) => id;

String _contextShortCodeFromJson(dynamic json) {
  if (json is String) return json;
  if (json is num) return json.toString();
  return json?.toString() ?? '';
}

String _contextShortCodeToJson(String shortCode) => shortCode;

String _contextWikidataFromJson(dynamic json) {
  if (json is String) return json;
  if (json is num) return json.toString();
  return json?.toString() ?? '';
}

String _contextWikidataToJson(String wikidata) => wikidata;

String _contextTextFromJson(dynamic json) {
  if (json is String) return json;
  if (json is num) return json.toString();
  if (json is List) return json.join(',');
  return json?.toString() ?? '';
}

String _contextTextToJson(String text) => text;
