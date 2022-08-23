import 'package:flutter/material.dart';
import 'package:flutter_japanese_restaurant_app/core/app_extension.dart';
import '../../../core/app_color.dart';
import '../../../core/app_style.dart';
import '../../business_logic/cubits/theme/theme_cubit.dart';
import '../../data/model/food.dart';
import '../widget/custom_page_route.dart';
import '../screen/food_detail_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodListView extends StatelessWidget {
  const FoodListView(
      {Key? key, required this.foods, this.isReversedList = false})
      : super(key: key);

  final List<Food> foods;
  final bool isReversedList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 20, left: 10),
        scrollDirection: Axis.horizontal,
        itemCount: isReversedList ? 3 : foods.length,
        itemBuilder: (_, index) {
          Food food =
              isReversedList ? foods.reversed.toList()[index] : foods[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                CustomPageRoute(
                  child: FoodDetailScreen(food: food),
                ),
              );
            },
            child: Container(
              width: 160,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: context.read<ThemeCubit>().isLightTheme
                      ? Colors.white
                      : DarkThemeColor.primaryLight,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      food.image,
                      scale: 6,
                    ),
                    Text(
                      "\$${food.price}",
                      style: h3Style.copyWith(color: LightThemeColor.accent),
                    ),
                    Text(
                      food.name,
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ).fadeAnimation(0.7),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Padding(padding: EdgeInsets.only(right: 50));
        },
      ),
    );
  }
}