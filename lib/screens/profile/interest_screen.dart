import 'package:exploreden/screens/dashboard/main_dashboard.dart';
import 'package:exploreden/utils/colors.dart';
import 'package:exploreden/utils/groupstyle.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Interest Details",
          style: TextStyle(color: colorBlack),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Text(
                'Select a few of your interests and let everyone know what you’re passionate about.',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.699999988079071),
                  fontSize: 14,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Text(
                'Group Fun',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.699999988079071),
                  fontSize: 24,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: GroupButton(
                options: ss,
                isRadio: false,
                buttons: [
                  "Escape Room",
                  "Paintball",
                  "Kayaking",
                  "Canoeing",
                  "Surfing",
                  "Karaoke",
                  "Ice Skating",
                  "Bowling",
                  "Game Parlor",
                  "Hiking",
                  "Clubs",
                  "Nightlife",
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Text(
                'Perfect Date',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.699999988079071),
                  fontSize: 24,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: GroupButton(
                options: ss,
                isRadio: false,
                buttons: [
                  "Food",
                  "Movie",
                  "Park",
                  "Beach picnic",
                  "Hiking",
                  "Cooking Classes",
                  "Hot Air Balloon Ride Relaxation",
                  "Meditation",
                  "Yoga Retreats",
                  "Massage",
                  "Wellness & Spas",
                  "Sauna & Relaxation",
                  "Self-Care"
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Text(
                'Relaxation',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.699999988079071),
                  fontSize: 24,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: GroupButton(
                options: ss,
                isRadio: false,
                buttons: [
                  "Meditation",
                  "Yoga Retreats",
                  "Massage",
                  "Wellness & Spas",
                  "Sauna & Relaxation",
                  "Self-Care"
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Text(
                'Adventure',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.699999988079071),
                  fontSize: 24,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: GroupButton(
                options: ss,
                isRadio: false,
                buttons: [
                  "Zip Line",
                  "Paragliding",
                  "Skydiving",
                  "Water adventures",
                  "Whitewater rafting",
                  "Scuba diving",
                  "Bungee jumping",
                  "Rock Climbing",
                  "Snowboarding",
                  "Camping",
                  "Sand biking",
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Text(
                'Sport & Events',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.699999988079071),
                  fontSize: 24,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: GroupButton(
                options: ss,
                isRadio: false,
                buttons: [
                  "Live Sports",
                  "Tournaments",
                  "Local Festivals",
                  "Concerts",
                  "Theatre Performances"
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Text(
                'Let’s Learn',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.699999988079071),
                  fontSize: 24,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: GroupButton(
                options: ss,
                isRadio: false,
                buttons: [
                  "Pottery Classes",
                  "Painting Workshops",
                  "Cooking Classes",
                  "Candle Making Workshops",
                  "Music Lessons",
                  "Dance Classes"
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Text(
                'More',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.699999988079071),
                  fontSize: 24,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: GroupButton(
                options: ss,
                isRadio: false,
                buttons: [
                  "Farmer's Markets",
                  "Flea Markets",
                  "Craft Markets",
                  "Concerts",
                  "Artisan Markets",
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    fixedSize: const Size(303, 60),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => MainDashboard()));
                  },
                  child: Text(
                    "Confrim",
                    style: TextStyle(
                        color: colorWhite,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
