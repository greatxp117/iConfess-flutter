import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../services/geo_service.dart';

class GoogleMapOverlay extends StatefulWidget {
  final double originLat;
  final double originLon;
  final String originLabel;
  final List<ChurchResult> results;

  const GoogleMapOverlay({
    super.key,
    required this.originLat,
    required this.originLon,
    required this.originLabel,
    required this.results,
  });

  @override
  State<GoogleMapOverlay> createState() => _GoogleMapOverlayState();
}

class _GoogleMapOverlayState extends State<GoogleMapOverlay> {
  GoogleMapController? _controller;
  late final CameraPosition _initialCamera;

  @override
  void initState() {
    super.initState();
    _initialCamera = CameraPosition(
      target: LatLng(widget.originLat, widget.originLon),
      zoom: 13,
    );
  }

  Set<Marker> _buildMarkers() {
    final markers = <Marker>{};
    for (int i = 0; i < widget.results.length; i++) {
      final r = widget.results[i];
      markers.add(
        Marker(
          markerId: MarkerId('church_$i'),
          position: LatLng(r.lat, r.lon),
          infoWindow: InfoWindow(title: r.name, snippet: r.address),
        ),
      );
    }
    // Origin marker
    markers.add(
      Marker(
        markerId: const MarkerId('origin'),
        position: LatLng(widget.originLat, widget.originLon),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow: InfoWindow(title: widget.originLabel),
      ),
    );
    return markers;
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(LucideIcons.mapPin, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Viewing ${widget.results.length} churches around ${widget.originLabel}',
                        style: theme.textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            ShadButton.ghost(
              size: ShadButtonSize.sm,
              onPressed: () => Navigator.of(context).maybePop(),
              child: const Row(
                children: [Icon(LucideIcons.x, size: 16), SizedBox(width: 6), Text('Close')],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _maybeWebApiKeyHelp() {
    if (!kIsWeb) return const SizedBox.shrink();
    // On web, google_maps_flutter requires a Maps JavaScript API key in web/index.html.
    // We show a small unobtrusive hint in case the map fails to load under restricted/no-key mode.
    return Positioned(
      bottom: 12,
      left: 12,
      right: 12,
      child: IgnorePointer(
        child: Opacity(
          opacity: 0.92,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.yellow.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.amber.withValues(alpha: 0.6)),
            ),
            child: const Text(
              'If the map does not load, add your Google Maps JavaScript API key in web/index.html.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final markers = _buildMarkers();
    final allowMyLocation = !kIsWeb && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialCamera,
            myLocationEnabled: allowMyLocation,
            myLocationButtonEnabled: true,
            compassEnabled: true,
            markers: markers,
            onMapCreated: (c) => _controller = c,
          ),
          _buildHeader(context),
          _maybeWebApiKeyHelp(),
        ],
      ),
    );
  }
}
