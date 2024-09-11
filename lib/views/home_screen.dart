import '../controllers/food_detail_controller.dart';
import '../controllers/home_controller.dart';
import '../tools/app_colors.dart';
import 'food_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, HomeController homeController, child) {
        if (homeController.chineseFoodModel.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 50),
              ClipOval(
                child: SvgPicture.asset('assets/image/logosvg.svg'),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(
                  left: 12.0,
                  right: 12.0,
                  top: 30.0,
                  bottom: 20.0,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemCount: homeController.chineseFoodModel.length,
                itemBuilder: (context, index) {
                  final foodItem = homeController.chineseFoodModel[index];
                  return Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 1.2,
                        color: AppColors.transparent,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 5.5,
                          width: MediaQuery.of(context).size.width / 2.33,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage('assets/image/cardbg.png'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 44.0),
                                  child: Text(
                                    foodItem.title ?? '',
                                    style: const TextStyle(
                                      color: AppColors.textBackup,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'ZhiMangXing',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.importans,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: AppColors.cardBorderbackup,
                                          width: 0.5,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: Text(
                                          foodItem.difficulty ?? ' ',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: AppColors.white,
                                            fontFamily: 'ZhiMangXing',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ChangeNotifierProvider(
                                              create: (_) => FoodDetailController(),
                                              child: FoodDetailScreen(foodId: foodItem.id ?? ''),
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Icon(
                                        Icons.arrow_forward,
                                        size: 20,
                                        color: AppColors.importans,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: ClipOval(
                          child: Image.network(
                            foodItem.image ?? 'Image',
                            width: 96,
                            height: 96,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
