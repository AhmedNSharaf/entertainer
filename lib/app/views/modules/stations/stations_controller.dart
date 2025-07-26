import 'dart:async';
import 'dart:convert';
import 'package:enter_tainer/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/extension_api.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:latlong2/latlong.dart';
import 'package:neuss_utils/image_utils/src/super_imageview.dart';
import 'package:neuss_utils/utils/helpers.dart';
import 'package:neuss_utils/utils/my_extensions.dart';
import 'package:neuss_utils/widgets/src/super_decorated_container.dart';
import 'package:neuss_utils/widgets/src/txt.dart';
import '../../../../core/services/location_services.dart';
import '../../../../core/services/offline_storage.dart';
import '../../../../core/utils/app_assets.dart';

import '../../../models/station_model.dart';
// لا داعي لاستيراد StationModel2

class StationsController extends GetxController {
  static StationsController get to => Get.find();

  ///region Vars
  RxList<Marker> markers = <Marker>[].obs;
  RxList<CircleMarker<Object>> circles = <CircleMarker>[].obs;

  final Rx<MapController> _mapController = MapController().obs;

  MapController get mapController => _mapController.value;

  set mapController(MapController val) => _mapController.value = val;

  final Rx<BoxController> _boxController = BoxController().obs;
  var isBoxOpen = true.obs;
  BoxController get boxController => _boxController.value;

  set boxController(BoxController val) => _boxController.value = val;
  var isBottomSheetOpen = true.obs;

  void toggleBottomSheet(bool isOpen) {
    isBottomSheetOpen.value = !isBottomSheetOpen.value;

    if (isBottomSheetOpen.value) {
      boxController.openBox();
    } else {
      boxController.closeBox();
    }
  }

  void refreshAll() {
    _mapController.refresh();
    _boxController.refresh();
    update();
  }

  final TextEditingController textEditingController = TextEditingController();

  final _popupController = PopupController().obs;

  PopupController get popupController => _popupController.value;

  set popupController(PopupController val) => _popupController.value = val;

  final RxBool _selectedAreas = false.obs;

  bool get selectedAreas => _selectedAreas.value;
  RxInt selectedStationFilter = 0.obs;

  set selectedAreas(dynamic val) => _selectedAreas.value = val;

  LatLng get defaultLatLng => const LatLng(25.2048, 55.2708); // Dubai, UAE

  final _allStations = <StationModel>[].obs;
  List<StationModel> get allStations => _allStations;
  set allStations(List<StationModel> val) => _allStations.value = val;
  final _displayStations = <StationModel>[].obs;
  List<StationModel> get displayStations => _displayStations;
  set displayStations(List<StationModel> val) => _displayStations.value = val;
  final Rxn<StationModel> _selectedStation = Rxn<StationModel>();
  StationModel? get selectedStation => _selectedStation.value;
  set selectedStation(StationModel? val) => _selectedStation.value = val;

  final RxBool isMapReady = false.obs;

  RxInt? selectedMarkerId = RxInt(-1);
  Rx<StationModel?> selectedStationPopup = Rx<StationModel?>(null);

  RxBool isLoading = false.obs;

  Color getCategoryColor(String? category) {
    switch (category) {
      case 'كافة العروض':
        return Colors.blueAccent;
      case 'مطاعم فاخرة':
        return Colors.redAccent;
      case 'مطاعم ومقاهى غير رسمية':
        return Colors.green;
      case 'حانات وبارات':
        return Colors.orange;
      case 'مطاعم غير رسمية وكلبات خارجية':
        return Colors.purple;
      case 'اماكن التسلية والترفيه':
        return Colors.teal;
      case 'جمال ولياقة بدنيه':
        return Colors.brown;
      case 'فنادة عالمية':
        return Colors.indigo;
      default:
        return Colors.grey;
    }
  }

  ///endregion Vars

  StationModel? getMarkerStation(id) => allStations.firstWhereOrNull(
    (station) => station.id.toString() == id.toString(),
  );
  Marker? getStationMarker(id) =>
      markers.firstWhereOrNull((marker) => marker.id == id.toString());
  var bottomSheetHeight = 0.4.h.obs;

  void initMarkers() {
    markers.clear();
    circles.clear();
    mPrint2('Stations count: ${allStations.length}');
    for (StationModel station in allStations) {
      print(
        'محطة: ${station.name}, lat: ${station.latLong?.latitude}, lng: ${station.latLong?.latitude}',
      );
      if (station.latLong?.latitude != null &&
          station.latLong?.longitude != null) {
        markers.add(generateMarker(station));
      }
    }
    print('عدد الماركرات بعد التحميل: ${markers.length}');
  }

