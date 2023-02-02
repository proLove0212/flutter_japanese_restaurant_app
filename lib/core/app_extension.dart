import 'package:flutter/material.dart';
import 'package:flutter_japanese_restaurant_app/src/data/model/food.dart';
import 'package:flutter_japanese_restaurant_app/src/presentation/animation/fade_animation.dart';

extension StringExtension on String {
  String get toCapital => this[0].toUpperCase() + substring(1, length);
}

extension WidgetExtension on Widget {
  Widget fadeAnimation(double delay) => FadeAnimation(delay: delay, child: this);
}

extension IterableExtension on List<Food> {
  int getIndex(Food food) {
    int index = indexWhere((element) => element.id == food.id);
    return index;
  }
}
