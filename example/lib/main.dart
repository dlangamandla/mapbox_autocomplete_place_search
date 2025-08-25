import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:mapbox_autocomplete_place_search/mapbox_autocomplete_place_search.dart';

// Replace with your actual Mapbox access token
// IMPORTANT: Use a PUBLIC access token (pk.) for the Geocoding API, not a secret key (sk.)
// Get your public token at: https://account.mapbox.com/access-tokens/
const String mapboxAccessToken = 'pk.eyJ1IjoibXV0ZXN0aW1.......';

void main() {
  developer.log('🚀 [Main] App starting...', name: 'MainApp');
  print('🚀 [Main] App starting...');
  developer.log(
    '🔑 [Main] Mapbox access token: ${mapboxAccessToken.substring(0, 20)}...',
    name: 'MainApp',
  );
  print(
    '🔑 [Main] Mapbox access token: ${mapboxAccessToken.substring(0, 20)}...',
  );

  // Check access token format
  if (mapboxAccessToken.startsWith('sk.')) {
    print(
      '⚠️ [Main] WARNING: You are using a secret key (sk.) for the Geocoding API.',
    );
    print(
      '⚠️ [Main] For the Geocoding API, you should use a public access token (pk.).',
    );
    print(
      '⚠️ [Main] Secret keys are for server-side operations and may cause authentication issues.',
    );
  } else if (mapboxAccessToken.startsWith('pk.')) {
    print(
      '✅ [Main] Using public access token (pk.) - this is correct for the Geocoding API.',
    );
  } else {
    print(
      '⚠️ [Main] Unknown access token format. Please ensure you have a valid Mapbox access token.',
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mapbox Place Search Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  // Note: Replace with your actual Mapbox access token
  // static const String mapboxAccessToken = 'YOUR_MAPBOX_ACCESS_TOKEN_HERE';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Mapbox Place Search Examples'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select an example to test:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Example 1: Basic Place Search Field
            Card(
              child: ListTile(
                leading: const Icon(Icons.search, color: Colors.orange),
                title: const Text('Basic Place Search Field'),
                subtitle: const Text('Simple autocomplete search field'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BasicSearchExample(),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Example 2: Place Search Dialog
            Card(
              child: ListTile(
                leading: const Icon(Icons.location_on, color: Colors.orange),
                title: const Text('Place Search Dialog'),
                subtitle: const Text('Full-screen search dialog'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DialogSearchExample(),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Example 3: Custom Service Usage
            Card(
              child: ListTile(
                leading: const Icon(Icons.api, color: Colors.orange),
                title: const Text('Custom Service Usage'),
                subtitle: const Text('Direct API calls with custom logic'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomServiceExample(),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Example 4: Advanced Features
            Card(
              child: ListTile(
                leading: const Icon(Icons.settings, color: Colors.orange),
                title: const Text('Advanced Features'),
                subtitle: const Text(
                  'Filtering, limits, and custom parameters',
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdvancedExample(),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Access Token Warning
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                border: Border.all(color: Colors.orange.shade200),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning, color: Colors.orange.shade700),
                      const SizedBox(width: 8),
                      Text(
                        'Setup Required',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Replace "YOUR_MAPBOX_ACCESS_TOKEN_HERE" with your actual Mapbox access token in main.dart to enable the examples.',
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Get your free token at: https://account.mapbox.com/',
                    style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Example 1: Basic Place Search Field
class BasicSearchExample extends StatefulWidget {
  const BasicSearchExample({super.key});

  @override
  State<BasicSearchExample> createState() => _BasicSearchExampleState();
}

class _BasicSearchExampleState extends State<BasicSearchExample> {
  Place? selectedPlace;

  @override
  void initState() {
    super.initState();
    developer.log(
      '🏠 [BasicSearchExample] Page initialized',
      name: 'ExamplePages',
    );
    print('🏠 [BasicSearchExample] Page initialized');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Place Search Field'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Basic Usage:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            PlaceSearchField(
              accessToken: mapboxAccessToken,
              hintText: 'Search for a place...',
              maxResults: 5,
              onPlaceSelected: (place) {
                developer.log(
                  '🎯 Place selected in BasicSearchExample:',
                  name: 'BasicSearchExample',
                );
                print('🎯 [BasicSearchExample] Place selected:');
                developer.log(
                  '   Text: ${place.text}',
                  name: 'BasicSearchExample',
                );
                print('   Text: ${place.text}');
                developer.log(
                  '   Place Name: ${place.placeName}',
                  name: 'BasicSearchExample',
                );
                print('   Place Name: ${place.placeName}');
                developer.log(
                  '   Coordinates: ${place.latitude}, ${place.longitude}',
                  name: 'BasicSearchExample',
                );
                print('   Coordinates: ${place.latitude}, ${place.longitude}');
                developer.log(
                  '   Type: ${place.placeType}',
                  name: 'BasicSearchExample',
                );
                print('   Type: ${place.placeType}');
                setState(() {
                  selectedPlace = place;
                });
              },
            ),

            const SizedBox(height: 20),

            if (selectedPlace != null) ...[
              const Text(
                'Selected Place:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedPlace!.text,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        selectedPlace!.placeName,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            'Lat: ${selectedPlace!.latitude?.toStringAsFixed(6) ?? 'N/A'}, '
                            'Lng: ${selectedPlace!.longitude?.toStringAsFixed(6) ?? 'N/A'}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.category, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            'Type: ${selectedPlace!.placeType}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Example 2: Place Search Dialog
class DialogSearchExample extends StatefulWidget {
  const DialogSearchExample({super.key});

  @override
  State<DialogSearchExample> createState() => _DialogSearchExampleState();
}

class _DialogSearchExampleState extends State<DialogSearchExample> {
  List<Place> selectedPlaces = [];

  @override
  void initState() {
    super.initState();
    developer.log(
      '🏠 [DialogSearchExample] Page initialized',
      name: 'ExamplePages',
    );
    print('🏠 [DialogSearchExample] Page initialized');
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => PlaceSearchDialog(
        accessToken: mapboxAccessToken,
        title: 'Search for Places',
        hintText: 'Enter place name...',
        onPlaceSelected: (place) {
          developer.log(
            '🎯 Place selected in DialogSearchExample:',
            name: 'DialogSearchExample',
          );
          print('🎯 [DialogSearchExample] Place selected:');
          developer.log('   Text: ${place.text}', name: 'DialogSearchExample');
          print('   Text: ${place.text}');
          developer.log(
            '   Place Name: ${place.placeName}',
            name: 'DialogSearchExample',
          );
          print('   Place Name: ${place.placeName}');
          developer.log(
            '   Coordinates: ${place.latitude}, ${place.longitude}',
            name: 'DialogSearchExample',
          );
          print('   Coordinates: ${place.latitude}, ${place.longitude}');
          developer.log(
            '   Type: ${place.placeType}',
            name: 'DialogSearchExample',
          );
          print('   Type: ${place.placeType}');
          setState(() {
            selectedPlaces.add(place);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Place Search Dialog'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dialog Usage:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: _showSearchDialog,
              icon: const Icon(Icons.search),
              label: const Text('Open Search Dialog'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Selected Places (${selectedPlaces.length}):',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (selectedPlaces.isNotEmpty)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedPlaces.clear();
                      });
                    },
                    child: const Text('Clear All'),
                  ),
              ],
            ),

            const SizedBox(height: 8),

            Expanded(
              child: selectedPlaces.isEmpty
                  ? const Center(
                      child: Text(
                        'No places selected yet.\nTap the button above to search.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: selectedPlaces.length,
                      itemBuilder: (context, index) {
                        final place = selectedPlaces[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: const Icon(
                              Icons.place,
                              color: Colors.orange,
                            ),
                            title: Text(place.text),
                            subtitle: Text(place.placeName),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  selectedPlaces.removeAt(index);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// Example 3: Custom Service Usage
class CustomServiceExample extends StatefulWidget {
  const CustomServiceExample({super.key});

  @override
  State<CustomServiceExample> createState() => _CustomServiceExampleState();
}

class _CustomServiceExampleState extends State<CustomServiceExample> {
  final MapboxGeocodingService _geocodingService = MapboxGeocodingService(
    accessToken: mapboxAccessToken,
  );
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lngController = TextEditingController();

  List<Place> searchResults = [];
  List<Place> reverseResults = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    developer.log(
      '🏠 [CustomServiceExample] Page initialized',
      name: 'ExamplePages',
    );
    print('🏠 [CustomServiceExample] Page initialized');
    developer.log(
      '🔑 [CustomServiceExample] Using access token: ${mapboxAccessToken.substring(0, 20)}...',
      name: 'ExamplePages',
    );
    print(
      '🔑 [CustomServiceExample] Using access token: ${mapboxAccessToken.substring(0, 20)}...',
    );
  }

  Future<void> _searchPlaces() async {
    if (_searchController.text.isEmpty) return;

    developer.log(
      '🔍 Searching for: "${_searchController.text}"',
      name: 'CustomServiceExample',
    );
    print(
      '🔍 [CustomServiceExample] Searching for: "${_searchController.text}"',
    );
    developer.log(
      '🔑 Using access token: ${mapboxAccessToken.substring(0, 20)}...',
      name: 'CustomServiceExample',
    );
    print(
      '🔑 [CustomServiceExample] Using access token: ${mapboxAccessToken.substring(0, 20)}...',
    );
    developer.log(
      '📡 Making API request with parameters:',
      name: 'CustomServiceExample',
    );
    print('📡 [CustomServiceExample] Making API request with parameters:');
    developer.log(
      '   Query: ${_searchController.text}',
      name: 'CustomServiceExample',
    );
    print('   Query: ${_searchController.text}');
    developer.log('   Limit: 10', name: 'CustomServiceExample');
    print('   Limit: 10');
    developer.log('   Types: [place, poi]', name: 'CustomServiceExample');
    print('   Types: [place, poi]');
    developer.log('   Country: [ug]', name: 'CustomServiceExample');
    print('   Country: [ug]');

    setState(() {
      isLoading = true;
      searchResults.clear();
    });

    try {
      developer.log('📡 Calling Mapbox API...', name: 'CustomServiceExample');
      print('📡 [CustomServiceExample] Calling Mapbox API...');
      final results = await _geocodingService.searchPlaces(
        query: _searchController.text,
        limit: 10,
        types: ['place', 'poi'],
        country: ['ug'], // Limit to US for this example
      );

      developer.log(
        '✅ API response received: ${results.length} results',
        name: 'CustomServiceExample',
      );
      print(
        '✅ [CustomServiceExample] API response received: ${results.length} results',
      );
      for (int i = 0; i < results.length; i++) {
        final place = results[i];
        developer.log(
          '📍 Result $i: ${place.text} - ${place.placeName}',
          name: 'CustomServiceExample',
        );
        print(
          '📍 [CustomServiceExample] Result $i: ${place.text} - ${place.placeName}',
        );
        developer.log(
          '   Coordinates: ${place.latitude}, ${place.longitude}',
          name: 'CustomServiceExample',
        );
        print('   Coordinates: ${place.latitude}, ${place.longitude}');
        developer.log(
          '   Type: ${place.placeType}, Relevance: ${place.relevance}',
          name: 'CustomServiceExample',
        );
        print('   Type: ${place.placeType}, Relevance: ${place.relevance}');
      }

      setState(() {
        searchResults = results;
      });
    } catch (e) {
      developer.log('❌ API Error: $e', name: 'CustomServiceExample');
      print('❌ [CustomServiceExample] API Error: $e');
      developer.log(
        '❌ Error type: ${e.runtimeType}',
        name: 'CustomServiceExample',
      );
      print('❌ [CustomServiceExample] Error type: ${e.runtimeType}');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _reverseGeocode() async {
    final lat = double.tryParse(_latController.text);
    final lng = double.tryParse(_lngController.text);

    if (lat == null || lng == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid coordinates')),
      );
      return;
    }

    developer.log(
      '🔄 Reverse geocoding for coordinates: $lat, $lng',
      name: 'CustomServiceExample',
    );
    print(
      '🔄 [CustomServiceExample] Reverse geocoding for coordinates: $lat, $lng',
    );
    developer.log(
      '🔑 Using access token: ${mapboxAccessToken.substring(0, 20)}...',
      name: 'CustomServiceExample',
    );
    print(
      '🔑 [CustomServiceExample] Using access token: ${mapboxAccessToken.substring(0, 20)}...',
    );

    setState(() {
      isLoading = true;
      reverseResults.clear();
    });

    try {
      developer.log(
        '📡 Calling Mapbox reverse geocoding API...',
        name: 'CustomServiceExample',
      );
      print(
        '📡 [CustomServiceExample] Calling Mapbox reverse geocoding API...',
      );
      final results = await _geocodingService.reverseGeocode(
        longitude: lng,
        latitude: lat,
        types: ['place', 'poi', 'address'],
      );

      developer.log(
        '✅ Reverse geocoding response: ${results.length} results',
        name: 'CustomServiceExample',
      );
      print(
        '✅ [CustomServiceExample] Reverse geocoding response: ${results.length} results',
      );
      for (int i = 0; i < results.length; i++) {
        final place = results[i];
        developer.log(
          '📍 Result $i: ${place.text} - ${place.placeName}',
          name: 'CustomServiceExample',
        );
        print(
          '📍 [CustomServiceExample] Result $i: ${place.text} - ${place.placeName}',
        );
        developer.log(
          '   Type: ${place.placeType}, Relevance: ${place.relevance}',
          name: 'CustomServiceExample',
        );
        print('   Type: ${place.placeType}, Relevance: ${place.relevance}');
      }

      setState(() {
        reverseResults = results;
      });
    } catch (e) {
      developer.log(
        '❌ Reverse geocoding error: $e',
        name: 'CustomServiceExample',
      );
      print('❌ [CustomServiceExample] Reverse geocoding error: $e');
      developer.log(
        '❌ Error type: ${e.runtimeType}',
        name: 'CustomServiceExample',
      );
      print('❌ [CustomServiceExample] Error type: ${e.runtimeType}');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Service Usage'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Forward Geocoding
            const Text(
              'Forward Geocoding (Search):',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Enter place name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _searchPlaces,
                  child: const Text('Search'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Reverse Geocoding
            const Text(
              'Reverse Geocoding (Coordinates):',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _latController,
                    decoration: const InputDecoration(
                      hintText: 'Latitude',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _lngController,
                    decoration: const InputDecoration(
                      hintText: 'Longitude',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _reverseGeocode,
                  child: const Text('Reverse'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Results
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (searchResults.isNotEmpty) ...[
                          Text(
                            'Search Results (${searchResults.length}):',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: ListView.builder(
                              itemCount: searchResults.length,
                              itemBuilder: (context, index) {
                                final place = searchResults[index];
                                return Card(
                                  child: ListTile(
                                    title: Text(place.text),
                                    subtitle: Text(place.placeName),
                                    trailing: Text(
                                      '${place.latitude?.toStringAsFixed(4)}, ${place.longitude?.toStringAsFixed(4)}',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],

                        if (reverseResults.isNotEmpty) ...[
                          Text(
                            'Reverse Results (${reverseResults.length}):',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: ListView.builder(
                              itemCount: reverseResults.length,
                              itemBuilder: (context, index) {
                                final place = reverseResults[index];
                                return Card(
                                  child: ListTile(
                                    title: Text(place.text),
                                    subtitle: Text(place.placeName),
                                    trailing: Text(
                                      place.placeType,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],

                        if (searchResults.isEmpty &&
                            reverseResults.isEmpty &&
                            !isLoading)
                          const Expanded(
                            child: Center(
                              child: Text(
                                'No results yet.\nTry searching or reverse geocoding.',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// Example 4: Advanced Features
class AdvancedExample extends StatefulWidget {
  const AdvancedExample({super.key});

  @override
  State<AdvancedExample> createState() => _AdvancedExampleState();
}

class _AdvancedExampleState extends State<AdvancedExample> {
  final MapboxGeocodingService _geocodingService = MapboxGeocodingService(
    accessToken: mapboxAccessToken,
  );
  final TextEditingController _searchController = TextEditingController();

  List<Place> searchResults = [];
  bool isLoading = false;

  // Advanced parameters
  int maxResults = 5;
  List<String> selectedTypes = ['place'];
  List<String> selectedCountries = [];
  List<double>? proximityCoords;
  List<double>? boundingBox;

  final List<String> availableTypes = [
    'country',
    'region',
    'postcode',
    'district',
    'place',
    'locality',
    'neighborhood',
    'address',
    'poi',
  ];

  final List<String> availableCountries = [
    'us',
    'ca',
    'gb',
    'fr',
    'de',
    'it',
    'es',
    'jp',
    'au',
    'br',
  ];

  @override
  void initState() {
    super.initState();
    developer.log(
      '🏠 [AdvancedExample] Page initialized',
      name: 'ExamplePages',
    );
    print('🏠 [AdvancedExample] Page initialized');
    developer.log(
      '🔑 [AdvancedExample] Using access token: ${mapboxAccessToken.substring(0, 20)}...',
      name: 'ExamplePages',
    );
    print(
      '🔑 [AdvancedExample] Using access token: ${mapboxAccessToken.substring(0, 20)}...',
    );
  }

  Future<void> _advancedSearch() async {
    if (_searchController.text.isEmpty) return;

    developer.log(
      '🔍 Advanced search for: "${_searchController.text}"',
      name: 'AdvancedExample',
    );
    print(
      '🔍 [AdvancedExample] Advanced search for: "${_searchController.text}"',
    );
    developer.log(
      '🔑 Using access token: ${mapboxAccessToken.substring(0, 20)}...',
      name: 'AdvancedExample',
    );
    print(
      '🔑 [AdvancedExample] Using access token: ${mapboxAccessToken.substring(0, 20)}...',
    );
    developer.log('📡 Advanced search parameters:', name: 'AdvancedExample');
    print('📡 [AdvancedExample] Advanced search parameters:');
    developer.log(
      '   Query: ${_searchController.text}',
      name: 'AdvancedExample',
    );
    print('   Query: ${_searchController.text}');
    developer.log('   Max Results: $maxResults', name: 'AdvancedExample');
    print('   Max Results: $maxResults');
    developer.log('   Types: $selectedTypes', name: 'AdvancedExample');
    print('   Types: $selectedTypes');
    developer.log('   Countries: $selectedCountries', name: 'AdvancedExample');
    print('   Countries: $selectedCountries');
    developer.log('   Proximity: $proximityCoords', name: 'AdvancedExample');
    print('   Proximity: $proximityCoords');
    developer.log('   Bounding Box: $boundingBox', name: 'AdvancedExample');
    print('   Bounding Box: $boundingBox');

    setState(() {
      isLoading = true;
      searchResults.clear();
    });

    try {
      developer.log(
        '📡 Calling Mapbox API with advanced parameters...',
        name: 'AdvancedExample',
      );
      print(
        '📡 [AdvancedExample] Calling Mapbox API with advanced parameters...',
      );
      final results = await _geocodingService.searchPlaces(
        query: _searchController.text,
        limit: maxResults,
        types: selectedTypes.isNotEmpty ? selectedTypes : null,
        country: selectedCountries.isNotEmpty ? selectedCountries : null,
        proximity: proximityCoords,
        bbox: boundingBox,
      );

      developer.log(
        '✅ Advanced search response: ${results.length} results',
        name: 'AdvancedExample',
      );
      print(
        '✅ [AdvancedExample] Advanced search response: ${results.length} results',
      );
      for (int i = 0; i < results.length; i++) {
        final place = results[i];
        developer.log(
          '📍 Result $i: ${place.text} - ${place.placeName}',
          name: 'AdvancedExample',
        );
        print(
          '📍 [AdvancedExample] Result $i: ${place.text} - ${place.placeName}',
        );
        developer.log(
          '   Coordinates: ${place.latitude}, ${place.longitude}',
          name: 'AdvancedExample',
        );
        print('   Coordinates: ${place.latitude}, ${place.longitude}');
        developer.log(
          '   Type: ${place.placeType}, Relevance: ${place.relevance}',
          name: 'AdvancedExample',
        );
        print('   Type: ${place.placeType}, Relevance: ${place.relevance}');
      }

      setState(() {
        searchResults = results;
      });
    } catch (e) {
      developer.log('❌ Advanced search error: $e', name: 'AdvancedExample');
      print('❌ [AdvancedExample] Advanced search error: $e');
      developer.log('❌ Error type: ${e.runtimeType}', name: 'AdvancedExample');
      print('❌ [AdvancedExample] Error type: ${e.runtimeType}');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Features'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Field
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Enter search query',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: _advancedSearch,
                  icon: const Icon(Icons.search),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Advanced Parameters
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Max Results
                    const Text(
                      'Max Results:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Slider(
                      value: maxResults.toDouble(),
                      min: 1,
                      max: 10,
                      divisions: 9,
                      label: maxResults.toString(),
                      onChanged: (value) {
                        setState(() {
                          maxResults = value.round();
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    // Place Types
                    const Text(
                      'Place Types:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Wrap(
                      spacing: 8,
                      children: availableTypes.map((type) {
                        return FilterChip(
                          label: Text(type),
                          selected: selectedTypes.contains(type),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedTypes.add(type);
                              } else {
                                selectedTypes.remove(type);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 16),

                    // Countries
                    const Text(
                      'Countries:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Wrap(
                      spacing: 8,
                      children: availableCountries.map((country) {
                        return FilterChip(
                          label: Text(country.toUpperCase()),
                          selected: selectedCountries.contains(country),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedCountries.add(country);
                              } else {
                                selectedCountries.remove(country);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 16),

                    // Action Buttons
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: _advancedSearch,
                          child: const Text('Advanced Search'),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: () {
                            setState(() {
                              selectedTypes.clear();
                              selectedCountries.clear();
                              proximityCoords = null;
                              boundingBox = null;
                              maxResults = 5;
                            });
                          },
                          child: const Text('Reset'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Results
                    if (isLoading)
                      const Center(child: CircularProgressIndicator())
                    else if (searchResults.isNotEmpty) ...[
                      Text(
                        'Results (${searchResults.length}):',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      for (final place in searchResults)
                        Card(
                          child: ListTile(
                            title: Text(place.text),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(place.placeName),
                                Text(
                                  'Type: ${place.placeType} | Relevance: ${place.relevance.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            trailing:
                                place.latitude != null &&
                                    place.longitude != null
                                ? Text(
                                    '${place.latitude!.toStringAsFixed(4)}\n${place.longitude!.toStringAsFixed(4)}',
                                    style: const TextStyle(fontSize: 10),
                                    textAlign: TextAlign.center,
                                  )
                                : null,
                          ),
                        ),
                    ] else if (_searchController.text.isNotEmpty && !isLoading)
                      const Center(
                        child: Text(
                          'No results found. Try adjusting your search parameters.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