  Future<List<StationModel>> readStationModel() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/json/stations.json',
      );
      final String cleanedResponse = response.replaceAll('\u{A0}', ' ').trim();

      final dynamic decodedJson = json.decode(cleanedResponse);

      mPrint('Decoded JSON: $decodedJson');

      if (decodedJson is! List) {
        mPrint('Error: JSON format is incorrect.');
        return [];
      }

      List<StationModel> stationsList =
          decodedJson
              .map((e) => StationModel.fromMap(e as Map<String, dynamic>))
              .toList();

      mPrint('Parsed Stations: ${stationsList.length}');

      return stationsList;
    } catch (e, stackTrace) {
      mPrint('Error loading stations: $e');
      mPrint(stackTrace.toString());
      return [];
    }
  }

  Future<void> initStations() async {
    List<StationModel> stationsData = await readStationModel();
    if (stationsData.isEmpty) {
      mPrint('⚠️ No stations loaded from JSON.'.tr);
      return;
    }
    allStations.assignAll(stationsData);
    displayStations.assignAll(allStations);
    mPrint('✅ Stations count after loading: ${allStations.length}'.tr);
  }

  // Add refresh timer
  Timer? _refreshTimer;

  @override
  void onInit() async {
    super.onInit();

    await initStations();

    if (allStations.isEmpty) {
      mPrint('🚫 لا يوجد محطات!');
      return;
    }

    initMarkers();
    loadStationsAndCircles();

    ever(markers, (_) {
      mPrint('🧭 تحديث عدد الماركرات: ${markers.length}');
    });

    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (timer) async {
      await refreshStationData();
    });
  }

  @override
  void onClose() {
    _refreshTimer?.cancel();
    super.onClose();
  }

  Future<void> refreshStationData() async {
    try {
      final stationsData = await readStationModel();
      if (stationsData.isNotEmpty) {
        allStations.assignAll(stationsData);
        displayStations.assignAll(allStations);
        initMarkers();
        loadStationsAndCircles();
        update();
        mPrint('تم تحديث بيانات المحطات بنجاح');
      }
    } catch (e) {
      mPrint('خطأ في تحديث بيانات المحطات: $e');
    }
  }

  Future<void> loadStationsAndCircles() async {
    mPrint("🚀 Loading stations... Total: ${allStations.length}".tr);
    if (allStations.isEmpty) return;
    circles.clear();
    for (var station in allStations) {
      if (station.latLong?.latitude != null &&
          station.latLong?.longitude != null) {
        mPrint(
          "📍 Adding station: ${station.name} at ${station.latLong?.longitude} latitude, ${station.address} longitude",
        );
        LatLng stationLatLng = LatLng(
          station.latLong!.latitude!,
          station.latLong!.longitude!,
        );
        circles.add(
          CircleMarker(
            point: stationLatLng,
            color: Colors.red.withOpacity(0.3),
            borderColor: Colors.red,
            borderStrokeWidth: 2,
            radius: 30,
          ),
        );
      }
    }
    update();
  }

  FutureOr<void> onWillPop(result) {
    boxController.isBoxOpen
        ? [boxController.closeBox(), _boxController.refresh()]
        : Get.back();
  }

  Marker generateMarker(StationModel station) {
    final isSelected = selectedMarkerId?.value == station.id;
    LatLng stationLatLng = LatLng(
      station.latLong?.latitude ?? 0.0,
      station.latLong?.longitude ?? 0.0,
    );
    return Marker(
      point: stationLatLng,
      width: isSelected ? 50 : 40,
      height: isSelected ? 50 : 40,
      key: ValueKey(station.id),
      child: GestureDetector(
        onTap: () {
          selectedMarkerId?.value = station.id ?? -1;
          selectedStationPopup.value = station;
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: getCategoryColor(station.filterCategory),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Icon(
            Icons.place,
            color: Colors.white,
            size: isSelected ? 30 : 20,
          ),
        ),
      ),
    );
  }

  void moveToUserLocation({double? zoom}) {
    zoom ??= mapController.camera.zoom < 14 ? 14 : mapController.camera.zoom;
    final LatLng targetLocation =
        (LocationService.to.userLatLng != null)
            ? LocationService.to.userLatLng!
            : const LatLng(24.4539, 54.3773);
    mapController.move(targetLocation, zoom);
  }

  void moveToUserLocation2(LatLng latLng, {double? zoom}) {
    zoom ??= mapController.camera.zoom < 14 ? 14 : mapController.camera.zoom;
    final LatLng targetLocation =
        (latLng.latitude != 0 && latLng.longitude != 0)
            ? latLng
            : const LatLng(24.4539, 54.3773); // Default to UAE
    mapController.move(targetLocation, zoom);
  }

  void moveToLocation(LatLng latLng, {double? zoom}) {
    mapController.move(latLng, zoom ?? mapController.camera.zoom);
  }

  void filterStationsByCategory(String? category) async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 400)); // لمحاكاة اللودينج
    if (category == null || category == 'كافة العروض') {
      displayStations = List.from(allStations);
    } else {
      displayStations =
          allStations.where((s) => s.filterCategory == category).toList();
    }
    updateMarkersFromDisplayStations();
    isLoading.value = false;
  }

  void updateMarkersFromDisplayStations() {
    markers.clear();
    for (var station in displayStations) {
      if (station.latLong?.latitude != null &&
          station.latLong?.longitude != null) {
        markers.add(generateMarker(station));
      }
    }
  }

  void moveToFirstStationOfCategory(String? category) {
    final filtered =
        (category == null || category == 'كافة العروض')
            ? allStations
            : allStations.where((s) => s.filterCategory == category).toList();
    if (filtered.isNotEmpty) {
      final station = filtered.first;
      if (station.latLong?.latitude != null &&
          station.latLong?.longitude != null) {
        mapController.move(
          LatLng(station.latLong!.latitude!, station.latLong!.longitude!),
          15,
        );
      }
    }
  }
}

LatLng defaultLatLng = LatLng(24.255953, 54.453474);
