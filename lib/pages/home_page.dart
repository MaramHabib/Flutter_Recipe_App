import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/ads.models.dart';
import '../utils/colors.dart';
import '../utils/numbers.dart';
import '../widgets/section_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var sliderIndex = 0;
  CarouselController carouselControllerEx = CarouselController();

  List adsList=[];
  void getAds() async{
    var adsData=await rootBundle.loadString('assets/data/sample.json');
    var dataDecoded=List<Map<String,dynamic>>.from(jsonDecode(adsData)['ads']);
    adsList = dataDecoded.map((e) => Ad.fromJson(e)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.symmetric(horizontal: Numbers.appHorizontalPadding),
          child: Icon(Icons.menu),)),
          body:SafeArea(
              child: adsList.isEmpty
                ? const CircularProgressIndicator()
                : Column(
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
                            decoration:BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(ad.image!),
                                  fit:BoxFit.fitWidth,),
                                color: Colors.amber
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  ad.title.toString(),
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
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
                  const SectionHeader(sectionName: 'Today\'s Fresh Recipes'),
                  const SectionHeader(sectionName: 'New Ingredients'),
                  //*********** CARD Start *************
                  Card(
                    elevation: 2,
                    child: Container(
                        width: 240,
                        decoration: BoxDecoration(
                            color: const Color(
                              ColorsConst.containerBackgroundColor,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 15, left: 15),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.favorite_outline,
                                    color: Colors.grey,
                                  ),
                                  Transform.translate(
                                    offset:const  Offset(20, 0),
                                    child: Image.asset(
                                      'assets/images/frensh_toast.png',
                                      height: 140,
                                      width: 200,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  )
                                ],
                              ),
                              const Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Breakfast',
                                        style: TextStyle(
                                            color: Color(0xff1F95B3),
                                            fontSize: 13),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                      EdgeInsets.symmetric(vertical: 4),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Fresh Toast With Barries',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Color(ColorsConst.mainColor),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Color(ColorsConst.mainColor),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Color(ColorsConst.mainColor),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Color(ColorsConst.mainColor),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                      EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      children: [
                                        Text(
                                          '120 Calories',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color:
                                              Color(ColorsConst.mainColor),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 18,
                                        color: Colors.grey,
                                      ),
                                       SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        '10 mins',
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 18,
                                        color: Colors.grey,
                                      ),
                                       SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        '1 serving',
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                  const SectionHeader(sectionName: 'New Ingredients'),
                ],
              ),
          ),
    );

  }
}
