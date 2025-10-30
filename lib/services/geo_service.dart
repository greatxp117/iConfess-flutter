import 'dart:convert';
import 'package:http/http.dart' as http;

class PlaceSuggestion {
  final String displayName;
  final double lat;
  final double lon;
  PlaceSuggestion({required this.displayName, required this.lat, required this.lon});
}

class ChurchResult {
  final String name;
  final String address;
  final double lat;
  final double lon;
  ChurchResult({required this.name, required this.address, required this.lat, required this.lon});
}

class GeoService {
  static const _nominatimBase = 'https://nominatim.openstreetmap.org/search';
  static const _overpassUrl = 'https://overpass-api.de/api/interpreter';

  static Future<List<PlaceSuggestion>> searchPlaces(String query, {int limit = 6}) async {
    if (query.trim().isEmpty) return [];
    final uri = Uri.parse(_nominatimBase).replace(queryParameters: {
      'q': query,
      'format': 'json',
      'limit': '$limit',
      'addressdetails': '0',
    });
    final res = await http.get(
      uri,
      headers: {
        'User-Agent': 'iConfess/1.0 (dreamflow.app)',
      },
    );
    if (res.statusCode != 200) return [];
    final data = jsonDecode(res.body) as List<dynamic>;
    return data.map((e) {
      final lat = double.tryParse(e['lat']?.toString() ?? '') ?? 0;
      final lon = double.tryParse(e['lon']?.toString() ?? '') ?? 0;
      final name = e['display_name']?.toString() ?? 'Unknown';
      return PlaceSuggestion(displayName: name, lat: lat, lon: lon);
    }).toList();
  }

  static Future<List<ChurchResult>> fetchNearbyChurches({
    required double lat,
    required double lon,
    int radiusMeters = 5000,
    int limit = 40,
  }) async {
    final q = '''[out:json][timeout:25];
(
  node["amenity"="place_of_worship"]["religion"="christian"]["denomination"~"catholic|roman_catholic", i](around:$radiusMeters,$lat,$lon);
  way["amenity"="place_of_worship"]["religion"="christian"]["denomination"~"catholic|roman_catholic", i](around:$radiusMeters,$lat,$lon);
  relation["amenity"="place_of_worship"]["religion"="christian"]["denomination"~"catholic|roman_catholic", i](around:$radiusMeters,$lat,$lon);
);
out center $limit;''';
    final res = await http.post(
      Uri.parse(_overpassUrl),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'User-Agent': 'iConfess/1.0 (dreamflow.app)',
      },
      body: {
        'data': q,
      },
    );
    if (res.statusCode != 200) {
      return [];
    }
    final json = jsonDecode(res.body) as Map<String, dynamic>;
    final elements = (json['elements'] as List?) ?? [];
    final results = <ChurchResult>[];
    for (final el in elements) {
      final tags = (el['tags'] as Map?)?.cast<String, dynamic>() ?? {};
      final name = (tags['name']?.toString() ?? '').trim();
      if (name.isEmpty) continue;
      double? latEl;
      double? lonEl;
      if (el['type'] == 'node') {
        latEl = (el['lat'] as num?)?.toDouble();
        lonEl = (el['lon'] as num?)?.toDouble();
      } else {
        final center = el['center'] as Map?;
        latEl = (center?['lat'] as num?)?.toDouble();
        lonEl = (center?['lon'] as num?)?.toDouble();
      }
      if (latEl == null || lonEl == null) continue;
      final address = _formatAddress(tags);
      results.add(ChurchResult(name: name, address: address, lat: latEl, lon: lonEl));
    }
    return results;
  }

  static String _formatAddress(Map<String, dynamic> tags) {
    final parts = <String>[];
    void add(String? s) {
      if (s != null && s.trim().isNotEmpty) parts.add(s.trim());
    }
    add(tags['addr:housenumber']?.toString());
    add(tags['addr:street']?.toString());
    final line1 = parts.join(' ');
    final parts2 = <String>[];
    parts2.add(tags['addr:city']?.toString() ?? tags['addr:place']?.toString() ?? '');
    parts2.add(tags['addr:state']?.toString() ?? '');
    parts2.add(tags['addr:postcode']?.toString() ?? '');
    final line2 = parts2.where((e) => e.trim().isNotEmpty).join(', ');
    final full = [line1, line2].where((e) => e.trim().isNotEmpty).join(', ');
    return full.isEmpty ? '—' : full;
  }
}
