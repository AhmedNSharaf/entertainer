// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:neuss_utils/home/src/language_service.dart';
// import 'package:neuss_utils/utils/constants.dart';
// import 'package:neuss_utils/widgets/src/txt.dart';
//
// import '../../../../../core/utils/app_colors.dart';
// import '../stations_controller.dart';
// import '../stations_screen.dart';
//
// class SelectedStationInformation extends StatelessWidget {
//   SelectedStationInformation({super.key});
//   final StationsController controller = Get.put(StationsController());
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           vSpace8,
//           Row(
//             children: [
//               Align(
//                 alignment: LanguageService.to.alignmentReverse,
//                 child: IconButton(
//                   icon: const Icon(Icons.close),
//                   onPressed: () {
//                     controller.selectedStation = null;
//                   },
//                 ),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.center,
//                   child: IntrinsicWidth(
//                     child: Container(
//                       padding: const EdgeInsets.all(12),
//                       margin: const EdgeInsets.symmetric(vertical: 8),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(color: Colors.blue, width: 1.2),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.blue.withOpacity(0.08),
//                             blurRadius: 10,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Txt(
//                             '(${controller.selectedStation!.id})',
//                             isBold: true,
//                             letterSpacing: 2,
//                             fontSize: 18,
//                           ),
//                           hSpace8,
//                           Flexible(
//                             child: Txt(
//                               '${controller.selectedStation!.stationName}',
//                               isBold: true,
//                               letterSpacing: 2,
//                               fontSize: 18,
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           vSpace4,
//           Container(
//             padding: const EdgeInsets.all(12),
//             margin: const EdgeInsets.symmetric(vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: Colors.blue, width: 1.2),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.blue.withOpacity(0.08),
//                   blurRadius: 10,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Column(
//               children: [
//                 StationInfoText(
//                   'capacity'.tr,
//                   '${controller.selectedStation!.capacity}',
//                 ),
//                 StationInfoText(
//                   'Number Of Bays'.tr,
//                   '${controller.selectedStation!.numberOfBays}',
//                 ),
//                 StationInfoText(
//                   'Available Bays'.tr,
//                   '${controller.selectedStation!.numOfAvailableBays}',
//                 ),
//                 StationInfoText(
//                   'Maintenance Bays'.tr,
//                   '${controller.selectedStation!.numOfMaintenanceBays}',
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 4,
//                     horizontal: 12,
//                   ),
//                   child: Row(
//                     children: [
//                       Txt('Status: '.tr, fontSize: 20, isBold: true),
//                       const Spacer(),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 12,
//                           vertical: 6,
//                         ),
//                         decoration: BoxDecoration(
//                           color:
//                               controller.selectedStation!.status == 1
//                                   ? Colors.green
//                                   : Colors.red,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Txt(
//                           controller.selectedStation!.status == 1
//                               ? 'Open'.tr
//                               : 'Closed'.tr,
//                           color: Colors.white,
//                           fontSize: 16,
//                           isBold: true,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Divider(),
//               ],
//             ),
//           ),
//
//           controller.selectedStation?.stationBays != null &&
//                   controller.selectedStation!.stationBays!.isNotEmpty
//               ? Container(
//                 padding: const EdgeInsets.all(12),
//                 margin: const EdgeInsets.symmetric(vertical: 8),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.blue, width: 1.2),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.blue.withOpacity(0.08),
//                       blurRadius: 10,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: GestureDetector(
//                   onTap: () {
//                     final bays = controller.selectedStation!.stationBays!;
//                     final sortedBays = List.of(bays)..sort((a, b) {
//                       final aNum =
//                           int.tryParse(
//                             a.bayName?.replaceAll(RegExp(r'[^0-9]'), '') ?? '',
//                           ) ??
//                           0;
//                       final bNum =
//                           int.tryParse(
//                             b.bayName?.replaceAll(RegExp(r'[^0-9]'), '') ?? '',
//                           ) ??
//                           0;
//                       return aNum.compareTo(bNum);
//                     });
//                     showDialog(
//                       context: context,
//                       barrierDismissible: true,
//                       builder: (context) {
//                         return Dialog(
//                           insetPadding: EdgeInsets.zero,
//                           backgroundColor: Colors.transparent,
//                           child: Container(
//                             width: MediaQuery.of(context).size.width,
//                             margin: const EdgeInsets.all(16),
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(20),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.blue.withOpacity(0.08),
//                                   blurRadius: 10,
//                                   offset: const Offset(0, 4),
//                                 ),
//                               ],
//                               border: Border.all(
//                                 color: Colors.blue,
//                                 width: 1.2,
//                               ),
//                             ),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Icon(
//                                           Icons.storage,
//                                           color: AppColors.appMainColor,
//                                           size: 28,
//                                         ),
//                                         const SizedBox(width: 8),
//                                         Txt(
//                                           "Bays Info".tr,
//                                           fontSize: 20,
//                                           isBold: true,
//                                           color: AppColors.appMainColor,
//                                         ),
//                                       ],
//                                     ),
//                                     IconButton(
//                                       onPressed: () => Navigator.pop(context),
//                                       icon: const Icon(Icons.close),
//                                     ),
//                                   ],
//                                 ),
//                                 Divider(
//                                   height: 24,
//                                   color: AppColors.appMainColor.withOpacity(
//                                     0.3,
//                                   ),
//                                 ),
//                                 SingleChildScrollView(
//                                   scrollDirection: Axis.horizontal,
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       _TableColumn(
//                                         header: 'Bay'.tr,
//                                         items:
//                                             sortedBays
//                                                 .map(
//                                                   (bay) => bay.bayName ?? '---',
//                                                 )
//                                                 .toList(),
//                                       ),
//                                       const SizedBox(width: 6),
//                                       _TableStatusColumn(
//                                         header: 'Active'.tr,
//                                         items:
//                                             sortedBays
//                                                 .map((bay) => bay.bayActive)
//                                                 .toList(),
//                                       ),
//                                       const SizedBox(width: 6),
//                                       _TableStatusColumn(
//                                         header: 'Occupied'.tr,
//                                         items:
//                                             sortedBays
//                                                 .map((bay) => bay.bayStatus)
//                                                 .toList(),
//                                       ),
//                                       const SizedBox(width: 6),
//                                       _TableStatusColumn(
//                                         header: 'Healthy'.tr,
//                                         items:
//                                             sortedBays
//                                                 .map((bay) => bay.bayStatus)
//                                                 .toList(),
//                                       ),
//                                       const SizedBox(width: 6),
//                                       _TableStatusColumn(
//                                         header: 'Maintenance'.tr,
//                                         items:
//                                             sortedBays
//                                                 .map(
//                                                   (bay) => bay.bayMaintenance,
//                                                 )
//                                                 .toList(),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                   child: Container(
//                     width: double.infinity,
//                     margin: EdgeInsets.zero,
//                     padding: EdgeInsets.zero,
//                     child: StationInfoText(
//                       'Station Bays'.tr,
//                       'More Details ....'.tr,
//                     ),
//                   ),
//                 ),
//               )
//               : Container(
//                 width: double.infinity,
//                 margin: EdgeInsets.zero,
//                 padding: EdgeInsets.zero,
//                 child: StationInfoText('Station Bays'.tr, '---'.tr),
//               ),
//
//           Container(
//             padding: const EdgeInsets.all(12),
//             margin: const EdgeInsets.symmetric(vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: Colors.blue, width: 1.2),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.blue.withOpacity(0.08),
//                   blurRadius: 10,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Txt(
//                   'Station Address Info'.tr,
//                   fontSize: 18,
//                   isBold: true,
//                   color: AppColors.appMainColor,
//                 ),
//                 const SizedBox(height: 8),
//                 StationInfoText(
//                   'State'.tr,
//                   controller.selectedStation?.address?.state ?? 'No State'.tr,
//                 ),
//                 StationInfoText(
//                   'City'.tr,
//                   controller.selectedStation?.address?.city ?? 'No City'.tr,
//                 ),
//                 StationInfoText(
//                   'Latitude'.tr,
//                   controller.selectedStation?.address?.latitude?.toString() ??
//                       '---',
//                 ),
//                 StationInfoText(
//                   'Longitude'.tr,
//                   controller.selectedStation?.address?.longitude?.toString() ??
//                       '---',
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _TableColumn extends StatelessWidget {
//   final String header;
//   final List<String> items;
//
//   const _TableColumn({required this.header, required this.items});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.blue[100],
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: Txt(header, isBold: true, fontSize: 16),
//           ),
//         ),
//         const SizedBox(height: 12),
//         ...items.map(
//           (text) => Padding(
//             padding: const EdgeInsets.symmetric(vertical: 6),
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Txt(text, fontSize: 14),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _TableStatusColumn extends StatelessWidget {
//   final String header;
//   final List<bool?> items;
//
//   const _TableStatusColumn({required this.header, required this.items});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.blue[100],
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: Txt(header, isBold: true, fontSize: 16),
//           ),
//         ),
//         const SizedBox(height: 12),
//         ...items.map((status) {
//           final isActive = status == true;
//
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 6),
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               decoration: BoxDecoration(
//                 color: isActive ? Colors.green : Colors.red,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Txt(
//                 isActive ? ' ' : ' ',
//                 color: Colors.white,
//                 fontSize: 14,
//               ),
//             ),
//           );
//         }).toList(),
//       ],
//     );
//   }
// }
