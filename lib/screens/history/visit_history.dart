import 'package:exploreden/utils/colors.dart';
import 'package:flutter/material.dart';

class VisitHistory extends StatefulWidget {
  const VisitHistory({super.key});

  @override
  State<VisitHistory> createState() => _VisitHistoryState();
}

class _VisitHistoryState extends State<VisitHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "History",
          )),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                  selectedTileColor: mainColor,
                  selectedColor: mainColor,
                  onTap: () {
                    //  Navigator.push(
                    // context,
                    // MaterialPageRoute(
                    //     builder: (builder) => DestinationPage()));
                  },
                  subtitle: Text("22 December 2023"),
                  title: Text("RedFish Lake")),
            );
          }),
    );
  }
}
