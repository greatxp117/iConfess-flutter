import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MapSearchScreen extends StatefulWidget {
  const MapSearchScreen({super.key});

  @override
  State<MapSearchScreen> createState() => _MapSearchScreenState();
}

class _MapSearchScreenState extends State<MapSearchScreen> {
  Position? _position;
  String _status = 'Requesting location…';
  String _query = '';

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() => _status = 'Location services are disabled.');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        setState(() => _status = 'Location permission denied.');
        return;
      }

      final pos = await Geolocator.getCurrentPosition();
      setState(() {
        _position = pos;
        _status = '';
      });
    } catch (e) {
      setState(() => _status = 'Unable to get location.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final churches = _sampleChurches();
    final filtered = _query.isEmpty
        ? churches
        : churches
            .where((c) => c.name.toLowerCase().contains(_query.toLowerCase()))
            .toList();

    final theme = Theme.of(context);
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: ShadInput(
              placeholder: const Text('Search churches or parishes'),
              leading: const Icon(LucideIcons.search),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          if (_status.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: theme.colorScheme.outline),
                ),
                child: Row(
                  children: [
                    const Icon(LucideIcons.info, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _status,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              itemCount: filtered.length,
              itemBuilder: (context, i) {
                final item = filtered[i];
                final distanceKm = _position == null
                    ? null
                    : _distanceKm(
                        _position!.latitude,
                        _position!.longitude,
                        item.lat,
                        item.lng,
                      );
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ShadCard(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Open ${item.name}')),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey.withValues(alpha: 0.15),
                              ),
                              child: const Icon(LucideIcons.mapPin, size: 20),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: theme.textTheme.titleSmall,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item.address,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.8),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(LucideIcons.clock, size: 14),
                                      const SizedBox(width: 6),
                                      Flexible(
                                        child: Text(
                                          'Confessions: ${item.confessionTimes}',
                                          style: theme.textTheme.bodySmall,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (distanceKm != null) ...[
                              const SizedBox(width: 12),
                              Text(
                                '${distanceKm.toStringAsFixed(1)} km',
                                style: theme.textTheme.labelSmall,
                              ),
                            ],
                            const SizedBox(width: 8),
                            const Icon(LucideIcons.chevronRight, size: 18),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  double _distanceKm(double lat1, double lon1, double lat2, double lon2) {
    const double r = 6371; // km
    final dLat = _degToRad(lat2 - lat1);
    final dLon = _degToRad(lon2 - lon1);
    final a =
        math.sin(dLat / 2) * math.sin(dLat / 2) +
            math.cos(_degToRad(lat1)) *
                math.cos(_degToRad(lat2)) *
                math.sin(dLon / 2) *
                math.sin(dLon / 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return r * c;
  }

  double _degToRad(double deg) => deg * (math.pi / 180.0);

  List<_Church> _sampleChurches() {
    // Sample data around a generic location; replace with backend later
    return const [
      _Church(
        name: 'St. Mary Cathedral',
        address: '123 Main St',
        lat: 37.7793,
        lng: -122.4192,
        confessionTimes: 'Sat 3:00–4:30pm',
      ),
      _Church(
        name: 'St. Joseph Parish',
        address: '45 Oak Ave',
        lat: 37.771,
        lng: -122.431,
        confessionTimes: 'Wed 6:00–7:00pm; Sat 4:00–5:00pm',
      ),
      _Church(
        name: 'Sacred Heart Church',
        address: '200 Pine Rd',
        lat: 37.768,
        lng: -122.41,
        confessionTimes: 'Sun 8:30–9:00am',
      ),
    ];
  }
}

class _Church {
  final String name;
  final String address;
  final double lat;
  final double lng;
  final String confessionTimes;
  const _Church({
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
    required this.confessionTimes,
  });
}
