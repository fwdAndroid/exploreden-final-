import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploreden/screens/detail/location_detail.dart';
import 'package:exploreden/utils/colors.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text(
              "Explorer Den Locations",
            )),
        body: SizedBox(
          height: 225,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("locations")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Align(
                    alignment: AlignmentDirectional.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No Locations Added by the Admin",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return StreamBuilder<Object>(
                          stream: FirebaseFirestore.instance
                              .collection("locations")
                              .snapshots(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            final List<DocumentSnapshot> documents =
                                snapshot.data!.docs;
                            final Map<String, dynamic> data =
                                documents[index].data() as Map<String, dynamic>;
                            return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Card(
                                  color: mainColor,
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                                  LocationDetails(
                                                    openinghrs: data[
                                                        'locationOpeningHrs'],
                                                    image:
                                                        data['locationPhoto'],
                                                    rating:
                                                        data['locationRating'],
                                                    name: data['locationName']
                                                        .toString(),
                                                    description: data[
                                                            'locationDescription']
                                                        .toString(),
                                                    address:
                                                        data['locationAddress']
                                                            .toString(),
                                                  )));
                                    },
                                    title: Text(
                                      data['locationName'],
                                      style: TextStyle(color: colorWhite),
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      color: colorBlack,
                                    ),
                                  ),
                                ));
                          });
                    });
              }),
        ));
  }
}
