// ... (your imports remain unchanged)

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploreden/screens/detail/favourite_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavouritePage extends StatefulWidget {
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Explorer Den Locations"),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("saved")
              .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  "No Locations Added by the Explorer Den Found yet",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            final List<DocumentSnapshot> documents = snapshot.data!.docs;

            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (BuildContext context, int index) {
                final Map<String, dynamic> data =
                    documents[index].data() as Map<String, dynamic>;

                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    child: ListTile(
                      trailing: IconButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection("saved")
                              .doc(data['uuid'])
                              .delete();
                        },
                        icon: Icon(Icons.delete),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => FavouriteDetail(
                              image: data['photoReference'],
                              rating: data['rating'].toString(),
                              name: data['title'].toString(),
                              address: data['address'].toString(),
                            ),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(data['photoReference']),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Location Name"),
                          Text(data['title']),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Location Address"),
                          Text(data['address']),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
