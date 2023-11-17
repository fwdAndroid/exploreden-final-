import 'package:flutter/material.dart';

class Notify extends StatefulWidget {
  const Notify({super.key});

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Notifications",
          )),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (builder) => DestinationPage()));
                },
                leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/face.png"),
                ),
                subtitle: Text("Visit Complete"),
                title: Text("RedFish Lake"));
          }),
    );
  }
}
