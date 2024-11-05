import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sparebess/modules/home/vm_home.dart';
import 'package:sparebess/shared/constant.dart';
import 'package:sparebess/views/dot_indicator.dart';
import 'package:sparebess/views/rx_status_view/rx_status_view1.dart';
import 'package:sparebess/views/web_image_view.dart';

import '../../views/shimmer/horizontal_shimmer.dart';

class HomeBannerCarouselView extends StatelessWidget {
  HomeBannerCarouselView({super.key});
  //final CarouselSliderController controller = CarouselSliderController();
  final CarouselSliderController controller = CarouselSliderController();


  final currentIndex = 0.obs;
  final VMHome data = Get.find();

  @override
  Widget build(BuildContext context) {
    return RxStatusView2(
      state: data.bannerState,
      loader: Padding(
        padding: const EdgeInsets.all(hSpace).copyWith(top: 0),
        child: DefaultShimmer(
          child: Container(
            height: 130,
          ),
        ),
      ),
      builder: () {
        return Column(
          children: [
            CarouselSlider(
              carouselController: controller,
              options: CarouselOptions(
                viewportFraction: 1.0,
                enlargeCenterPage: true,
                height: 130.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 2),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                initialPage: currentIndex.value,
                onPageChanged: (index, reason) {
                  currentIndex.value = index;
                },
              ),
              items: data.banners.map((banner) {
                return Container(
                  margin: const EdgeInsets.only(left: hSpace, right: hSpace),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.transparent,
                  ),
                  child: WebImageView(
                    banner.imageURL.imageUrl,
                    fit: BoxFit.fill,
                  ),
                );
              }).toList(),
            ),
            DotIndicator(
              currentIndex: currentIndex,
              total: data.banners.length,
              onTapIndex: (newIndex) {
                controller.animateToPage(newIndex);
              },
            ),
          ],
        );
      },
    );
  }
}
