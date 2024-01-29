import 'package:exploreden/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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
          Card(
            child: ListTile(
              trailing: Container(
                height: 40,
                width: 40,
                decoration:
                    BoxDecoration(color: mainColor, shape: BoxShape.circle),
                child: Center(
                  child: Text(
                    "Go",
                    style: TextStyle(color: colorWhite, fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(widget.image),
              ),
              title: Text(
                widget.name,
              ),
              subtitle: Text(
                widget.address,
              ),
              onTap: () {
                _launchMapsUrl(
                  widget.address,
                );
              },
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                await Share.share(
                    'check out my app https://play.google.com/store/games?hl=en&gl=US');
              },
              child: Text("Share Location"))
        ],
      ),
    );
  }

  void _launchMapsUrl(String address) async {
    final encodedAddress = Uri.encodeFull(address);
    final url =
        'https://www.google.com/maps/search/?api=1&query=$encodedAddress';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
