import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
  LatLng? _currentLocation;

  Future<void> _getCurrentLocation() async {
    try {
      final locData = await Location().getLocation();

      setState(() {
        _currentLocation = LatLng(locData.latitude!, locData.longitude!);
        _previewImageUrl =
            'https://maps.googleapis.com/maps/api/staticmap?center=${locData.latitude},${locData.longitude}&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C${locData.latitude},${locData.longitude}&key=AIzaSyBuxKmtE3TDMrDt0ANxBv7wzAbM0MsltkM';

      });
    } catch (error) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? const Text(
                  'No se ha seleccionado ubicación',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: _getCurrentLocation,
          icon: const Icon(Icons.location_on),
          label: const Text('Ubicación actual'),
        ),
      ],
    );
  }
}
