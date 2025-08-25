import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import '../models/place.dart';
import '../services/mapbox_geocoding_service.dart';

class PlaceSearchDialog extends StatefulWidget {
  final String accessToken;
  final String title;
  final String? hintText;
  final Function(Place) onPlaceSelected;

  const PlaceSearchDialog({
    super.key,
    required this.accessToken,
    this.title = 'Search Places',
    this.hintText,
    required this.onPlaceSelected,
  });

  @override
  State<PlaceSearchDialog> createState() => _PlaceSearchDialogState();
}

class _PlaceSearchDialogState extends State<PlaceSearchDialog> {
  late MapboxGeocodingService _geocodingService;
  final TextEditingController _controller = TextEditingController();
  List<Place> _searchResults = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _geocodingService = MapboxGeocodingService(accessToken: widget.accessToken);
  }

  Future<void> _searchPlaces(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    developer.log(
      '🔍 [PlaceSearchDialog] Searching for: "$query"',
      name: 'PlaceSearchDialog',
    );
    print('🔍 [PlaceSearchDialog] Searching for: "$query"');
    developer.log(
      '🔢 [PlaceSearchDialog] Max results: 10',
      name: 'PlaceSearchDialog',
    );
    print('🔢 [PlaceSearchDialog] Max results: 10');

    setState(() {
      _isLoading = true;
    });

    try {
      developer.log(
        '📡 [PlaceSearchDialog] Calling MapboxGeocodingService.searchPlaces...',
        name: 'PlaceSearchDialog',
      );
      print(
        '📡 [PlaceSearchDialog] Calling MapboxGeocodingService.searchPlaces...',
      );
      final results = await _geocodingService.searchPlaces(
        query: query,
        limit: 10,
      );

      developer.log(
        '✅ [PlaceSearchDialog] Search completed successfully',
        name: 'PlaceSearchDialog',
      );
      print('✅ [PlaceSearchDialog] Search completed successfully');
      developer.log(
        '📍 [PlaceSearchDialog] Found ${results.length} results',
        name: 'PlaceSearchDialog',
      );
      print('📍 [PlaceSearchDialog] Found ${results.length} results');

      if (mounted) {
        setState(() {
          _searchResults = results;
          _isLoading = false;
        });
      }
    } catch (e) {
      developer.log(
        '❌ [PlaceSearchDialog] Search failed: $e',
        name: 'PlaceSearchDialog',
      );
      print('❌ [PlaceSearchDialog] Search failed: $e');
      developer.log(
        '❌ [PlaceSearchDialog] Error type: ${e.runtimeType}',
        name: 'PlaceSearchDialog',
      );
      print('❌ [PlaceSearchDialog] Error type: ${e.runtimeType}');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _onPlaceSelected(Place place) {
    developer.log(
      '🎯 [PlaceSearchDialog] Place selected: ${place.text}',
      name: 'PlaceSearchDialog',
    );
    print('🎯 [PlaceSearchDialog] Place selected: ${place.text}');
    developer.log(
      '📍 [PlaceSearchDialog] Coordinates: ${place.latitude}, ${place.longitude}',
      name: 'PlaceSearchDialog',
    );
    print(
      '📍 [PlaceSearchDialog] Coordinates: ${place.latitude}, ${place.longitude}',
    );
    developer.log(
      '🏷️ [PlaceSearchDialog] Type: ${place.placeType}',
      name: 'PlaceSearchDialog',
    );
    print('🏷️ [PlaceSearchDialog] Type: ${place.placeType}');

    widget.onPlaceSelected(place);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              onChanged: _searchPlaces,
              decoration: InputDecoration(
                hintText: widget.hintText ?? 'Search for a place...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _isLoading
                    ? const CircularProgressIndicator()
                    : null,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _searchResults.isEmpty
                  ? const Center(child: Text('No places found'))
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final place = _searchResults[index];
                        return ListTile(
                          title: Text(place.text),
                          subtitle: Text(place.placeName),
                          onTap: () => _onPlaceSelected(place),
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
