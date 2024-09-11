import '../controllers/food_detail_controller.dart';
import '../tools/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodDetailScreen extends StatelessWidget {
  final String foodId;

  const FoodDetailScreen({
    Key? key,
    required this.foodId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller =
          Provider.of<FoodDetailController>(context, listen: false);
      controller.fetchFoodDetails(foodId);
    });

    return Consumer(
      builder: (context, FoodDetailController detailController, child) {
        // Veri yüklenmemişse yükleme göstergesi
        final foodDetails = detailController.detailFoodsModel;

        return SafeArea(
          child: Scaffold(
            floatingActionButton: InkWell(
              onTap: () => Navigator.pop(context),
              child: const CircleAvatar(
                backgroundColor: AppColors.yellow,
                child: Icon(
                  Icons.arrow_back,
                  size: 24,
                ),
              ),
            ),
            backgroundColor: AppColors.bg,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 20.0, bottom: 16.0),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width / 1.01,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                        image: DecorationImage(
                          image: NetworkImage('${foodDetails?.image}'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: double.maxFinite,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.yellow,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6.0, vertical: 2.0),
                                child: Text(
                                  '${foodDetails?.difficulty}',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.yellow,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6.0, vertical: 2.0),
                                child: Text(
                                  ' ${foodDetails?.portion}',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8.0),
                            ],
                          ),
                          const SizedBox(height: 6.0),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.yellow,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6.0, vertical: 2.0),
                            child: Text(
                              '${foodDetails?.time}',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            '${foodDetails?.title}',
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              '${foodDetails?.description}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ingredients ',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          ...?foodDetails?.ingredients
                              ?.map((ingredient) => Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      '* $ingredient',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ))
                              .toList(),
                          const SizedBox(height: 6.0),
                          const Text(
                            'Method',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          if (foodDetails?.method != null &&
                              foodDetails!.method!.isNotEmpty) ...[
                            for (int i = 0; i < foodDetails.method!.length; i++)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (foodDetails.method![i].steps != null &&
                                      foodDetails.method![i].steps!.isNotEmpty)
                                    for (int j = 0;
                                        j <
                                            foodDetails
                                                .method![i].steps!.length;
                                        j++)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 4.0, left: 10.0),
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Step ${i + 1}: ',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight
                                                      .w400, // Koyu (bold) yapmak için
                                                ),
                                              ),
                                              TextSpan(
                                                text: foodDetails
                                                    .method![i].steps![j],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight
                                                      .w300, // Normal yazı stili
                                                ),
                                              ),
                                            ],
                                          ),
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                ],
                              ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
