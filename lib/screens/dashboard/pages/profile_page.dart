import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploreden/screens/auth/sign_in_page.dart';
import 'package:exploreden/screens/dashboard/pages/favourite_page.dart';
import 'package:exploreden/screens/noti/noti.dart';
import 'package:exploreden/screens/profile_pages/about_us.dart';
import 'package:exploreden/screens/profile_pages/adverstise.dart';
import 'package:exploreden/screens/profile_pages/faq.dart';
import 'package:exploreden/screens/profile_pages/privacy_policy.dart';
import 'package:exploreden/utils/colors.dart';
import 'package:exploreden/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_filex/open_filex.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Uri _url = Uri.parse('https://www.exploreden.com');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
                                builder: (builder) => FavouritePage()));
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
                        Icons.contact_emergency,
                        color: mainColor,
                      ),
                      title: Text(
                        "Contact Us",
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
                      onTap: _launchUrl,
                      trailing: Icon(
                        Icons.newspaper,
                        color: mainColor,
                      ),
                      title: Text(
                        "News",
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
                            MaterialPageRoute(builder: (builder) => AboutUs()));
                      },
                      trailing: Icon(
                        Icons.info,
                        color: mainColor,
                      ),
                      title: Text(
                        "About Us",
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
                            MaterialPageRoute(builder: (builder) => Faq()));
                      },
                      trailing: Icon(
                        Icons.question_answer,
                        color: mainColor,
                      ),
                      title: Text(
                        "FAQ",
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => Advertise()));
                      },
                      trailing: Icon(
                        Icons.ads_click,
                        color: mainColor,
                      ),
                      title: Text(
                        "Advertise with Us",
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => PrivacyPolicy()));
                      },
                      trailing: Icon(
                        Icons.privacy_tip,
                        color: mainColor,
                      ),
                      title: Text(
                        "Privacy Policy",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'No',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF1C1F34),
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

                                                showSnakBar(
                                                    "Logout Successfully",
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
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
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
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  void openFaq() async {
    final filePath = 'assets/faq.pdf';

    try {
      final result = await OpenFilex.open(filePath);
      print(result);
    } catch (e) {
      print('Error opening PDF: $e');
    }
  }
}
