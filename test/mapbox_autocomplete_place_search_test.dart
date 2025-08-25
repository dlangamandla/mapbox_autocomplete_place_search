import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mapbox_autocomplete_place_search/mapbox_autocomplete_place_search.dart';

void main() {
  group('Place Model Tests', () {
    test('should create Place from JSON', () {
      final json = {
        'id': 'place.123',
        'type': 'Feature',
        'place_type': 'place',
        'relevance': 0.9,
        'properties': {
          'wikidata': null,
          'shortcode': null,
          'foursquare': null,
          'landmark': null,
          'address': null,
          'category': null,
          'maki': null,
        },
        'text': 'New York',
        'place_name': 'New York, NY, USA',
        'center': [-74.006, 40.7128],
        'geometry': {
          'type': 'Point',
          'coordinates': [-74.006, 40.7128],
        },
        'context': [],
        'bbox': [],
      };

      final place = Place.fromJson(json);

      expect(place.id, 'place.123');
      expect(place.text, 'New York');
      expect(place.placeName, 'New York, NY, USA');
      expect(place.center, [-74.006, 40.7128]);
      expect(place.latitude, 40.7128);
      expect(place.longitude, -74.006);
    });

    test('should convert Place to JSON', () {
      final place = const Place(
        id: 'place.123',
        type: 'Feature',
        placeType: 'place',
        relevance: 0.9,
        properties: Properties(wikidata: 'Q123', shortcode: 'US'),
        text: 'New York',
        placeName: 'New York, NY, USA',
        center: [-74.006, 40.7128],
        geometry: Geometry(type: 'Point', coordinates: [-74.006, 40.7128]),
        context: [
          Context(
            id: 'country.123',
            shortCode: 'us',
            wikidata: 'Q30',
            text: 'United States',
          ),
        ],
        bbox: [-74.259, 40.477, -73.700, 40.917],
      );

      final json = place.toJson();

      expect(json['id'], 'place.123');
      expect(json['type'], 'Feature');
      expect(json['text'], 'New York');
      expect(json['place_name'], 'New York, NY, USA');
    });
  });

  group('PlaceSearchResult Model Tests', () {
    test('should create PlaceSearchResult from JSON', () {
      final json = {
        'type': 'FeatureCollection',
        'features': [
          {
            'id': 'place.123',
            'type': 'Feature',
            'place_type': 'place',
            'relevance': 0.9,
            'properties': {
              'wikidata': null,
              'shortcode': null,
              'foursquare': null,
              'landmark': null,
              'address': null,
              'category': null,
              'maki': null,
            },
            'text': 'New York',
            'place_name': 'New York, NY, USA',
            'center': [-74.006, 40.7128],
            'geometry': {
              'type': 'Point',
              'coordinates': [-74.006, 40.7128],
            },
            'context': [],
            'bbox': [],
          },
        ],
        'query': ['new', 'york'],
        'attribution': [0.1, 0.2],
      };

      final result = PlaceSearchResult.fromJson(json);

      expect(result.type, 'FeatureCollection');
      expect(result.features.length, 1);
      expect(result.features.first.text, 'New York');
      expect(result.query, 'new,york');
      expect(result.attribution, [0.1, 0.2]);
    });
  });

  group('MapboxGeocodingService Tests', () {
    test('should create service with access token', () {
      final service = MapboxGeocodingService(accessToken: 'test_token');
      expect(service, isNotNull);
    });

    test('should have required methods', () {
      final service = MapboxGeocodingService(accessToken: 'test_token');
      expect(service.searchPlaces, isA<Function>());
      expect(service.reverseGeocode, isA<Function>());
      expect(service.getPlaceDetails, isA<Function>());
    });
  });

  group('PlaceSearchField Widget Tests', () {
    testWidgets('should render search field with hint text', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PlaceSearchField(
              accessToken: 'test_token',
              hintText: 'Search for a place...',
            ),
          ),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Search for a place...'), findsOneWidget);
    });

    testWidgets('should handle empty search query', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: PlaceSearchField(accessToken: 'test_token')),
        ),
      );

      await tester.enterText(find.byType(TextField), '');
      await tester.pump();

      // Wait for debounce timer
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pump();

      // Should not show results
      expect(find.byType(ListView), findsNothing);
    });
  });

  group('PlaceSearchDialog Widget Tests', () {
    testWidgets('should render dialog with title and search field', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => PlaceSearchDialog(
                    accessToken: 'test_token',
                    title: 'Search Places',
                    onPlaceSelected: (place) {},
                  ),
                ),
                child: const Text('Open Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Search Places'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('should close dialog when close button is pressed', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => PlaceSearchDialog(
                    accessToken: 'test_token',
                    onPlaceSelected: (place) {},
                  ),
                ),
                child: const Text('Open Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(find.text('Search Places'), findsNothing);
    });
  });

  group('Integration Tests', () {
    test('should handle model serialization and deserialization', () {
      final originalPlace = const Place(
        id: 'place.123',
        type: 'Feature',
        placeType: 'place',
        relevance: 0.9,
        properties: Properties(wikidata: 'Q123', shortcode: 'US'),
        text: 'New York',
        placeName: 'New York, NY, USA',
        center: [-74.006, 40.7128],
        geometry: Geometry(type: 'Point', coordinates: [-74.006, 40.7128]),
        context: [
          Context(
            id: 'country.123',
            shortCode: 'us',
            wikidata: 'Q30',
            text: 'United States',
          ),
        ],
        bbox: [-74.259, 40.477, -73.700, 40.917],
      );

      final json = originalPlace.toJson();
      final deserializedPlace = Place.fromJson(json);

      expect(deserializedPlace.id, originalPlace.id);
      expect(deserializedPlace.text, originalPlace.text);
      expect(deserializedPlace.placeName, originalPlace.placeName);
      expect(deserializedPlace.latitude, originalPlace.latitude);
      expect(deserializedPlace.longitude, originalPlace.longitude);
    });
  });
}
