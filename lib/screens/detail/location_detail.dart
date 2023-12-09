import 'package:exploreden/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LocationDetails extends StatefulWidget {
  String name, description, address, image, rating, openinghrs;
  LocationDetails(
      {super.key,
      required this.address,
      required this.rating,
      required this.image,
      required this.openinghrs,
      required this.description,
      required this.name});

  @override
  State<LocationDetails> createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Explorer Den Locations",
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.network(
              widget.image,
              height: 200,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
              filterQuality: FilterQuality.high,
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.location_pin,
                color: mainColor,
              ),
              title: Text(
                widget.name,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.location_city,
                color: mainColor,
              ),
              title: Text(
                widget.address,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Card(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(
                    Icons.details,
                    color: mainColor,
                  ),
                  title: Text(
                    widget.description,
                    style: TextStyle(fontSize: 18),
                  ),
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Opening Hrs",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.openinghrs,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Location Ratings",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.rating,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
