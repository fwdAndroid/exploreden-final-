import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewLocationsScreen extends StatefulWidget {
  @override
  State<ViewLocationsScreen> createState() => _ViewLocationsScreenState();
}

class _ViewLocationsScreenState extends State<ViewLocationsScreen> {
  late String title;

  late String address;

  late String photoReference;

  @override
  void initState() {
    super.initState();
    _loadDetails();
  }

  Future<void> _loadDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      title = prefs.getString('title') ?? '';
      address = prefs.getString('address') ?? '';
      photoReference = prefs.getString('photoReference') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: $title'),
            Text('Address: $address'),
            Image.network(
              photoReference,
            ),
          ],
        ),
      ),
    );
  }
}
