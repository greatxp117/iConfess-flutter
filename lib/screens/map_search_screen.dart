import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/geo_service.dart';
import '../widgets/map/google_map_overlay.dart';
import '../widgets/shared/minimal_header.dart';

class MapSearchScreen extends StatefulWidget {
  const MapSearchScreen({super.key});

  @override
  State<MapSearchScreen> createState() => _MapSearchScreenState();
}

enum _SearchMode { near, search }

class _MapSearchScreenState extends State<MapSearchScreen> {
  Position? _devicePosition;
  String _status = '';
  _SearchMode _mode = _SearchMode.near;

  // Origin used for distance and nearby fetch (could be device or searched)
  double? _originLat;
  double? _originLon;
  String? _originLabel;

  // Search UI
  final TextEditingController _searchCtl = TextEditingController();
  Timer? _debounce;
  bool _searchingPlaces = false;
  List<PlaceSuggestion> _suggestions = [];

  // Results
  bool _loadingResults = false;
  List<ChurchResult> _results = [];

  static const _prefModeKey = 'map_last_mode';
  static const _prefOriginKey = 'map_last_origin'; // lat,lon|label

  @override
  void initState() {
    super.initState();
    _loadPrefsThenInit();
  }

  Future<void> _loadPrefsThenInit() async {
    await _loadPrefs();
    // Start device location init regardless, to be available if user switches
    unawaited(_initDeviceLocation());
    // If we have a stored origin, fetch results. Otherwise, if mode is near, wait for device loc.
    if (_originLat != null && _originLon != null) {
      _fetchNearby();
    } else if (_mode == _SearchMode.near) {
      _status = 'Requesting location…';
      setState(() {});
    }
  }

