import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../utils/numbers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var sliderIndex = 0;
  CarouselController carouselControllerEx = CarouselController();
  List adsList=[1,2,3,4,5,6];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.symmetric(horizontal: Numbers.appHorizontalPadding),
          child: Icon(Icons.menu),)),
          body:SafeArea(
              child: Column(
                children: [
                  CarouselSlider(
                    carouselController: carouselControllerEx,
                    options: CarouselOptions(
                        autoPlay: true,
                        height: 200,
                        viewportFraction: .75,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        enlargeCenterPage: true,
                        onPageChanged: (index, _) {
                          sliderIndex = index;
                          setState(() {});
                        },
                        enlargeFactor: .3),
                    items: adsList.map((ad) {
                      return Stack(
                        children: [
                          Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(
                      color: Colors.amber
                          ),
                          )
                        ],
                      );
                    }).toList(),
                  ),
                  DotsIndicator(
                    dotsCount: adsList.length,
                    position: sliderIndex,
                    onTap: (position) async {
                      await carouselControllerEx.animateToPage(position);
                      sliderIndex = position;
                      setState(() {});
                    },
                    decorator: DotsDecorator(
                      size: const Size.square(9.0),
                      activeSize: const Size(18.0, 9.0),
                      activeColor: Colors.amber,
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                  //SectionHeader(sectionName: 'Today\'s Fresh Recipes'),
                  //SectionHeader(sectionName: 'New Ingredients'),
                ],
              ),
          ),
    );

  }
}
