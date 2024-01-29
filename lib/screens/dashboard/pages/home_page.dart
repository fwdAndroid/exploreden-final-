import 'dart:async';
import 'dart:convert';
import 'dart:developer';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final CardSwiperController controller = CardSwiperController();
  List<Map<String, dynamic>> swipedLeftDataList = [];
  late List<Place> places;
  Position? currentPosition;
  List<String> keywords = [];

  @override
  void initState() {
    super.initState();
    places = [];
    currentPosition = null;
    requestLocationPermission();
    getSavedInterestKeysSF();
  }

  getSavedInterestKeysSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    keywords = prefs.getStringList('InterestKey') ?? [];
    log('========Keywords=================> $keywords');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Image.asset(
          "assets/logonew.png",
          height: 40,
          width: 40,
        ),
      ),
      body: places.isEmpty
          ? Center(child: CircularProgressIndicator())
          : CardSwiper(
              onSwipe: (int previousIndex, int? currentIndex,
                  CardSwiperDirection direction) {
                if (direction == CardSwiperDirection.right &&
                    currentIndex != null) {
                  // Handle card swiping, save to SharedPreferences when swiped left
                  print(direction.name);
                  print(places[currentIndex]);
                  _storeDetails(places[previousIndex]);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => ViewLocationsScreen()),
                  // );
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
                        ? "https://ibb.co/R9phV1kblack"
                        : places[index].photoUrl,
                    title: places[index].name,
                    distance: calculateDistance(
                      currentPosition!.latitude,
                      currentPosition!.longitude,
                      places[currentIndex].latitude,
                      places[currentIndex].longitude,
                    ),
                  ),
                );
              },
            ),
    );
  }

  //Functions

  Future<void> requestLocationPermission() async {
    // Request location permission
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      // Permission granted, you can proceed with location-related tasks
      // _loadPlaces();
      run();
      print('Location permission granted!');
    } else {
      // Permission denied, handle it accordingly (e.g., show a message or disable location features)
      print('Location permission denied!');
      showLocationPermissionDialog();
    }
  }

  run() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      List<Place> results = [];
      for (var i = 0; i < keywords.length; i++) {
        log("======data========${i}");
        log("======data========${keywords[i]}");

        results += await fetchNearbyPlaces(position, keywords[i]);
      }
      setState(() {
        places = results;
        currentPosition = position;
      });
      return (null, places);
    } catch (e) {
      return ('Error loading places: $e');
    }
  }

  Future<void> _loadPlaces() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      List<Place> fetchedPlaces =
          await fetchNearbyPlaces(position, "SkyDIving");
      setState(() {
        places = fetchedPlaces;
        currentPosition = position;
      });
    } catch (e) {
      print('Error loading places: $e');
    }
  }

  /*Future<Map<String ,List<Place>>> _loadPlaces(List<String>types)async{
    Map<String, List<Place>> result = {};

    try{
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy:
      LocationAccuracy.high,);
      for(String type in types){
        List<Place> fetchedPlaces = await fetchNearbyPlaces(position, type);
        result[type] = fetchedPlaces;

      }
      setState(() {
        types = ['bar','restaurant'];
      });
    }catch(e){
      print('Error loading places : $e');
    }
    return result;

  }*/

  Future<List<Place>> fetchNearbyPlaces(
      Position position, String indexPlace) async {
    const apiKey = 'AIzaSyCi52iUh-_pok8aaR2cG0wuFlcVtNv1NeA';
    // final apiKey = 'AIzaSyB9ovPkJ-s1cXezeqrQRUxewuWSYNyjdPo';
    const radius = 11000; // You can adjust the radius as needed.
    const page_token =
        "AWU5eFiJ0TJXBgJ0hb09sowBSmhjjjf6BC7HPvS64fsgX1V1GOvvWYWRGc27Xm7fHsnJ0yPBMRveQgIJixdr8dDwNFFGDeqk51yGbR6cLmveujbrKffMiNzvYsaW594Ft-QzU0gYEebjgTAjtgkLxPTJ7pIP2XbhFoIXl-9iGGc3bHU2hDj_9uLJ0BX1dME509n3oiWw-8jupWYpWMoLI7PpgrgnVPbPnFnsjW0u73YKPehJ1zmTEPQ07mmahkhA4CbTCiq7B4HtwvL0XiD7FbjGem8fjFu9NekHKZxTnwEn68hF4v-QqQ6fiUVe8jg1xEnlmAUBy1j_EQ8JC2ul3igJEBjSt9Lo0QuS0LRe3NaIu739E8BEIlbPZHY5RezSFDEgQHXDog";
    const defaultImageUrl =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdM_Qhi5UgadnISebC83xwnoq2G-OYSPu5WR0m6U4y5w&s'; // Replace with your actual static image URL\
    /*final url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${position.latitude},${position.longitude}&radius=$radius&type=bar&key=$apiKey';*/
    /*Text search*/
    final url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$indexPlace&key=$apiKey&next_page_token=page_token';

    final response = await http.get(Uri.parse(url));
    // print('Response Code: ${response.statusCode}');
    // print('Response Body: ${response.body}');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
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
          final address = placeData['vicinity'] ?? '';
          final placeId = placeData['place_id'] ?? '';
          final latitude = placeData['geometry']['location']['lat'] ?? '';
          final longitude = placeData['geometry']['location']['lng'] ?? '';
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
          title: const Text('Location Permission Required'),
          content: const Text(
              'Please enable location permission in the app settings to continue.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                openAppSettings(); // Open the app settings
              },
              child: const Text('Go to Settings'),
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
    print("this is the data result upper log ${isDataExists(data)}");
    var uuid = const Uuid().v4();
    bool dataExist = await isDataExists(data);
    if (dataExist == true) {
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

      // Show a confirmation Snack-bar
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Location Saved')));
    }
  }
}
