import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:recipe_app/widgets/toast_message.widget.dart';

import '../models/ingredients.model.dart';
import '../utils/toast_msg_status.dart';

class IngredientsProvider extends ChangeNotifier {
  List<Ingredient>? _ingredientsList;

  List<Ingredient>? get ingredientsList => _ingredientsList;

  Future<void> getIngredients() async {
    try {
      var result =
      await FirebaseFirestore.instance.collection('ingredients').get();

      if (result.docs.isNotEmpty) {
        _ingredientsList = List<Ingredient>.from(
            result.docs.map((doc) => Ingredient.fromJson(doc.data(), doc.id)));
        print(_ingredientsList);
      } else {
        _ingredientsList = [];
        print("NOOOOOOOOOOOOOOOOOOO");
      }
      notifyListeners();
    } catch (e) {
      _ingredientsList = [];
      notifyListeners();
    }
  }

  Future<void> addIngredientToUser(String ingredientId, bool isAdd) async {
    try {
      OverlayLoadingProgress.start();
      if (isAdd) {
        await FirebaseFirestore.instance
            .collection('ingredients')
            .doc(ingredientId)
            .update({
         // "users_ids":[FirebaseAuth.instance.currentUser?.uid]  // That's not correct because it won't be added to the old list
          //override by using built in function inside firestore
          "users_ids":
          FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
        });
      } else {
        await FirebaseFirestore.instance
            .collection('ingredients')
            .doc(ingredientId)
            .update({
          "users_ids":
          FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
        });
      }
      OverlayLoadingProgress.stop();
      getIngredients();
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: ToastMessageWidget(
          message: 'Error : ${e.toString()}',
          toastMessageStatus: ToastMessageStatus.failed,
        ),
      );
    }
  }
}