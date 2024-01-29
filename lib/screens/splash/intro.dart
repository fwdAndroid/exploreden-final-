import 'package:exploreden/screens/auth/sign_in_page.dart';
import 'package:exploreden/screens/dashboard/main_dashboard.dart';
import 'package:exploreden/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 395,
            height: 539,
            decoration: ShapeDecoration(
              shadows: [
                BoxShadow(
                    blurRadius: 0.2, spreadRadius: 0.5, color: Colors.grey)
              ],
              color: colorWhite,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(150),
                  bottomRight: Radius.circular(150),
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome To",
                  style: TextStyle(
                      color: colorBlack,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                Image.asset(
                  "assets/logonew.png",
                  width: 150,
                  height: 150,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                fixedSize: const Size(303, 60),
                side: BorderSide(color: mainColor, width: 1),
              ),
              onPressed: () {
                check(context);
              },
              child: Text(
                "Lets Explore",
                style: TextStyle(color: mainColor),
              ))
        ],
      ),
    );
  }
}

check(BuildContext context) {
  final User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainDashboard()));
  } else {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignInPage()));
  }
}
