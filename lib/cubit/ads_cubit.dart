import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:meta/meta.dart';

import '../models/ads.models.dart';

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  AdsCubit() : super(AdsInitial(ads:[]));

  Future<void> getAds() async {
    emit(AdsLoading());
    var adsData = await rootBundle.loadString('assets/data/sample.json');
    // final data = await json.decode(adsData);
    var dataDecoded =
    List<Map<String, dynamic>>.from(jsonDecode(adsData)['ads']);
    emit(AdsInitial(ads: dataDecoded.map((e) => Ad.fromJson(e)).toList()));


    // final String response = await rootBundle.loadString('assets/sample.json');
    // final data = await json.decode(response);
  }

}
