import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:sparebess/views/app_bar/default_app_bar.dart';

import '../../shared/theme.dart';

class RewardsPageView extends StatefulWidget {
  const RewardsPageView({super.key});

  @override
  State<RewardsPageView> createState() => _RewardsPageViewState();
}

class _RewardsPageViewState extends State<RewardsPageView> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'Rewards',
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                Container(
                  height: 160,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: appthemecolor1,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            " ",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Amazon Ember",
                            ),
                          ),
                          Text(
                            "Your Points",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Amazon Ember",
                              fontSize: 11,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 15.0),
                            child: Icon(
                              FontAwesome5.award,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            "700 Points",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontFamily: "Amazon Ember",
                            ),
                          ),
                          Container(
                            height: 35.0,
                            width: screenWidth,
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            child: const Center(
                              child: Text(
                                "Latest Update : 5 Feb 2024",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Amazon Ember",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 80.0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Transform.rotate(
                      angle: 43.5,
                      child: const Icon(
                        CupertinoIcons.gift_fill,
                        color: Colors.white,
                        size: 35.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                Text(
                  "Points History",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    fontFamily: "Amazon Ember",
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 400,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (BuildContext context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                    height: 100,
                    width: screenWidth,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Today, 04:32 PM",
                                style: TextStyle(
                                    fontFamily: "Amazon Ember",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0),
                              ),
                              Text(
                                "#TR6484",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Amazon Ember",
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Payment #TR6484",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  fontFamily: "Amazon Ember",
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_rounded,
                                    color: Colors.yellowAccent,
                                  ),
                                  Text(
                                    "+85",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        fontFamily: "Amazon Ember",
                                        color: Colors.blue),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
