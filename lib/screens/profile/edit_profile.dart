import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploreden/screens/dashboard/main_dashboard.dart';
import 'package:exploreden/utils/colors.dart';
import 'package:exploreden/utils/controllers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<Object>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return new CircularProgressIndicator();
            }
            var docum = snapshot.data;

            editProfileFullNameController.text = docum['firstName'];
            editProfileLastNameController.text = docum['lastName'];
            editPhoneController.text = docum['phoneNumber'];

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/owl.png",
                        height: 300,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 0.2,
                                  spreadRadius: 0.5,
                                  color: Colors.grey)
                            ],
                            color: colorWhite,
                          ),
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            controller: editProfileFullNameController,
                            decoration: InputDecoration(
                              hintText: "First Name",
                              fillColor: colorWhite,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: colorWhite),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: colorWhite),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: colorWhite),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 0.2,
                                spreadRadius: 0.5,
                                color: Colors.grey)
                          ],
                          color: colorWhite,
                        ),
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        child: TextFormField(
                          controller: editProfileLastNameController,
                          decoration: InputDecoration(
                            hintText: "Last Name",
                            fillColor: colorWhite,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorWhite),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorWhite),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorWhite),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 0.2,
                                spreadRadius: 0.5,
                                color: Colors.grey)
                          ],
                          color: colorWhite,
                        ),
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: editPhoneController,
                          decoration: InputDecoration(
                            hintText: "Phone Number",
                            fillColor: colorWhite,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorWhite),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorWhite),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorWhite),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    _isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: mainColor,
                                  fixedSize: const Size(303, 60),
                                ),
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                      color: colorWhite,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .update({
                                    "lastName":
                                        editProfileLastNameController.text,
                                    "firstName":
                                        editProfileFullNameController.text,
                                    "phoneNumber": editPhoneController.text
                                  }).then((value) => {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "User Profile Updated")))
                                          });
                                  editProfileFullNameController.clear();
                                  editProfileLastNameController.clear();
                                  editPhoneController.clear();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              MainDashboard()));
                                })),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
