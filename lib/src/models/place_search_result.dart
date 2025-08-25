import 'package:json_annotation/json_annotation.dart';
import 'place.dart';

part 'place_search_result.g.dart';

@JsonSerializable()
class PlaceSearchResult {
  @JsonKey(fromJson: _typeFromJson, toJson: _typeToJson)
  final String type;
  final List<Place> features;
  @JsonKey(fromJson: _queryFromJson, toJson: _queryToJson)
  final String query;
  @JsonKey(fromJson: _attributionFromJson, toJson: _attributionToJson)
  final List<double> attribution;

  const PlaceSearchResult({
    required this.type,
    required this.features,
    required this.query,
    required this.attribution,
  });

  factory PlaceSearchResult.fromJson(Map<String, dynamic> json) =>
      _$PlaceSearchResultFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceSearchResultToJson(this);
}

// Helper functions for type field conversion
String _typeFromJson(dynamic json) {
  if (json is String) return json;
  if (json is num) return json.toString();
  return json?.toString() ?? '';
}

String _typeToJson(String type) => type;

// Helper functions for query field conversion
String _queryFromJson(dynamic json) {
  if (json is List) {
    return json.join(',');
  }
  return json.toString();
}

List<String> _queryToJson(String query) {
  return query.split(',');
}

// Helper functions for attribution field conversion
List<double> _attributionFromJson(dynamic json) {
  if (json is List) {
    return json.map((e) => (e is num) ? e.toDouble() : 0.0).toList();
  }
  if (json is String) {
    // If attribution is a string, try to parse it or return empty list
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

List<double> _attributionToJson(List<double> attribution) {
  return attribution;
}
