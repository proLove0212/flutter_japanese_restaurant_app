import 'package:flutter/material.dart';
import 'package:flutter_japanese_restaurant_app/core/app_extension.dart';
import 'package:flutter_japanese_restaurant_app/core/app_icon.dart';
import 'package:flutter_japanese_restaurant_app/src/data/model/food.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../core/app_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/blocs/food/food_bloc.dart';
import '../../business_logic/blocs/theme/theme_bloc.dart';
import '../widget/counter_button.dart';
import '../animation/scale_animation.dart';

class FoodDetailScreen extends StatelessWidget {
  const FoodDetailScreen({Key? key, required this.food}) : super(key: key);

  final Food food;

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Food Detail Screen",
        style: TextStyle(
            color: context.read<ThemeBloc>().isLightTheme
                ? Colors.black
                : Colors.white),
      ),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final List<Food> foodList = context.watch<FoodBloc>().state.foodList;

    Widget fab(VoidCallback onPressed) {
      return FloatingActionButton(
        elevation: 0.0,
        backgroundColor: LightThemeColor.accent,
        child: foodList[foodList.getIndex(food)].isFavorite
            ? const Icon(AppIcon.heart)
            : const Icon(AppIcon.outlinedHeart),
        onPressed: onPressed,
      );
    }

    return Scaffold(
      appBar: _appBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: fab(() => context
          .read<FoodBloc>()
          .add(FavoriteItemEvent(foodList[foodList.getIndex(food)]))),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: SizedBox(
          height: height * 0.5,
          child: Container(
            decoration: BoxDecoration(
              color: context.read<ThemeBloc>().isLightTheme
                  ? Colors.white
                  : DarkThemeColor.primaryLight,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        RatingBar.builder(
                          itemPadding: EdgeInsets.zero,
                          itemSize: 20,
                          initialRating: food.score,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          glow: false,
                          ignoreGestures: true,
                          itemBuilder: (context, _) => const FaIcon(
                            FontAwesomeIcons.solidStar,
                            color: LightThemeColor.yellow,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                        const SizedBox(width: 15),
                        Text(food.score.toString(),
                            style: Theme.of(context).textTheme.subtitle1),
                        const SizedBox(width: 5),
                        Text("(${food.voter})",
                            style: Theme.of(context).textTheme.subtitle1)
                      ],
                    ).fadeAnimation(0.4),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${food.price}",
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              ?.copyWith(color: LightThemeColor.accent),
                        ),
                        BlocBuilder<FoodBloc, FoodState>(
                          builder: (context, state) {
                            return CounterButton(
                              onIncrementSelected: () => context
                                  .read<FoodBloc>()
                                  .add(IncreaseQuantityEvent(food)),
                              onDecrementSelected: () => context
                                  .read<FoodBloc>()
                                  .add(DecreaseQuantityEvent(food)),
                              label: Text(
                                state.foodList[state.foodList.getIndex(food)]
                                    .quantity
                                    .toString(),
                                style: Theme.of(context).textTheme.headline1,
                              ),
                            );
                          },
                        )
                      ],
                    ).fadeAnimation(0.6),
                    const SizedBox(height: 15),
                    Text("Description",
                            style: Theme.of(context).textTheme.headline2)
                        .fadeAnimation(0.8),
                    const SizedBox(height: 15),
                    Text(
                      food.description,
                      style: Theme.of(context).textTheme.subtitle1,
                    ).fadeAnimation(0.8),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                        child: ElevatedButton(
                          onPressed: () => context
                              .read<FoodBloc>()
                              .add(AddToCartEvent(food)),
                          child: const Text("Add to cart"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: ScaleAnimation(
        child: Center(
          child: Image.asset(
            food.image,
            scale: 2,
          ),
        ),
      ),
    );
  }
}
