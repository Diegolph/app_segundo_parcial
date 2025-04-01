import 'dart:io';
import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  final List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage, PlaceLocation location) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      location: location,
      image: pickedImage,
    );

    _items.add(newPlace);
    notifyListeners();

    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': newPlace.location.latitude,
      'lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  Future<void> loadPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items.clear();
    _items.addAll(dataList.map((item) => Place(
          id: item['id'],
          title: item['title'],
          image: File(item['image']),
          location: PlaceLocation(
            latitude: item['lat'],
            longitude: item['lng'],
            address: item['address'],
          ),
        )));
    notifyListeners();
  }
}
