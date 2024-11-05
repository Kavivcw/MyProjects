import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sparebess/modules/user/profile/vm_profile.dart';
import 'package:sparebess/shared/constant.dart';
import 'package:sparebess/views/app_bar/default_app_bar.dart';

import '../../../shared/theme.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final data = Get.put(VMProfile());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'My Profile',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Image.asset(
                'Logo 3'.png,
                width: Get.width * 0.25,
              ),
            ),
            ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (con, index) {
                final item = data.arrMenu[index];
                return ProfileListItemView(
                  data: item,
                  onTap: () => data.onTapMenu(item),
                );
              },
              separatorBuilder: (con, index) {
                return Gap(5);
              },
              itemCount: data.arrMenu.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
            Gap(15),
          ],
        ),
      ),
    );
  }
}

class ProfileListItemView extends StatelessWidget {
  const ProfileListItemView({
    super.key,
    required this.data,
    required this.onTap,
  });

  final VMProfileListItem data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 8.0, right: 8.0),
        child: ListTile(
          shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.grey, width: 0.9),
              borderRadius: BorderRadius.circular(10)),
          title: Text(
            data.name,
            style: const TextStyle(
              fontFamily: "Amazon Ember",
              fontSize: 14,
            ),
          ),
          leading: Icon(
            data.image,
            color: appthemecolor1,
          ),
        ),
      ),
    );
  }
}
