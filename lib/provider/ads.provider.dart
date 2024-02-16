import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/ads.models.dart';


class AdsProvider extends ChangeNotifier {

  List<Ad>? _adsList;

  List<Ad>? get adsList => _adsList;

  Ad? _ad;

  Ad? get ad => _ad;

  int sliderIndex = 0;
  CarouselController? carouselController;

  void onPageChanged(int index) {
    sliderIndex = index;
    notifyListeners();
  }

  void disposeCarousel() {
    carouselController = null;
  }

  void onDotTapped(int position) async {
    await carouselController?.animateToPage(position);
    sliderIndex = position;
    notifyListeners();
  }

  void initCarousel() {
    carouselController = CarouselController();
  }

  Future<void> getAds() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('ads')
          //.where('isActive', isEqualTo: true)
          .get();  // get function return future

      if (result.docs.isNotEmpty) {
        _adsList = List<Ad>.from( //means get data from....
            result.docs.map((doc) => Ad.fromJson(doc.data(), doc.id)));
      } else {
        _adsList = [];
      }
      notifyListeners();
    } catch (e) {
      _adsList = [];
      notifyListeners();
    }
  }

  Future<void> getCertinAd(String id) async {
    try {
      var result =
      await FirebaseFirestore.instance.collection('ads').doc(id).get();
      if (result.exists) {
        _ad = Ad.fromJson(result.data() ?? {}, result.id);
      } else {
        _ad = null;
      }
      notifyListeners();
    } catch (e) {
      _ad = null;
      notifyListeners();
    }
  }
}

// Then we have to define this provider in main.dart