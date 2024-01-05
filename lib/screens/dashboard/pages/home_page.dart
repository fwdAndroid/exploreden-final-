import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploreden/models/place_model.dart';
import 'package:exploreden/screens/detail/place_description.dart';
import 'package:exploreden/utils/card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CardSwiperController controller = CardSwiperController();
  List<Map<String, dynamic>> swipedLeftDataList = [];

  late List<Place> places;
  Position? currentPosition;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();

    places = [];
    currentPosition = null;
    requestLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Image.asset(
          "assets/owl.png",
          height: 40,
          width: 40,
        ),
      ),
      body: places.isEmpty
          ? Center(child: Text("Places are Loading Please wait....."))
          : CardSwiper(
              onSwipe: (int previousIndex, int? currentIndex,
                  CardSwiperDirection direction) {
                if (direction == CardSwiperDirection.right &&
                    currentIndex != null) {
                  _storeDetails(places[currentIndex]);
                }
                // Continue h the default behavior
                return true;
              },
              controller: controller,
              cardsCount: places.length,
              cardBuilder: (
                context,
                index,
                horizontalThresholdPercentage,
                verticalThresholdPercentage,
              ) {
                return GestureDetector(
                  onTap: () {
                    print("click");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PlaceDetailsScreen(place: places[index]),
                      ),
                    );
                  },
                  child: CardItem(
                    imageUrl: places[index].photoUrl.isEmpty
                        ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdM_Qhi5UgadnISebC83xwnoq2G-OYSPu5WR0m6U4y5w&s"
                        : places[index].photoUrl,
                    title: places[index].name,
                    distance: calculateDistance(
                      currentPosition!.latitude,
                      currentPosition!.longitude,
                      places[index].latitude,
                      places[index].longitude,
                    ),
                  ),
                );
              },
            ),
    );
  }

  //Fucntions

  Future<void> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      _loadPlaces();
      print('Location permission granted!');
    } else {
      showLocationPermissionDialog();
    }
  }

  Future<void> _loadPlaces() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Place> fetchedPlaces = await fetchNearbyPlaces(position);

      setState(() {
        places = fetchedPlaces;
        currentPosition = position;
      });
    } catch (e) {
      print('Error loading places: $e');
    }
  }

  Future<List<Place>> fetchNearbyPlaces(Position position) async {
    final apiKey = 'AIzaSyAAyFZQqBciWMw63iTXE4qxJ-yCgV3nRnc';
    final radius = 11000; // You can adjust the radius as needed.
    final defaultImageUrl =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdM_Qhi5UgadnISebC83xwnoq2G-OYSPu5WR0m6U4y5w&s'; // Replace with your actual static image URL

    final url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${position.latitude},${position.longitude}&radius=$radius&type=tourist_attraction&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    print('Response Code: ${response.statusCode}');
    print('Response Body: ${response.body}');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);

      if (data['status'] == 'OK' && data['results'] != null) {
        List<Place> places = [];

        for (var placeData in data['results']) {
          final name = placeData['name'];
          final photos = placeData['photos'] as List<dynamic>?;

          double rating = (placeData['rating'] is int)
              ? (placeData['rating'] as int).toDouble()
              : placeData['rating']?.toDouble() ?? 0.0;

          String photoUrl = defaultImageUrl;
          if (photos != null && photos.isNotEmpty) {
            final firstPhoto = photos[0] as Map<String, dynamic>?;
            if (firstPhoto != null) {
              final photoReference = firstPhoto['photo_reference'];
              photoUrl =
                  'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=$apiKey';
            }
          }

          final address = placeData['vicinity'];
          final placeId = placeData['place_id'];
          final latitude = placeData['geometry']['location']['lat'];
          final longitude = placeData['geometry']['location']['lng'];

          places.add(Place(
            name: name,
            photoUrl: photoUrl,
            address: address,
            latitude: latitude,
            longitude: longitude,
            placeId: placeId,
            rating: rating,
          ));
        }

        return places;
      } else {
        throw Exception('Failed to load places. Status: ${data['status']}');
      }
    } else {
      throw Exception(
          'Failed to load places. Status Code: ${response.statusCode}');
    }
  }

  double calculateDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) {
    return Geolocator.distanceBetween(
          startLatitude,
          startLongitude,
          endLatitude,
          endLongitude,
        ) /
        1000; // Convert meters to kilometers
  }

  void showLocationPermissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Permission Required'),
          content: Text(
              'Please enable location permission in the app settings to continue.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                openAppSettings(); // Open the app settings
              },
              child: Text('Go to Settings'),
            ),
          ],
        );
      },
    );
  }

  Future<bool> isDataExists(String data) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('saved')
        .where('title', isEqualTo: data)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  Future<void> _storeDetails(Place place) async {
    String data = place.name;
    var uuid = Uuid().v4();
    if (isDataExists(data) == true) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Place already added")));
    } else {
      await FirebaseFirestore.instance.collection("saved").doc(uuid).set({
        "uuid": uuid,
        "id": FirebaseAuth.instance.currentUser!.uid,
        "title": place.name,
        "address": place.address,
        "photoReference": place.photoUrl,
        "rating": place.rating,
        "placeid": place.placeId
      });

      // Show a confirmation snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Location Saved'),
        ),
      );
    }
  }
}