  Future<void> _initDeviceLocation() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted && _mode == _SearchMode.near) {
          setState(() => _status = 'Location services are disabled.');
        }
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        if (mounted && _mode == _SearchMode.near) {
          setState(() => _status = 'Location permission denied.');
        }
        return;
      }

      final pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      if (!mounted) return;
      setState(() {
        _devicePosition = pos;
        if (_mode == _SearchMode.near) {
          _originLat = pos.latitude;
          _originLon = pos.longitude;
          _originLabel = 'Current location';
          _status = '';
          _persistOrigin();
          _fetchNearby();
        }
      });
    } catch (e) {
      if (mounted && _mode == _SearchMode.near) {
        setState(() => _status = 'Unable to get location.');
      }
    }
  }

  Future<void> _loadPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final modeRaw = prefs.getString(_prefModeKey);
      if (modeRaw != null) {
        _mode = _SearchMode.values.firstWhere(
          (e) => e.name == modeRaw,
          orElse: () => _SearchMode.near,
        );
      }
      final originRaw = prefs.getString(_prefOriginKey);
      if (originRaw != null) {
        final parts = originRaw.split('|');
        if (parts.length >= 2) {
          final coords = parts[0].split(',');
          if (coords.length == 2) {
            _originLat = double.tryParse(coords[0]);
            _originLon = double.tryParse(coords[1]);
            _originLabel = parts.sublist(1).join('|');
          }
        }
      }
      setState(() {});
    } catch (_) {
      // ignore
    }
  }

  Future<void> _persistMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefModeKey, _mode.name);
    } catch (_) {}
  }

  Future<void> _persistOrigin() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final label = _originLabel ?? '';
      if (_originLat != null && _originLon != null) {
        await prefs.setString(_prefOriginKey, '${_originLat},${_originLon}|$label');
      }
    } catch (_) {}
  }

  void _onModeChanged(_SearchMode newMode) {
    if (_mode == newMode) return;
    setState(() {
      _mode = newMode;
      _status = '';
    });
    _persistMode();
    if (newMode == _SearchMode.near) {
      if (_devicePosition != null) {
        setState(() {
          _originLat = _devicePosition!.latitude;
          _originLon = _devicePosition!.longitude;
          _originLabel = 'Current location';
        });
        _persistOrigin();
        _fetchNearby();
      } else {
        setState(() => _status = 'Requesting location…');
        _initDeviceLocation();
      }
    } else {
      // Search mode
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  void _onSearchChanged(String v) {
    _debounce?.cancel();
    if (v.trim().isEmpty) {
      setState(() => _suggestions = []);
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 350), () async {
      setState(() => _searchingPlaces = true);
      final res = await GeoService.searchPlaces(v.trim());
      if (!mounted) return;
      setState(() {
        _suggestions = res;
        _searchingPlaces = false;
      });
    });
  }

  Future<void> _selectSuggestion(PlaceSuggestion s) async {
    setState(() {
      _originLat = s.lat;
      _originLon = s.lon;
      _originLabel = s.displayName;
      _searchCtl.text = s.displayName;
      _suggestions = [];
    });
    await _persistOrigin();
    await _fetchNearby();
  }

  Future<void> _fetchNearby() async {
    if (_originLat == null || _originLon == null) return;
    setState(() {
      _loadingResults = true;
      _results = [];
    });
    final res = await GeoService.fetchNearbyChurches(lat: _originLat!, lon: _originLon!, radiusMeters: 6000, limit: 60);
    if (!mounted) return;
    setState(() {
      _results = res;
      _loadingResults = false;
    });
  }

  void _openMapOverlay() {
    if (_originLat == null || _originLon == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Choose an origin first (Near me or Search).')),
      );
      return;
    }
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (_) => SizedBox.expand(
        child: GoogleMapOverlay(
          originLat: _originLat!,
          originLon: _originLon!,
          originLabel: _originLabel ?? 'Origin',
          results: _results,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Column(
        children: [
          const MinimalHeader(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: ShadTabs<String>(
              value: _mode.name,
              onChanged: (v) => _onModeChanged(_SearchMode.values.firstWhere((e) => e.name == v)),
              tabBarConstraints: const BoxConstraints(maxWidth: 600),
              contentConstraints: const BoxConstraints(maxWidth: 900),
              tabs: [
                ShadTab(
                  value: _SearchMode.near.name,
                  child: Row(children: const [Icon(LucideIcons.crosshair), SizedBox(width: 8), Text('Near me')]),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_status.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: ShadAlert(
                            title: const Text('Location'),
                            description: Text(_status),
                          ),
                        ),
                      if (_originLabel != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 4),
                          child: Row(
                            children: [
                              const Icon(LucideIcons.mapPin, size: 16),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Origin: ${_originLabel!.length > 60 ? _originLabel!.substring(0, 60) + '…' : _originLabel!}',
                                  style: theme.textTheme.bodySmall,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              ShadButton.ghost(
                                onPressed: _fetchNearby,
                                child: const Text('Refresh'),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                ShadTab(
                  value: _SearchMode.search.name,
                  child: Row(children: const [Icon(LucideIcons.search), SizedBox(width: 8), Text('Search')]),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShadInput(
                        controller: _searchCtl,
                        placeholder: const Text('Enter a city, address, or landmark'),
                        leading: const Icon(LucideIcons.search),
                        onChanged: _onSearchChanged,
                      ),
                      if (_searchingPlaces)
                        const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: SizedBox(height: 2, child: LinearProgressIndicator(minHeight: 2)),
                        ),
                      if (_suggestions.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: theme.colorScheme.outlineVariant),
                          ),
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _suggestions.length,
                            separatorBuilder: (_, __) => Divider(height: 1, color: theme.dividerColor),
                            itemBuilder: (context, i) {
                              final s = _suggestions[i];
                              return InkWell(
                                onTap: () => _selectSuggestion(s),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  child: Row(
                                    children: [
                                      const Icon(LucideIcons.mapPin, size: 18),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          s.displayName,
                                          style: theme.textTheme.bodyMedium,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      if (_originLabel != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 4),
                          child: Row(
                            children: [
                              const Icon(LucideIcons.mapPin, size: 16),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Origin: ${_originLabel!.length > 60 ? _originLabel!.substring(0, 60) + '…' : _originLabel!}',
                                  style: theme.textTheme.bodySmall,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              ShadButton(
                                onPressed: _fetchNearby,
                                child: const Text('Search nearby'),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
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
            child: _loadingResults
                ? const Center(child: CircularProgressIndicator())
                : (_results.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(LucideIcons.church, size: 28),
                              const SizedBox(height: 8),
                              Text(
                                _originLat == null
                                    ? 'Choose "Near me" or search a location to see nearby churches.'
                                    : 'No Catholic churches found nearby. Try a larger radius or a different location.',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${_results.length} churches found',
                                    style: theme.textTheme.labelMedium,
                                  ),
                                ),
                                ShadButton(
                                  onPressed: _openMapOverlay,
                                  leading: const Icon(LucideIcons.map),
                                  child: const Text('Open Map'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                              itemCount: _results.length,
                              itemBuilder: (context, i) {
                                final item = _results[i];
                                final distanceKm = (_originLat == null || _originLon == null)
                                    ? null
                                    : _distanceKm(
                                        _originLat!,
                                        _originLon!,
                                        item.lat,
                                        item.lon,
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
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
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
                      )),
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

}
