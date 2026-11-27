import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:herafi_app/app/di/service_locator.dart';
import 'package:herafi_app/core/services/location_service.dart';
import 'package:herafi_app/app/failure/location_failure.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({
    super.key,
    this.initialLatitude,
    this.initialLongitude,
  });

  final double? initialLatitude;
  final double? initialLongitude;

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  static const LatLng _defaultCenter = LatLng(30.0444, 31.2357);

  late final LocationService _locationService;
  final MapController _mapController = MapController();
  late final LatLng _initialCenter;
  LatLng? _selectedLocation;
  bool _isLocating = false;

  @override
  void initState() {
    super.initState();
    _locationService = getIt<LocationService>();
    final latitude = widget.initialLatitude;
    final longitude = widget.initialLongitude;
    final hasValidInitialLocation =
        latitude != null &&
        longitude != null &&
        latitude.isFinite &&
        longitude.isFinite &&
        latitude >= -90 &&
        latitude <= 90 &&
        longitude >= -180 &&
        longitude <= 180;

    _initialCenter = hasValidInitialLocation
        ? LatLng(latitude, longitude)
        : _defaultCenter;
    _selectedLocation = hasValidInitialLocation ? _initialCenter : null;
  }

  Future<void> _useCurrentLocation() async {
    setState(() {
      _isLocating = true;
    });

    try {
      final position = await _locationService.getCurrentPosition();
      if (!mounted) {
        return;
      }

      final location = LatLng(position.latitude, position.longitude);
      setState(() {
        _selectedLocation = location;
      });
      _mapController.move(location, 16);
    } on CurrentLocationException catch (error) {
      LocationFailure.show(
        context: context,
        failure: error.failure,
        locationService: _locationService,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLocating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حدد موقع الحرفي'),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: _initialCenter,
                    initialZoom: 13,
                    onTap: (_, point) {
                      setState(() {
                        _selectedLocation = point;
                      });
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.herafi_app',
                      tileProvider: NetworkTileProvider(
                        headers: {
                          'User-Agent':
                              'Herafi/1.0.0 (+https://github.com/AbdelazizMohamed-GitHub/herafi_app)',
                        },
                      ),
                    ),
                    if (_selectedLocation != null)
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: _selectedLocation!,
                            width: 48,
                            height: 48,
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 44,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: FloatingActionButton.extended(
                    heroTag: 'current-location',
                    tooltip: 'موقعي الحالي',
                    onPressed: _isLocating ? null : _useCurrentLocation,
                    icon: _isLocating
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.my_location),
                    label: const Text('موقعي الحالي'),
                  ),
                ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    child: TextButton(
                      onPressed: () => launchUrl(
                        Uri.parse('https://www.openstreetmap.org/copyright'),
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        '© OpenStreetMap contributors',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  _selectedLocation == null
                      ? 'اضغط على الخريطة لتحديد موقع الورشة أو نطاق الخدمة'
                      : 'تم تحديد الموقع. حرّك الخريطة واضغط لتغييره.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _selectedLocation == null
                        ? null
                        : () => Navigator.of(context).pop(_selectedLocation),
                    child: const Text('تأكيد الموقع'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
