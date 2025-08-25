import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import '../models/place_search_result.dart';
import '../models/place.dart';

class MapboxGeocodingService {
  static const String _baseUrl =
      'https://api.mapbox.com/geocoding/v5/mapbox.places';

  final String _accessToken;

  MapboxGeocodingService({required String accessToken})
    : _accessToken = accessToken;

  /// Search for places using Mapbox Geocoding API
  ///
  /// [query] - The search query string
  /// [limit] - Maximum number of results (default: 5)
  /// [types] - Types of places to search for (default: all types)
  /// [country] - Limit results to specific country codes
  /// [proximity] - Bias results toward a specific location [longitude, latitude]
  /// [bbox] - Limit results to a bounding box [minLon, minLat, maxLon, maxLat]
  Future<List<Place>> searchPlaces({
    required String query,
    int limit = 5,
    List<String>? types,
    List<String>? country,
    List<double>? proximity,
    List<double>? bbox,
  }) async {
    try {
      developer.log(
        '🔍 [MapboxGeocodingService] Starting place search',
        name: 'MapboxAPI',
      );
      print('🔍 [MapboxGeocodingService] Starting place search for: "$query"');
      developer.log('📝 Query: "$query"', name: 'MapboxAPI');
      developer.log('🔢 Limit: $limit', name: 'MapboxAPI');

      final queryParams = <String, String>{
        'access_token': _accessToken,
        'q': query,
        'limit': limit.toString(),
      };

      if (types != null && types.isNotEmpty) {
        queryParams['types'] = types.join(',');
        developer.log('🏷️ Types: $types', name: 'MapboxAPI');
        print('🏷️ Types: $types');
      }

      if (country != null && country.isNotEmpty) {
        queryParams['country'] = country.join(',');
        developer.log('🌍 Countries: $country', name: 'MapboxAPI');
        print('🌍 Countries: $country');
      }

      if (proximity != null && proximity.length == 2) {
        queryParams['proximity'] = '${proximity[0]},${proximity[1]}';
        developer.log(
          '📍 Proximity: ${proximity[0]}, ${proximity[1]}',
          name: 'MapboxAPI',
        );
        print('📍 Proximity: ${proximity[0]}, ${proximity[1]}');
      }

      if (bbox != null && bbox.length == 4) {
        queryParams['bbox'] = '${bbox[0]},${bbox[1]},${bbox[2]},${bbox[3]}';
        developer.log(
          '📦 Bounding Box: ${bbox[0]}, ${bbox[1]}, ${bbox[2]}, ${bbox[3]}',
          name: 'MapboxAPI',
        );
        print(
          '📦 Bounding Box: ${bbox[0]}, ${bbox[1]}, ${bbox[2]}, ${bbox[3]}',
        );
      }

      final uri = Uri.parse(
        '$_baseUrl/$query.json',
      ).replace(queryParameters: queryParams);
      developer.log(
        '🌐 [MapboxGeocodingService] Making API request to: ${uri.toString().replaceAll(_accessToken, '***TOKEN***')}',
        name: 'MapboxAPI',
      );
      print(
        '🌐 [MapboxGeocodingService] Making API request to: ${uri.toString().replaceAll(_accessToken, '***TOKEN***')}',
      );

      final stopwatch = Stopwatch()..start();
      final response = await http.get(uri);
      stopwatch.stop();

      developer.log(
        '⏱️ [MapboxGeocodingService] API response received in ${stopwatch.elapsedMilliseconds}ms',
        name: 'MapboxAPI',
      );
      print(
        '⏱️ [MapboxGeocodingService] API response received in ${stopwatch.elapsedMilliseconds}ms',
      );
      developer.log(
        '📡 Status Code: ${response.statusCode}',
        name: 'MapboxAPI',
      );
      print('📡 Status Code: ${response.statusCode}');
      developer.log(
        '📏 Response Size: ${response.body.length} characters',
        name: 'MapboxAPI',
      );
      print('📏 Response Size: ${response.body.length} characters');

      if (response.statusCode == 200) {
        developer.log(
          '✅ [MapboxGeocodingService] API call successful',
          name: 'MapboxAPI',
        );
        print('✅ [MapboxGeocodingService] API call successful');

        try {
          final jsonData = json.decode(response.body);
          developer.log('🔍 [MapboxGeocodingService] JSON parsed successfully', name: 'MapboxAPI');
          print('🔍 [MapboxGeocodingService] JSON parsed successfully');
          
          // Log the JSON structure for debugging
          developer.log('📄 [MapboxGeocodingService] JSON structure: ${jsonData.keys}', name: 'MapboxAPI');
          print('📄 [MapboxGeocodingService] JSON structure keys: ${jsonData.keys}');
          
          if (jsonData.containsKey('query')) {
            developer.log('🔍 [MapboxGeocodingService] Query field type: ${jsonData['query'].runtimeType}', name: 'MapboxAPI');
            print('🔍 [MapboxGeocodingService] Query field type: ${jsonData['query'].runtimeType}');
            developer.log('🔍 [MapboxGeocodingService] Query field value: ${jsonData['query']}', name: 'MapboxAPI');
            print('🔍 [MapboxGeocodingService] Query field value: ${jsonData['query']}');
          }
          
          if (jsonData.containsKey('attribution')) {
            developer.log('🔍 [MapboxGeocodingService] Attribution field type: ${jsonData['attribution'].runtimeType}', name: 'MapboxAPI');
            print('🔍 [MapboxGeocodingService] Attribution field type: ${jsonData['attribution'].runtimeType}');
            developer.log('🔍 [MapboxGeocodingService] Attribution field value: ${jsonData['attribution']}', name: 'MapboxAPI');
            print('🔍 [MapboxGeocodingService] Attribution field value: ${jsonData['attribution']}');
          }
          
          // Log the first feature in detail to identify the problematic field
          if (jsonData.containsKey('features') && jsonData['features'] is List && (jsonData['features'] as List).isNotEmpty) {
            final firstFeature = jsonData['features'][0];
            developer.log('🔍 [MapboxGeocodingService] First feature type: ${firstFeature.runtimeType}', name: 'MapboxAPI');
            print('🔍 [MapboxGeocodingService] First feature type: ${firstFeature.runtimeType}');
            
            if (firstFeature is Map) {
              developer.log('🔍 [MapboxGeocodingService] First feature keys: ${firstFeature.keys}', name: 'MapboxAPI');
              print('🔍 [MapboxGeocodingService] First feature keys: ${firstFeature.keys}');
              
              // Log each field type individually
              for (final key in firstFeature.keys) {
                final value = firstFeature[key];
                developer.log('🔍 [MapboxGeocodingService] Field "$key": type=${value.runtimeType}, value=$value', name: 'MapboxAPI');
                print('🔍 [MapboxGeocodingService] Field "$key": type=${value.runtimeType}, value=$value');
              }
            }
          }
          
          final result = PlaceSearchResult.fromJson(jsonData);
          developer.log('📍 [MapboxGeocodingService] Found ${result.features.length} places', name: 'MapboxAPI');
          print('📍 [MapboxGeocodingService] Found ${result.features.length} places');
          
          // Log each result briefly
          for (int i = 0; i < result.features.length; i++) {
            final place = result.features[i];
            developer.log('  ${i + 1}. ${place.text} (${place.placeType}) - ${place.latitude}, ${place.longitude}', name: 'MapboxAPI');
            print('  ${i + 1}. ${place.text} (${place.placeType}) - ${place.latitude}, ${place.longitude}');
          }
          
          return result.features;
        } catch (parseError) {
          developer.log('❌ [MapboxGeocodingService] JSON parsing failed: $parseError', name: 'MapboxAPI');
          print('❌ [MapboxGeocodingService] JSON parsing failed: $parseError');
          developer.log('📄 Raw response body: ${response.body.substring(0, response.body.length > 500 ? 500 : response.body.length)}...', name: 'MapboxAPI');
          print('📄 Raw response body: ${response.body.substring(0, response.body.length > 500 ? 500 : response.body.length)}...');
          
          // Log the full JSON structure for debugging
          try {
            final jsonData = json.decode(response.body);
            developer.log('📄 [MapboxGeocodingService] Full JSON structure: $jsonData', name: 'MapboxAPI');
            print('📄 [MapboxGeocodingService] Full JSON structure: $jsonData');
            
            // Try to identify which field is causing the issue
            if (jsonData.containsKey('features') && jsonData['features'] is List) {
              developer.log('🔍 [MapboxGeocodingService] Features array length: ${(jsonData['features'] as List).length}', name: 'MapboxAPI');
              print('🔍 [MapboxGeocodingService] Features array length: ${(jsonData['features'] as List).length}');
              
              if ((jsonData['features'] as List).isNotEmpty) {
                final firstFeature = jsonData['features'][0];
                developer.log('🔍 [MapboxGeocodingService] First feature keys: ${firstFeature is Map ? firstFeature.keys : 'Not a map'}', name: 'MapboxAPI');
                print('🔍 [MapboxGeocodingService] First feature keys: ${firstFeature is Map ? firstFeature.keys : 'Not a map'}');
              }
            }
          } catch (e) {
            developer.log('❌ [MapboxGeocodingService] Could not parse JSON for debugging: $e', name: 'MapboxAPI');
            print('❌ [MapboxGeocodingService] Could not parse JSON for debugging: $e');
          }
          
          throw Exception('Failed to parse API response: $parseError');
        }
      } else {
        developer.log('❌ [MapboxGeocodingService] API call failed with status: ${response.statusCode}', name: 'MapboxAPI');
        print('❌ [MapboxGeocodingService] API call failed with status: ${response.statusCode}');
        developer.log('📄 Error response body: ${response.body}', name: 'MapboxAPI');
        print('📄 Error response body: ${response.body}');
        
        // Try to provide more helpful error information
        if (response.statusCode == 401) {
          throw Exception('Authentication failed. Please check your Mapbox access token.');
        } else if (response.statusCode == 403) {
          throw Exception('Access denied. Please check your Mapbox access token permissions.');
        } else if (response.statusCode == 429) {
          throw Exception('Rate limit exceeded. Please wait before making more requests.');
        } else if (response.statusCode >= 500) {
          throw Exception('Mapbox service error. Please try again later.');
        }
        
        throw Exception('Failed to search places: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      developer.log(
        '💥 [MapboxGeocodingService] Exception during search: $e',
        name: 'MapboxAPI',
      );
      print('💥 [MapboxGeocodingService] Exception during search: $e');
      developer.log(
        '💥 [MapboxGeocodingService] Exception type: ${e.runtimeType}',
        name: 'MapboxAPI',
      );
      print('💥 [MapboxGeocodingService] Exception type: ${e.runtimeType}');
      throw Exception('Error searching places: $e');
    }
  }

  /// Get place details by coordinates (reverse geocoding)
  ///
  /// [longitude] - Longitude coordinate
  /// [latitude] - Latitude coordinate
  /// [types] - Types of places to search for
  Future<List<Place>> reverseGeocode({
    required double longitude,
    required double latitude,
    List<String>? types,
  }) async {
    try {
      developer.log(
        '🔄 [MapboxGeocodingService] Starting reverse geocoding',
        name: 'MapboxAPI',
      );
      print(
        '🔄 [MapboxGeocodingService] Starting reverse geocoding for: $longitude, $latitude',
      );
      developer.log('📍 Coordinates: $longitude, $latitude', name: 'MapboxAPI');

      final queryParams = <String, String>{'access_token': _accessToken};

      if (types != null && types.isNotEmpty) {
        queryParams['types'] = types.join(',');
        developer.log('🏷️ Types: $types', name: 'MapboxAPI');
        print('🏷️ Types: $types');
      }

      final uri = Uri.parse(
        '$_baseUrl/$longitude,$latitude.json',
      ).replace(queryParameters: queryParams);
      developer.log(
        '🌐 [MapboxGeocodingService] Making reverse geocoding request to: ${uri.toString().replaceAll(_accessToken, '***TOKEN***')}',
        name: 'MapboxAPI',
      );
      print(
        '🌐 [MapboxGeocodingService] Making reverse geocoding request to: ${uri.toString().replaceAll(_accessToken, '***TOKEN***')}',
      );

      final stopwatch = Stopwatch()..start();
      final response = await http.get(uri);
      stopwatch.stop();

      developer.log(
        '⏱️ [MapboxGeocodingService] Reverse geocoding response received in ${stopwatch.elapsedMilliseconds}ms',
        name: 'MapboxAPI',
      );
      print(
        '⏱️ [MapboxGeocodingService] Reverse geocoding response received in ${stopwatch.elapsedMilliseconds}ms',
      );
      developer.log(
        '📡 Status Code: ${response.statusCode}',
        name: 'MapboxAPI',
      );
      print('📡 Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        developer.log(
          '✅ [MapboxGeocodingService] Reverse geocoding successful',
          name: 'MapboxAPI',
        );
        print('✅ [MapboxGeocodingService] Reverse geocoding successful');

        try {
          final jsonData = json.decode(response.body);
          final result = PlaceSearchResult.fromJson(jsonData);
          developer.log(
            '📍 [MapboxGeocodingService] Found ${result.features.length} places for coordinates',
            name: 'MapboxAPI',
          );
          print(
            '📍 [MapboxGeocodingService] Found ${result.features.length} places for coordinates',
          );

          for (int i = 0; i < result.features.length; i++) {
            final place = result.features[i];
            developer.log(
              '  ${i + 1}. ${place.text} (${place.placeType})',
              name: 'MapboxAPI',
            );
            print('  ${i + 1}. ${place.text} (${place.placeType})');
          }

          return result.features;
        } catch (parseError) {
          developer.log(
            '❌ [MapboxGeocodingService] JSON parsing failed for reverse geocoding: $parseError',
            name: 'MapboxAPI',
          );
          print(
            '❌ [MapboxGeocodingService] JSON parsing failed for reverse geocoding: $parseError',
          );
          throw Exception(
            'Failed to parse reverse geocoding response: $parseError',
          );
        }
      } else {
        developer.log(
          '❌ [MapboxGeocodingService] Reverse geocoding failed with status: ${response.statusCode}',
          name: 'MapboxAPI',
        );
        print(
          '❌ [MapboxGeocodingService] Reverse geocoding failed with status: ${response.statusCode}',
        );
        developer.log(
          '📄 Error response body: ${response.body}',
          name: 'MapboxAPI',
        );
        print('📄 Error response body: ${response.body}');
        throw Exception(
          'Failed to reverse geocode: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      developer.log(
        '💥 [MapboxGeocodingService] Exception during reverse geocoding: $e',
        name: 'MapboxAPI',
      );
      print(
        '💥 [MapboxGeocodingService] Exception during reverse geocoding: $e',
      );
      throw Exception('Error reverse geocoding: $e');
    }
  }

  /// Get place details by place ID
  ///
  /// [placeId] - The Mapbox place ID
  Future<Place?> getPlaceDetails(String placeId) async {
    try {
      developer.log(
        '🔍 [MapboxGeocodingService] Getting place details for ID: $placeId',
        name: 'MapboxAPI',
      );
      print(
        '🔍 [MapboxGeocodingService] Getting place details for ID: $placeId',
      );

      final queryParams = <String, String>{'access_token': _accessToken};

      final uri = Uri.parse(
        '$_baseUrl/$placeId.json',
      ).replace(queryParameters: queryParams);
      developer.log(
        '🌐 [MapboxGeocodingService] Making place details request to: ${uri.toString().replaceAll(_accessToken, '***TOKEN***')}',
        name: 'MapboxAPI',
      );
      print(
        '🌐 [MapboxGeocodingService] Making place details request to: ${uri.toString().replaceAll(_accessToken, '***TOKEN***')}',
      );

      final stopwatch = Stopwatch()..start();
      final response = await http.get(uri);
      stopwatch.stop();

      developer.log(
        '⏱️ [MapboxGeocodingService] Place details response received in ${stopwatch.elapsedMilliseconds}ms',
        name: 'MapboxAPI',
      );
      print(
        '⏱️ [MapboxGeocodingService] Place details response received in ${stopwatch.elapsedMilliseconds}ms',
      );
      developer.log(
        '📡 Status Code: ${response.statusCode}',
        name: 'MapboxAPI',
      );
      print('📡 Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        developer.log(
          '✅ [MapboxGeocodingService] Place details retrieved successfully',
          name: 'MapboxAPI',
        );
        print(
          '✅ [MapboxGeocodingService] Place details retrieved successfully',
        );

        try {
          final jsonData = json.decode(response.body);
          final result = PlaceSearchResult.fromJson(jsonData);
          developer.log(
            '📍 [MapboxGeocodingService] Found ${result.features.length} features for place ID',
            name: 'MapboxAPI',
          );
          print(
            '📍 [MapboxGeocodingService] Found ${result.features.length} features for place ID',
          );

          if (result.features.isNotEmpty) {
            final place = result.features.first;
            developer.log(
              '📍 [MapboxGeocodingService] Place: ${place.text} (${place.placeType})',
              name: 'MapboxAPI',
            );
            print(
              '📍 [MapboxGeocodingService] Place: ${place.text} (${place.placeType})',
            );
            return place;
          } else {
            developer.log(
              '⚠️ [MapboxGeocodingService] No features found for place ID',
              name: 'MapboxAPI',
            );
            print('⚠️ [MapboxGeocodingService] No features found for place ID');
            return null;
          }
        } catch (parseError) {
          developer.log(
            '❌ [MapboxGeocodingService] JSON parsing failed for place details: $parseError',
            name: 'MapboxAPI',
          );
          print(
            '❌ [MapboxGeocodingService] JSON parsing failed for place details: $parseError',
          );
          throw Exception(
            'Failed to parse place details response: $parseError',
          );
        }
      } else {
        developer.log(
          '❌ [MapboxGeocodingService] Place details request failed with status: ${response.statusCode}',
          name: 'MapboxAPI',
        );
        print(
          '❌ [MapboxGeocodingService] Place details request failed with status: ${response.statusCode}',
        );
        developer.log(
          '📄 Error response body: ${response.body}',
          name: 'MapboxAPI',
        );
        print('📄 Error response body: ${response.body}');
        throw Exception(
          'Failed to get place details: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      developer.log(
        '💥 [MapboxGeocodingService] Exception during place details retrieval: $e',
        name: 'MapboxAPI',
      );
      print(
        '💥 [MapboxGeocodingService] Exception during place details retrieval: $e',
      );
      throw Exception('Error getting place details: $e');
    }
  }
}
