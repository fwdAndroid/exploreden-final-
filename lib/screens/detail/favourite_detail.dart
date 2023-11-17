import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploreden/screens/dashboard/main_dashboard.dart';
import 'package:exploreden/utils/colors.dart';
import 'package:exploreden/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FavourteDetail extends StatefulWidget {
  final name;
  final address;
  final description;
  final uuid;
  const FavourteDetail(
      {super.key,
      required this.address,
      required this.description,
      required this.name,
      required this.uuid});

  @override
  State<FavourteDetail> createState() => _FavourteDetailState();
}

class _FavourteDetailState extends State<FavourteDetail> {
  bool _isLoading = false;
  var uuid = Uuid().v4();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Location Name",
              style: TextStyle(
                  color: colorBlack, fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.name,
              style: TextStyle(
                  color: colorBlack, fontSize: 16, fontWeight: FontWeight.w300),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Location Address",
              style: TextStyle(
                  color: colorBlack, fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.address,
              style: TextStyle(
                  color: colorBlack, fontSize: 16, fontWeight: FontWeight.w300),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Location Description",
              style: TextStyle(
                  color: colorBlack, fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.description,
              style: TextStyle(
                  color: colorBlack, fontSize: 16, fontWeight: FontWeight.w300),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        fixedSize: const Size(303, 50),
                      ),
                      onPressed: profile,
                      child: Text(
                        "Delete",
                        style: TextStyle(
                            color: colorWhite,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                )
        ],
      ),
    );
  }

  void profile() async {
    setState(() {
      _isLoading = true;
    });
    await FirebaseFirestore.instance.collection("favourite").doc(uuid).delete();
    setState(() {
      _isLoading = false;
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (builder) => MainDashboard()));
    showSnakBar("'Location Delete'", context);
  }
}
