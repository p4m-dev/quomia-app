import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel extends StatelessWidget {
  const Carousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: CarouselSlider(
        items: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: const Image(
              image: AssetImage('assets/images/img_1.jpeg'),
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: const Image(
              image: AssetImage('assets/images/img_2.jpeg'),
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: const Image(
              image: AssetImage('assets/images/img_3.jpeg'),
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ],
        carouselController: CarouselSliderController(),
        options: CarouselOptions(
          initialPage: 1,
          viewportFraction: 0.5,
          disableCenter: true,
          enlargeCenterPage: true,
          enlargeFactor: 0.25,
          enableInfiniteScroll: true,
          scrollDirection: Axis.horizontal,
          autoPlay: true,
        ),
      ),
    );
  }
}
