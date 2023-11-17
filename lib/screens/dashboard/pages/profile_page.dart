import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploreden/screens/auth/sign_in_page.dart';
import 'package:exploreden/screens/history/visit_history.dart';
import 'package:exploreden/screens/noti/noti.dart';
import 'package:exploreden/screens/profile/edit_profile.dart';
import 'package:exploreden/utils/colors.dart';
import 'package:exploreden/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<Object>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return new CircularProgressIndicator();
              }
              var document = snapshot.data;
              return Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  ListTile(
                    trailing: Image.network(
                      document['photoURL'],
                      fit: BoxFit.cover,
                      width: 50,
                      height: 100,
                    ),
                    title: Text(
                      document['name'],
                      style: TextStyle(
                          color: colorBlack,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => VisitHistory()));
                    },
                    trailing: Icon(
                      Icons.history,
                      color: mainColor,
                    ),
                    title: Text(
                      "Visit History",
                      style: TextStyle(
                        color: colorBlack,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Divider(
                    color: mainColor,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) => Notify()));
                    },
                    trailing: Icon(
                      Icons.notifications,
                      color: mainColor,
                    ),
                    title: Text(
                      "Notification",
                      style: TextStyle(
                        color: colorBlack,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Divider(
                    color: mainColor,
                  ),
                  ListTile(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20.0)), //this right here
                              child: Container(
                                height: 300,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/owl.png",
                                        height: 80,
                                        width: 80,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Oh No, Your are leaving',
                                        style: TextStyle(
                                          color: Color(0xFF1C1F34),
                                          fontSize: 22,
                                          fontFamily: 'Work Sans',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: 287,
                                        child: Text(
                                          'Are you sure you want to logout',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF6C757D),
                                            fontSize: 14,
                                            fontFamily: 'Work Sans',
                                            fontWeight: FontWeight.w500,
                                            height: 0.10,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 51,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 16),
                                              decoration: ShapeDecoration(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'No',
                                                    style: TextStyle(
                                                      color: Color(0xFF1C1F34),
                                                      fontSize: 16,
                                                      fontFamily: 'Work Sans',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              await FirebaseAuth.instance
                                                  .signOut()
                                                  .then((value) => {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (builder) =>
                                                                        SignInPage()))
                                                      });

                                              showSnakBar("Logout Successfully",
                                                  context);
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 51,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 16),
                                              decoration: ShapeDecoration(
                                                color: Color(0xFF40B59F),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Yes',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontFamily: 'Work Sans',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    trailing: Icon(
                      Icons.logout,
                      color: mainColor,
                    ),
                    title: Text(
                      "Log Out",
                      style: TextStyle(
                        color: colorBlack,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
