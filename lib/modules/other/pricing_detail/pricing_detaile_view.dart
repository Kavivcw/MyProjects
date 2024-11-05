import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sparebess/shared/constant.dart';
import 'package:sparebess/views/app_bar/default_app_bar.dart';

import '../../../shared/theme.dart';

class PricingDetailPolicyScreen extends StatelessWidget {
  PricingDetailPolicyScreen({super.key});

  final textGap = const Gap(10);

  Widget appText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        text,
        style: termstyle,
      ),
    );
  }

  final data = [
    "Pricing Details for $websiteName (Automotive Parts E-commerce Store):",
    "At $websiteName, we are dedicated to providing competitive and transparent pricing for our wide range of automotive parts. We believe in offering fair and affordable prices to ensure your satisfaction with every purchase. Here are the key details regarding our pricing",
    "Competitive Pricing: We continuously strive to offer competitive prices on all our automotive parts. We regularly monitor the market and adjust our prices accordingly to provide you with the best value for your money.",
    "Price Transparency: We are committed to maintaining transparency in our pricing. The displayed prices on our website are inclusive of all applicable taxes, duties, and fees. You can trust that the price you see is the final price you will pay at the time of checkout.",
    "Product Variations: Some automotive parts may have variations in pricing due to factors such as brand, quality, compatibility, or availability. We clearly display the price for each specific product variant, enabling you to make an informed decision based on your requirements and budget.",
    "Discounts and Promotions: We frequently offer discounts, promotions, and special deals on selected automotive parts. Keep an eye on our website or subscribe to our newsletter to stay updated on the latest offers and savings opportunities.",
    "Price Matching: We understand that finding the best price is important to our customers. If you come across a lower price for the same automotive part on a competitor's website, please reach out to us. We strive to match or beat competitor prices whenever possible, providing you with the best deal availableShipping costs are calculated separately and will be displayed during the checkout process. The shipping charges may vary depending on the destination, weight, and dimensions of the ordered items. We aim to provide competitive shipping rates and partner with reliable shipping carriers to ensure timely and secure delivery of your automotive parts.",
    "Currency and Payment Options: Our website supports multiple currencies to accommodate international customers. You can select your preferred currency from the options available. We accept various payment methods, including major credit cards, debit cards, and secure online payment gateways, to offer you convenience and flexibility.",
    "We strive to provide accurate and up-to-date pricing information on our website. However, in the unlikely event of a pricing error, we reserve the right to correct the price and notify you before processing your order.",
    "For any further inquiries or clarification regarding pricing, please feel free to contact our customer support team. We are here to assist you and ensure your satisfaction with our competitive and transparent pricing at $websiteName, your trusted automotive parts destination.",
    "Cancellation and Refund Policy for $websiteName (Automotive Parts E-commerce Store):At $websiteName, we understand that circumstances may arise where you need to cancel an order or seek a refund. We aim to make the cancellation and refund process as convenient and transparent as possible. ",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: 'Pricing Details'),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(hSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...data.map((e) => appText(e)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
