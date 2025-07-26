import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuss_utils/widgets/src/super_decorated_container.dart';
import 'package:neuss_utils/widgets/src/txt.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../models/station_model2.dart';

class StationRowView extends StatelessWidget {
  const StationRowView(this.stationModel, {super.key});

  final StationModel2 stationModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // boxShadow: [
        //   BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1),
        // ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // محتوى المحطة (نصوص)
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Txt(
                      "(${stationModel.id})",
                      isBold: true,
                      fontSize: 16,
                      letterSpacing: 2,
                    ),
                    const SizedBox(width: 8), // بدل hSpace8
                    Expanded(
                      child: Txt(
                        stationModel.stationName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        isBold: true,
                        fontSize: 16,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Txt("${'Status'.tr} : ", fontSize: 16, isBold: true),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color:
                            stationModel.status == 1
                                ? Colors.green
                                : Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Txt(
                        stationModel.status == 1 ? 'Open'.tr : 'Closed'.tr,
                        color: Colors.white,
                        fontSize: 14,
                        isBold: true,
                      ),
                    ),
                  ],
                ),
                Txt(
                  "${'Available Bays'.tr} : ${stationModel.numOfAvailableBays}",
                  fontSize: 16,
                ),
              ],
            ),
          ),

          // زر الاتجاهات (جوجل ماب)
          SuperDecoratedContainer(
            borderRadius: 30,
            color: Get.theme.primaryColor.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: IconButton(
                icon: Icon(
                  Icons.directions,
                  size: 30,
                  color: Get.theme.primaryColor,
                ),
                onPressed: () {
                  if (stationModel.address?.latitude != null &&
                      stationModel.address?.longitude != null) {
                    double? latitude = stationModel.address!.latitude;
                    double? longitude = stationModel.address!.longitude;

                    openGoogleMaps(latitude!, longitude!);
                  } else {
                    Get.snackbar(
                      "خطأ".tr,
                      "الموقع غير متاح".tr,
                      backgroundColor: Colors.red,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openGoogleMaps(double latitude, double longitude) async {
    String googleMapsUrl =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

    Uri uri = Uri.parse(googleMapsUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar(
        "خطأ".tr,
        "تعذر فتح خرائط Google".tr,
        backgroundColor: Colors.red,
      );
    }
  }
}
