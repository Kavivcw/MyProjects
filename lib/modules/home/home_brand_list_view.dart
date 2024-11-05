import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sparebess/modules/home/home_screen.dart';
import 'package:sparebess/modules/home/vm_home.dart';
import 'package:sparebess/shared/constant.dart';
import 'package:sparebess/views/rx_status_view/rx_status_view1.dart';
import 'package:sparebess/views/web_image_view.dart';

class HomeBrandListView extends StatelessWidget {
  HomeBrandListView({super.key});
  final VMHome data = Get.find();
  @override
  Widget build(BuildContext context) {
    return RxStatusView2(
        state: data.brandState,
        loader: const SizedBox.shrink(),
        builder: () {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeSectionTitleView(title: 'Trusted Brands'),
              LayoutBuilder(builder: (context, constraints) {
                final ratio = constraints.maxWidth / 100;
                return SizedBox(
                  height: 100,
                  child: CarouselSlider(
                    items: data.brands
                        .map((brand) => AspectRatio(
                              aspectRatio: 2,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 2),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                      )
                                    ]),
                                child: WebImageView(
                                  brand.image.imageUrl,
                                ),
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                      enableInfiniteScroll: true,
                      aspectRatio: ratio,
                      viewportFraction: 0.5,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 1),
                      reverse: true,
                      // animateToClosest: true,
                    ),
                  ),
                );
              }),
            ],
          );
        });
  }
}
