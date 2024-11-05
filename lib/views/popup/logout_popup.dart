import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparebess/shared/constant.dart';

import '../../controller/auth_controller.dart';
import '../../shared/theme.dart';

class LogoutPopup extends StatelessWidget {
  const LogoutPopup({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          )),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Logout?",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Lato",
                  fontSize: 17.0),
            ),
            Gap(10),
            const Text(
              "Are you sure to logout $appName app?",
              style: TextStyle(
                fontSize: 13.0,
                fontFamily: "Lato",
              ),
            ),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Not Now",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontFamily: "Lato",
                    ),
                  ),
                ),
                Gap(10),
                ElevatedButton(
                  onPressed: () async {

                   AuthController.to.logout();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appthemecolor1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    shadowColor: Colors.grey,
                    elevation: 8,
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontFamily: "Lato",
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
