import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  final Place place;

  const PlaceDetailScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: Column(
        children: [
          Image.file(
            File(place.image.path),
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          Text(
            place.location.address,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 300,
            width: double.infinity,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(place.location.latitude, place.location.longitude),
                zoom: 16,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('m1'),
                  position: LatLng(place.location.latitude, place.location.longitude),
                )
              },
            ),
          ),
        ],
      ),
    );
  }
}
