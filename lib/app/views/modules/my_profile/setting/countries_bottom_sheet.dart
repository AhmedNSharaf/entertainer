import 'package:enter_tainer/app/views/modules/stations/stations_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationBottomSheet extends StatefulWidget {
  const LocationBottomSheet({Key? key}) : super(key: key);

  @override
  State<LocationBottomSheet> createState() => _LocationBottomSheetState();
}

class _LocationBottomSheetState extends State<LocationBottomSheet> {
  String selectedLocation = 'البحرين'; // Default selected location

  final List<LocationData> locations = [
    LocationData(
      name: 'دبي والإمارات الشمالية',
      flagImage: 'assets/images/Flag_of_Jordan.png',
    ),
    LocationData(
      name: 'أبوظبي والعين',
      flagImage: 'assets/images/Flag_of_Jordan.png',
    ),
    LocationData(
      name: 'البحرين',
      flagImage: 'assets/images/Flag_of_Jordan.png',
    ),
    LocationData(name: 'الكويت', flagImage: 'assets/images/Flag_of_Jordan.png'),
    LocationData(name: 'قطر', flagImage: 'assets/images/Flag_of_Jordan.png'),
    LocationData(name: 'عمان', flagImage: 'assets/images/Flag_of_Jordan.png'),
    LocationData(
      name: 'المنطقة الشرقية',
      flagImage: 'assets/images/Flag_of_Jordan.png',
    ),
    LocationData(name: 'الرياض', flagImage: 'assets/images/Flag_of_Jordan.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close, color: Colors.black87),
                ),
                const Column(
                  children: [
                    Text(
                      'ابحث عن العروض من خلال الموقع',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Get.to(StationsScreen()),
                  icon: const Icon(
                    Icons.location_on_outlined,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // Location List
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: locations.length,
              itemBuilder: (context, index) {
                return LocationCard(
                  name: locations[index].name,
                  flagImage: locations[index].flagImage,
                  isSelected: selectedLocation == locations[index].name,
                  onTap: () {
                    setState(() {
                      selectedLocation = locations[index].name;
                    });
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class LocationData {
  final String name;
  final String flagImage;

  LocationData({required this.name, required this.flagImage});
}

class LocationCard extends StatelessWidget {
  const LocationCard({
    super.key,
    required this.name,
    required this.flagImage,
    required this.isSelected,
    required this.onTap,
  });

  final String name;
  final String flagImage;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: double.infinity,
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    // Flag Image
                    Image.asset(
                      flagImage,
                      width: 40,
                      height: 28,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 40,
                          height: 28,
                          color: Colors.grey.shade200,
                          child: Icon(
                            Icons.flag,
                            color: Colors.grey.shade400,
                            size: 16,
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 12),

                    // Location Name
                    Expanded(
                      child: Text(
                        name,
                        style: TextStyle(
                          color: isSelected ? Colors.green : Colors.black,
                          fontSize: 16,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),

                    // Selection Icon - Only show for selected items
                    if (isSelected)
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                  ],
                ),
              ),
              const Divider(thickness: 1),
            ],
          ),
        ),
      ),
    );
  }
}
