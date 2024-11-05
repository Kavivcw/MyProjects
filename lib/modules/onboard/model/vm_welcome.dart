import 'package:sparebess/shared/constant.dart';

final class VMWelcomeContent {
  final String image;
  final String title;
  final String description;

  VMWelcomeContent(this.image, this.title, this.description);

  static List<VMWelcomeContent> list = [
    VMWelcomeContent('splash1', 'Welcome to $appName',
        'Explore a vast inventory of high-quality spare parts for your vehicles and appliances. Find exactly what you need with ease'),
    VMWelcomeContent('splash2', 'Seamless Navigation',
        'Our user-friendly interface makes it effortless to search and navigate through our extensive catalog. Browse by category, brand, or simple use our powerful search feature.'),
    VMWelcomeContent('splash3', 'Hassle-Free Checkout',
        'Enjoy a seamless shopping experience with our quick and secure checkout. Add items to your cart, review your order, and complete your purchase in just a few minutes'),
  ];
}
