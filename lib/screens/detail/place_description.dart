import 'dart:convert';

import 'package:exploreden/models/place_model.dart';
import 'package:exploreden/models/review_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PlaceDetailsScreen extends StatefulWidget {
  final Place place;

  PlaceDetailsScreen({required this.place});

  @override
  State<PlaceDetailsScreen> createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  late Place _placeDetails;
  List<Review> _reviews = [];
  String _openingHours = 'Not available';

  @override
  void initState() {
    super.initState();
    _placeDetails = widget.place;
    // Fetch additional details about the place using the Google Places API
    _loadPlaceDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              _placeDetails.photoUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _placeDetails.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Address: ${_placeDetails.address}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Rating: ${_placeDetails.rating}',
                    style: TextStyle(fontSize: 16),
                  ),
                  // SizedBox(height: 8),
                  Text(
                    'Opening Hours:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _openingHours,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Reviews:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  _reviews.isNotEmpty
                      ? Column(
                          children: _reviews.map((review) {
                            return ListTile(
                              title: Text(
                                  '${review.authorName} - ${review.rating} stars'),
                              subtitle: Text(review.text),
                            );
                          }).toList(),
                        )
                      : Text('No reviews available'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadPlaceDetails() async {
    final apiKey = 'AIzaSyB9ovPkJ-s1cXezeqrQRUxewuWSYNyjdPo';
    final url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=${_placeDetails.placeId}&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK' && data['result'] != null) {
        final result = data['result'];

        double rating = result['rating'] ?? 0.0;
        List<dynamic> reviewsData = result['reviews'] ?? [];
        _reviews = reviewsData
            .map((reviewData) => Review.fromMap(reviewData))
            .toList();
        // Extract opening hours
        Map<String, dynamic>? openingHoursData = result['opening_hours'];
        if (openingHoursData != null && openingHoursData['periods'] != null) {
          _openingHours = _extractOpeningHours(openingHoursData['periods']);
        }

        setState(() {
          _placeDetails = Place(
            name: _placeDetails.name,
            photoUrl: _placeDetails.photoUrl,
            address: _placeDetails.address,
            latitude: _placeDetails.latitude,
            longitude: _placeDetails.longitude,
            placeId: _placeDetails.placeId,
            rating: rating,
          );
        });
      } else {
        throw Exception(
            'Failed to load place details. Status: ${data['status']}');
      }
    } else {
      throw Exception(
          'Failed to load place details. Status Code: ${response.statusCode}');
    }
  }

  String _extractOpeningHours(List<dynamic> periods) {
    String openingHours = '';
    for (var period in periods) {
      final openTime = period['open']['time'];
      final closeTime = period['close']['time'];

      if (openTime is int && closeTime is int) {
        openingHours +=
            '${_formatTime(openTime)} - ${_formatTime(closeTime)}\n';
      } else {
        openingHours += 'Not available\n';
      }
    }
    return openingHours.trim();
  }

  String _formatTime(int time) {
    final hour = (time ~/ 100).toString().padLeft(2, '0');
    final minute = (time % 100).toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
