import 'package:enter_tainer/app/views/modules/main_screen/screens/details_grid_view.dart';
import 'package:enter_tainer/app/views/modules/main_screen/screens/grid_view_category.dart';
import 'package:enter_tainer/app/views/modules/main_screen/widgets/tab_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuss_utils/utils/constants.dart';
import '../../../controllers/app_controller.dart';
import '../../widgets/Home/img_slider.dart';
import '../../widgets/Home/more_3rood.dart';
import '../../widgets/Home/story_viewer.dart';
import '../../widgets/my_drawer.dart';
import '../others/base_main_screen.dart';

class MainScreen extends GetView<AppController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseMainScreen(
      title: "Home",
      preferredAppBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),

        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Row(
        //       children: [
        //         Icon(Icons.search, color: Colors.black),
        //         hSpace16,
        //         Image.asset(
        //           'assets/images/Flag_of_Jordan.png',
        //           width: 30,
        //           height: 30,
        //         ),
        //       ],
        //     ),
        //   ),
        // ],
      ),
      // drawer: const MyDrawer(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TopCategoryList(),
            vSpace8,
            ImageSlider(),
            vSpace8,
            MainGridViewCategory(),
            vSpace8,

            VideoSlider(),
            OffersSection(sectionTitle: 'أحدث العروض'),
            OffersSection(
              sectionTitle: 'العروض الشهرية',
              offers: monthlyOffers,
              onIconTap: () {
                Get.to(
                  () => DetailsGridView(
                    label: 'العروض الشهرية',
                    subCategories:
                        monthlyOffers.map((offer) {
                          return {
                            "image": offer["imageUrl"],
                            "name": offer["title"],
                            "location": offer["address"],
                            "cuisine": "فندق · عرض شهري",
                            "rating": 4.3,
                            "isFeatured": true,
                            "delivery": false,
                          };
                        }).toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
