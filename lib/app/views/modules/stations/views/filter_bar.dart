import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../stations_controller.dart';

class FilterBar extends StatelessWidget {
  final StationsController controller;
  const FilterBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final stationFilters = [
      'كافة العروض',
      'مطاعم فاخرة',
      'مطاعم ومقاهى غير رسمية',
      'حانات وبارات',
      'مطاعم غير رسمية وكلبات خارجية',
      'اماكن التسلية والترفيه',
      'جمال ولياقة بدنيه',
      'فنادة عالمية',
    ];

    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stationFilters.length,
        itemBuilder: (context, index) {
          return Obx(() {
            final isSelected = controller.selectedStationFilter.value == index;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: GestureDetector(
                onTap: () {
                  controller.selectedStationFilter.value = index;
                  controller.filterStationsByCategory(stationFilters[index]);
                  controller.moveToFirstStationOfCategory(
                    stationFilters[index],
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black, width: 1.5),
                  ),
                  child: Center(
                    child: Text(
                      stationFilters[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
