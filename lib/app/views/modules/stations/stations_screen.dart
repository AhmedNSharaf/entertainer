import 'package:enter_tainer/core/utils/app_extensions.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:neuss_utils/widgets/src/super_decorated_container.dart';
import 'package:neuss_utils/widgets/src/txt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:neuss_utils/home/home.dart';
import 'package:neuss_utils/utils/my_extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/routes/app_pages.dart';
import '../../../../core/services/location_services.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import '../main_screen/screens/product_details.dart' hide SizedBox;
import '../osm/super_osm_picker/views/full_map.dart';
import '../osm/super_osm_picker/views/zoom_widget.dart';
import 'stations_controller.dart';
import 'views/station_row_view.dart';

class StationsScreen extends StatelessWidget {
  StationsScreen({super.key});

  final StationsController controller = Get.put(StationsController());

  final List<String> stationFilters = [
    'كافة العروض',
    'مطاعم فاخرة',
    'مطاعم ومقاهى غير رسمية',
    'حانات وبارات',
    'مطاعم غير رسمية وكلبات خارجية',
    'اماكن التسلية والترفيه',
    'جمال ولياقة بدنيه',
    'فنادة عالمية',
  ];

  @override
  Widget build(BuildContext context) {
    final LatLng firstStationLatLng = LatLng(24.255951, 54.453478);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.markers.isNotEmpty) {
        final map = controller.mapController;
        final point = controller.markers.first.point;
        if (map.camera.center != point) {
          map.move(point, 15);
        }
      }
    });

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: SizedBox(
            height: 44,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => Navigator.of(context).maybePop(),
                  tooltip: 'رجوع',
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: stationFilters.length,
                    itemBuilder: (context, index) {
                      return Obx(() {
                        final isSelected =
                            controller.selectedStationFilter.value == index;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: GestureDetector(
                            onTap: () {
                              controller.selectedStationFilter.value = index;
                              controller.filterStationsByCategory(
                                stationFilters[index],
                              );
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
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.5,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  stationFilters[index],
                                  style: TextStyle(
                                    color:
                                        isSelected
                                            ? Colors.white
                                            : Colors.black,
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
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(() {
        return Stack(
          children: [
            FlutterMap(
              mapController: controller.mapController,
              options: MapOptions(
                initialCenter: firstStationLatLng,
                initialZoom: 13,
                interactionOptions: const InteractionOptions(
                  enableMultiFingerGestureRace: true,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.de/tiles/osmde/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                CurrentLocationLayer(
                  alignPositionOnUpdate: AlignOnUpdate.never,
                  alignDirectionOnUpdate: AlignOnUpdate.never,
                  style: const LocationMarkerStyle(
                    marker: DefaultLocationMarker(
                      child: Icon(Icons.navigation, color: Colors.white),
                    ),
                    markerSize: Size(30, 30),
                    markerDirection: MarkerDirection.heading,
                  ),
                ),
                MarkerClusterLayerWidget(
                  options: MarkerClusterLayerOptions(
                    maxClusterRadius: 45,
                    size: const Size(40, 40),
                    alignment: Alignment.center,
                    maxZoom: 15,
                    disableClusteringAtZoom: 15,
                    showPolygon: false,
                    spiderfyCluster: false,
                    markers: controller.markers,
                    builder: clusterBuilder,
                  ),
                ),
              ],
            ),
            Obx(() {
              final station = controller.selectedStationPopup.value;
              if (station == null) return const SizedBox.shrink();
              return Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(18),
                  child: InkWell(
                    onTap: () {
                      Get.to(
                        () => ProductDetailsPage(
                          productName: '${station.name}',
                          label: '${station.description}',
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  station.name ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed:
                                    () =>
                                        controller.selectedStationPopup.value =
                                            null,
                              ),
                            ],
                          ),
                          // const SizedBox(height: 4),
                          Text(
                            station.description ?? '',
                            style: const TextStyle(fontSize: 15),
                          ),
                          // const SizedBox(height: 4),
                          Text(
                            station.address ?? '',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                          // const SizedBox(height: 4),
                          Text(
                            station.filterCategory ?? '',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
            if (controller.selectedStationPopup.value != null)
              Positioned(
                bottom: 32,
                right: 16,
                child: Row(
                  children: [
                    FloatingActionButton(
                      heroTag: 'map',
                      mini: true,
                      backgroundColor: Colors.blueAccent,
                      child: const Icon(Icons.map, color: Colors.white),
                      onPressed: () async {
                        final station = controller.selectedStationPopup.value;
                        if (station?.latLong?.latitude != null &&
                            station?.latLong?.longitude != null) {
                          final url =
                              'https://www.google.com/maps/search/?api=1&query=${station!.latLong!.latitude},${station.latLong!.longitude}';
                          await launchUrl(Uri.parse(url));
                        }
                      },
                    ),
                    // const SizedBox(width: 12),
                    FloatingActionButton(
                      heroTag: 'directions',
                      mini: true,
                      backgroundColor: Colors.green,
                      child: const Icon(Icons.directions, color: Colors.white),
                      onPressed: () async {
                        final station = controller.selectedStationPopup.value;
                        if (station?.latLong?.latitude != null &&
                            station?.latLong?.longitude != null) {
                          try {
                            final userPosition =
                                await Geolocator.getCurrentPosition(
                                  desiredAccuracy: LocationAccuracy.high,
                                );
                            final distance = Geolocator.distanceBetween(
                              userPosition.latitude,
                              userPosition.longitude,
                              station!.latLong!.latitude!,
                              station.latLong!.longitude!,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'المسافة: ${(distance / 1000).toStringAsFixed(2)} كم',
                                ),
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('تعذر تحديد موقعك الحالي'),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            Positioned(
              bottom: 40,
              left: 10,
              child: ZoomWidget(controller.mapController),
            ),
            if (controller.isLoading.value)
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: LinearProgressIndicator(
                  color: Colors.blueAccent,
                  minHeight: 3,
                  backgroundColor: Color(0xFFE3F2FD),
                ),
              ),
          ],
        );
      }),
    );
  }

  Widget clusterBuilder(BuildContext context, List<Marker> markers) {
    return SuperDecoratedContainer(
      shape: BoxShape.circle,
      color: Get.theme.primaryColor,
      child: Center(child: Txt('${markers.length}', color: Colors.white)),
    );
  }
}

class StationInfoText extends StatelessWidget {
  final String label;
  final String value;
  const StationInfoText(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '$label :',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
                softWrap: false,
              ),
              // const SizedBox(width: 12),
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  softWrap: false,
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
