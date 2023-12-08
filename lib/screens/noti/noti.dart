import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploreden/screens/dashboard/main_dashboard.dart';
import 'package:exploreden/utils/colors.dart';
import 'package:exploreden/utils/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Notify extends StatefulWidget {
  const Notify({super.key});

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController dse = TextEditingController();
  bool isLoading = false;
  var uuid = Uuid().v4();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: colorWhite,
        title: Text(
          "User Report",
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
      backgroundColor: colorWhite,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      "Name",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ),
                  Center(
                    child: InputText(
                      controller: emailController,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                  InputText(
                    controller: subjectController,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                  InputText(
                    max: 5,
                    controller: dse,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (emailController.text.isEmpty ||
                          subjectController.text.isEmpty ||
                          dse.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("All Fields Required")));
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        await FirebaseFirestore.instance
                            .collection("reports")
                            .doc(uuid)
                            .set({
                          "subject": subjectController.text,
                          "message": dse.text,
                          "username": emailController.text,
                          'id': FirebaseAuth.instance.currentUser!.uid,
                          "uuid": uuid
                        });
                        setState(() {
                          isLoading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Complained Register")));
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => MainDashboard()));
                      }
                    },
                    child: Container(
                      width: 335,
                      height: 48,
                      decoration: ShapeDecoration(
                        color: mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
