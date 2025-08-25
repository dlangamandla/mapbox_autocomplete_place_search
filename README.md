# Mapbox Autocomplete Place Search

A Flutter package for Mapbox place search with autocomplete functionality, featuring flexible JSON parsing, comprehensive error handling, and easy-to-use widgets for place search and selection.

## Features

✨ **Easy-to-use widgets** - Drop-in place search fields and dialogs  
🔍 **Autocomplete search** - Real-time search suggestions as you type  
🌍 **Flexible filtering** - Filter by place types, countries, and proximity  
🛡️ **Robust error handling** - Comprehensive error handling and logging  
📱 **Mobile optimized** - Built specifically for Flutter mobile apps  
🔧 **Customizable** - Extensive configuration options for different use cases  

## Getting started

### Prerequisites

1. **Mapbox Account**: Sign up at [Mapbox](https://account.mapbox.com/) to get an access token
2. **Flutter SDK**: Ensure you have Flutter 3.0.0 or higher installed

### Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  mapbox_autocomplete_place_search: ^1.0.0
```

### Setup

1. **Get your Mapbox access token** from [Mapbox Account](https://account.mapbox.com/access-tokens/)
2. **Use a PUBLIC token (pk.)** - not a secret key (sk.) for client-side operations
3. **Configure your token** in your app

## Usage

### Basic Place Search Field

```dart
import 'package:mapbox_autocomplete_place_search/mapbox_autocomplete_place_search.dart';

PlaceSearchField(
  accessToken: 'your_mapbox_access_token_here',
  hintText: 'Search for a place...',
  maxResults: 5,
  onPlaceSelected: (place) {
    print('Selected: ${place.text} at ${place.latitude}, ${place.longitude}');
  },
)
```

### Place Search Dialog

```dart
showDialog(
  context: context,
  builder: (context) => PlaceSearchDialog(
    accessToken: 'your_mapbox_access_token_here',
    title: 'Search for Places',
    hintText: 'Enter place name...',
    onPlaceSelected: (place) {
      print('Selected: ${place.text}');
      Navigator.of(context).pop();
    },
  ),
);
```

### Advanced Search with Filtering

```dart
final geocodingService = MapboxGeocodingService(
  accessToken: 'your_mapbox_access_token_here',
);

final results = await geocodingService.searchPlaces(
  query: 'New York',
  limit: 10,
  types: ['place', 'locality', 'neighborhood'],
  country: ['us'],
  proximity: [-74.006, 40.7128], // NYC coordinates
);
```

### Available Place Types

- `country` - Countries
- `region` - States/provinces  
- `postcode` - ZIP codes
- `district` - Districts
- `place` - Cities/towns
- `locality` - Localities
- `neighborhood` - Neighborhoods
- `address` - Street addresses
- `poi` - Points of interest

## API Reference

### PlaceSearchField

A text field with built-in autocomplete place search.

**Properties:**
- `accessToken` - Your Mapbox access token (required)
- `hintText` - Placeholder text for the search field
- `maxResults` - Maximum number of search results to show
- `onPlaceSelected` - Callback when a place is selected

### PlaceSearchDialog

A full-screen dialog for place search.

**Properties:**
- `accessToken` - Your Mapbox access token (required)
- `title` - Dialog title
- `hintText` - Placeholder text for the search field
- `onPlaceSelected` - Callback when a place is selected

### MapboxGeocodingService

Direct API service for custom implementations.

**Methods:**
- `searchPlaces()` - Search for places by query
- `reverseGeocode()` - Get place details from coordinates
- `getPlaceDetails()` - Get details for a specific place ID

### Place Model

Represents a place returned from the API.

**Properties:**
- `id` - Unique identifier
- `text` - Display text
- `placeName` - Full place name
- `latitude` / `longitude` - Coordinates
- `placeType` - Type of place
- `relevance` - Search relevance score

## Error Handling

The package includes comprehensive error handling:

- **API Errors**: Proper HTTP status code handling
- **Parsing Errors**: Robust JSON parsing with fallbacks
- **Network Errors**: Graceful handling of connection issues
- **Debug Logging**: Extensive logging for troubleshooting

## Debug Logging

Enable detailed logging to troubleshoot issues:

```dart
// Console output shows:
// 🔍 Starting place search
// 📡 API request details
// ✅ Response received
// 📍 Results found
// ❌ Any errors that occur
```

## Example

See the `/example` folder for a complete working example with multiple search implementations.

## Additional information

### Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### Issues

If you encounter any issues, please file them at the [GitHub repository](https://github.com/yourusername/mapbox_autocomplete_place_search/issues).

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### Dependencies

- `http` - For API calls to Mapbox
- `json_annotation` - For JSON serialization
- `json_serializable` - For code generation

### Mapbox API

This package uses the [Mapbox Geocoding API](https://docs.mapbox.com/api/search/geocoding/). Please refer to their documentation for API limits and usage guidelines.
