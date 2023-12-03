import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritePage extends StatefulWidget {
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  Future<Map<String, String>> getLocationData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String photoPath = prefs.getString('photoUrl') ?? '';
    String name = prefs.getString('name') ?? '';
    String address = prefs.getString('address') ?? '';

    return {'Photo Path': photoPath, 'Name': name, 'Address': address};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Data'),
      ),
      body: FutureBuilder<Map<String, String>>(
        future: getLocationData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No saved data.'));
          } else {
            return SizedBox(
              height: 300,
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  String key = snapshot.data!.keys.elementAt(index);
                  String value = snapshot.data![key]!;

                  return ListTile(
                    title: Text(
                      '$key: $value',
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
