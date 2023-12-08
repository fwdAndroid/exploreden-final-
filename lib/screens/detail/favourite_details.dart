import 'package:exploreden/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FavouriteDetail extends StatefulWidget {
  String name, address, image, rating;
  FavouriteDetail(
      {super.key,
      required this.address,
      required this.rating,
      required this.image,
      required this.name});

  @override
  State<FavouriteDetail> createState() => _FavouriteDetailState();
}

class _FavouriteDetailState extends State<FavouriteDetail> {
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
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Location Name",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 18),
                    ),
                    Text(
                      widget.name,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )),
          ),
          Card(
            child: ListTile(
                leading: Icon(
                  Icons.location_city,
                  color: mainColor,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Location Address",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 18),
                    ),
                    Text(
                      widget.address,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )),
          ),
          Card(
            child: ListTile(
                leading: Icon(
                  Icons.star,
                  color: mainColor,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ratings",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 18),
                    ),
                    Text(
                      widget.rating,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
