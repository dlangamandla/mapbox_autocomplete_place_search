# Mapbox Autocomplete Place Search Example

This example app demonstrates the comprehensive usage of the `mapbox_autocomplete_place_search` plugin. The app showcases different ways to integrate Mapbox place search functionality into your Flutter application.

## 🚀 Getting Started

### Prerequisites

1. **Mapbox Access Token**: You'll need a free Mapbox account and access token.
   - Sign up at [https://account.mapbox.com/](https://account.mapbox.com/)
   - Create a new access token with the necessary permissions
   - The token should have at least these scopes:
     - Geocoding API
     - Search API

### Setup

1. **Clone the repository** (if you haven't already):
   ```bash
   git clone <repository-url>
   cd mapbox_autocomplete_place_search/example
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Add your Mapbox access token**:
   - Open `lib/main.dart`
   - Replace `YOUR_MAPBOX_ACCESS_TOKEN_HERE` with your actual Mapbox access token:
   ```dart
   static const String mapboxAccessToken = 'pk.eyJ1IjoieW91ci11c2VybmFtZSI...';
   ```

4. **Run the app**:
   ```bash
   flutter run
   ```

## 📱 Examples Included

### 1. Basic Place Search Field
**File**: `BasicSearchExample` in `main.dart`

Demonstrates the simplest usage of the `PlaceSearchField` widget:
- Basic autocomplete functionality
- Place selection callback
- Display of selected place information
- Coordinate extraction (latitude/longitude)

```dart
PlaceSearchField(
  accessToken: mapboxAccessToken,
  hintText: 'Search for a place...',
  maxResults: 5,
  onPlaceSelected: (place) {
    // Handle place selection
    print('Selected: ${place.placeName}');
  },
)
```

### 2. Place Search Dialog
**File**: `DialogSearchExample` in `main.dart`

Shows how to use the `PlaceSearchDialog` for full-screen search:
- Modal dialog interface
- Multiple place selection
- List management with add/remove functionality
- Dialog customization options

```dart
showDialog(
  context: context,
  builder: (context) => PlaceSearchDialog(
    accessToken: mapboxAccessToken,
    title: 'Search for Places',
    hintText: 'Enter place name...',
    onPlaceSelected: (place) {
      // Handle place selection
    },
  ),
);
```

### 3. Custom Service Usage
**File**: `CustomServiceExample` in `main.dart`

Demonstrates direct usage of the `MapboxGeocodingService`:
- Forward geocoding (place name → coordinates)
- Reverse geocoding (coordinates → place info)
- Custom search parameters
- Error handling
- Loading states

```dart
final service = MapboxGeocodingService(accessToken: mapboxAccessToken);

// Forward geocoding
final places = await service.searchPlaces(
  query: 'Kampala',
  limit: 10,
  types: ['place', 'poi'],
  country: ['ug'],
);

// Reverse geocoding
final results = await service.reverseGeocode(
  longitude: -74.006,
  latitude: 40.7128,
);
```

### 4. Advanced Features
**File**: `AdvancedExample` in `main.dart`

Showcases advanced search capabilities:
- Filtering by place types (country, region, city, POI, etc.)
- Country restrictions
- Result limit customization
- Proximity biasing
- Bounding box limitations
- Real-time parameter adjustment

## 🛠 API Features Demonstrated

### Place Search Parameters
- **Query**: Text search input
- **Limit**: Maximum number of results (1-10)
- **Types**: Filter by place types:
  - `country` - Countries
  - `region` - States/provinces
  - `postcode` - Postal codes
  - `district` - Districts/counties
  - `place` - Cities/towns
  - `locality` - Villages/suburbs
  - `neighborhood` - Neighborhoods
  - `address` - Street addresses
  - `poi` - Points of interest

- **Country**: Limit results to specific countries (ISO 3166-1 alpha-2 codes)
- **Proximity**: Bias results toward a specific location [longitude, latitude]
- **Bbox**: Limit results to a bounding box [minLon, minLat, maxLon, maxLat]

### Place Information Available
Each `Place` object contains:
- **Basic Info**: `id`, `text`, `placeName`, `placeType`
- **Coordinates**: `latitude`, `longitude`, `center`
- **Geometry**: Full geometry data
- **Properties**: Additional metadata (wikidata, category, etc.)
- **Context**: Hierarchical place information
- **Relevance**: Search relevance score (0.0 - 1.0)

## 🎨 UI Components

### PlaceSearchField
A drop-in autocomplete text field widget:
- Real-time search as you type
- Debounced API calls for performance
- Customizable appearance
- Loading indicators
- Results dropdown

### PlaceSearchDialog
A full-screen search interface:
- Modal presentation
- Search input with instant results
- List-based result selection
- Customizable title and hints

### MapboxGeocodingService
Direct API service for custom implementations:
- Full control over API parameters
- Async/await support
- Comprehensive error handling
- Support for all Mapbox Geocoding API features

## 🔧 Customization

### Styling
All widgets respect your app's theme:
```dart
Theme(
  data: ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
  ),
  child: PlaceSearchField(...),
)
```

### Error Handling
Implement proper error handling for production apps:
```dart
try {
  final results = await service.searchPlaces(query: query);
  // Handle success
} catch (e) {
  // Handle errors (network, API limits, invalid tokens, etc.)
  print('Error: $e');
}
```

### Rate Limiting
Mapbox has usage limits based on your account tier:
- Free tier: 100,000 requests/month
- Monitor usage in your Mapbox account dashboard
- Implement client-side debouncing (already included in widgets)

## 📱 Platform Support

This plugin supports:
- ✅ iOS
- ✅ Android
- ✅ Web
- ✅ macOS
- ✅ Windows
- ✅ Linux

## 🚨 Important Notes

1. **API Key Security**: Never commit your actual API key to version control. Use environment variables or secure configuration management in production.

2. **Network Permissions**: Ensure your app has internet permissions:
   - Android: Usually included by default
   - iOS: Add network usage description if needed

3. **Error Handling**: Always implement proper error handling for network requests and API limits.

4. **Performance**: The widgets include built-in debouncing, but consider additional optimizations for high-frequency usage.

## 📚 Additional Resources

- [Mapbox Geocoding API Documentation](https://docs.mapbox.com/api/search/geocoding/)
- [Mapbox Account Dashboard](https://account.mapbox.com/)
- [Flutter HTTP Package](https://pub.dev/packages/http)
- [Plugin Repository](https://github.com/yourusername/mapbox_autocomplete_place_search)

## 🐛 Troubleshooting

### Common Issues

1. **"Invalid access token"**
   - Verify your token is correct and active
   - Check token permissions in Mapbox account

2. **"No results found"**
   - Check internet connectivity
   - Verify search query format
   - Review API usage limits

3. **Build errors**
   - Run `flutter clean && flutter pub get`
   - Check Flutter and Dart SDK versions

4. **Network errors**
   - Check device/emulator internet connection
   - Verify firewall settings
   - Test API directly with curl/Postman

### Debug Mode
Enable verbose logging to debug issues:
```dart
// Add this to see detailed API responses
debugPrint('Search query: $query');
debugPrint('API response: ${response.body}');
```

## 📄 License

This example is part of the mapbox_autocomplete_place_search plugin and follows the same license terms.
