import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer' as developer;
import '../models/place.dart';
import '../services/mapbox_geocoding_service.dart';

class PlaceSearchField extends StatefulWidget {
  final String accessToken;
  final String? hintText;
  final Color? fillColor;
  final Function(Place)? onPlaceSelected;
  final int maxResults;

  const PlaceSearchField({
    super.key,
    required this.accessToken,
    this.hintText,
    this.fillColor;
    this.onPlaceSelected,
    this.maxResults = 5,
  });

  @override
  State<PlaceSearchField> createState() => _PlaceSearchFieldState();
}

class _PlaceSearchFieldState extends State<PlaceSearchField> {
  late MapboxGeocodingService _geocodingService;
  final TextEditingController _controller = TextEditingController();
  List<Place> _searchResults = [];
  bool _isLoading = false;
  bool _showResults = false;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _geocodingService = MapboxGeocodingService(accessToken: widget.accessToken);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _searchPlaces(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _showResults = false;
      });
      return;
    }

    developer.log(
      '🔍 [PlaceSearchField] Searching for: "$query"',
      name: 'PlaceSearchWidget',
    );
    print('🔍 [PlaceSearchField] Searching for: "$query"');
    developer.log(
      '🔢 [PlaceSearchField] Max results: ${widget.maxResults}',
      name: 'PlaceSearchWidget',
    );
    print('🔢 [PlaceSearchField] Max results: ${widget.maxResults}');

    setState(() {
      _isLoading = true;
    });

    try {
      developer.log(
        '📡 [PlaceSearchField] Calling MapboxGeocodingService.searchPlaces...',
        name: 'PlaceSearchWidget',
      );
      print(
        '📡 [PlaceSearchField] Calling MapboxGeocodingService.searchPlaces...',
      );
      final results = await _geocodingService.searchPlaces(
        query: query,
        limit: widget.maxResults,
      );

      developer.log(
        '✅ [PlaceSearchField] Search completed successfully',
        name: 'PlaceSearchWidget',
      );
      print('✅ [PlaceSearchField] Search completed successfully');
      developer.log(
        '📍 [PlaceSearchField] Found ${results.length} results',
        name: 'PlaceSearchWidget',
      );
      print('📍 [PlaceSearchField] Found ${results.length} results');

      if (mounted) {
        setState(() {
          _searchResults = results;
          _showResults = results.isNotEmpty;
          _isLoading = false;
        });
      }
    } catch (e) {
      developer.log(
        '❌ [PlaceSearchField] Search failed: $e',
        name: 'PlaceSearchWidget',
      );
      print('❌ [PlaceSearchField] Search failed: $e');
      developer.log(
        '❌ [PlaceSearchField] Error type: ${e.runtimeType}',
        name: 'PlaceSearchWidget',
      );
      print('❌ [PlaceSearchField] Error type: ${e.runtimeType}');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _onTextChanged(String value) {
    developer.log(
      '⌨️ [PlaceSearchField] Text changed: "$value"',
      name: 'PlaceSearchWidget',
    );
    print('⌨️ [PlaceSearchField] Text changed: "$value"');
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      developer.log(
        '⏰ [PlaceSearchField] Debounce timer triggered, searching for: "$value"',
        name: 'PlaceSearchWidget',
      );
      print(
        '⏰ [PlaceSearchField] Debounce timer triggered, searching for: "$value"',
      );
      _searchPlaces(value);
    });
  }

  void _onPlaceSelected(Place place) {
    developer.log(
      '🎯 [PlaceSearchField] Place selected: ${place.text}',
      name: 'PlaceSearchWidget',
    );
    print('🎯 [PlaceSearchField] Place selected: ${place.text}');
    developer.log(
      '📍 [PlaceSearchField] Coordinates: ${place.latitude}, ${place.longitude}',
      name: 'PlaceSearchWidget',
    );
    print(
      '📍 [PlaceSearchField] Coordinates: ${place.latitude}, ${place.longitude}',
    );
    developer.log(
      '🏷️ [PlaceSearchField] Type: ${place.placeType}',
      name: 'PlaceSearchWidget',
    );
    print('🏷️ [PlaceSearchField] Type: ${place.placeType}');

    _controller.text = place.placeName;
    setState(() {
      _showResults = false;
    });
    widget.onPlaceSelected?.call(place);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          onChanged: _onTextChanged,
          decoration: InputDecoration(
            hintText: widget.hintText ?? 'Search for a place',
            fillColor:  widget.fillColor,
            suffixIcon: _isLoading ? const CircularProgressIndicator() : null,
            border: const OutlineInputBorder(),
          ),
        ),
        if (_showResults && _searchResults.isNotEmpty)
          Container(
            constraints: const BoxConstraints(maxHeight: 300),
            child: ListView.builder(
              shrinkWrap: true,
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
    );
  }
}
