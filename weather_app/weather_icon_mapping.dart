import 'package:flutter/material.dart';

class IconMapping extends StatelessWidget {
  final String iconName;

  IconMapping({super.key, required this.iconName});

  final Map<String, IconData> weatherIconMapping = {
    '01d': Icons.wb_sunny, // clear sky (day)
    '01n': Icons.nights_stay, // clear sky (night)
    '02d': Icons.cloud, // few clouds (day)
    '02n': Icons.cloud, // few clouds (night)
    '03d': Icons.cloud_queue, // scattered clouds (day)
    '03n': Icons.cloud_queue, // scattered clouds (night)
    '04d': Icons.cloud, // broken clouds (day)
    '04n': Icons.cloud, // broken clouds (night)
    '09d': Icons.grain, // shower rain (day)
    '09n': Icons.grain, // shower rain (night)
    '10d': Icons.grain, // rain (day)
    '10n': Icons.grain, // rain (night)
    '11d': Icons.flash_on, // thunderstorm (day)
    '11n': Icons.flash_on, // thunderstorm (night)
    '13d': Icons.ac_unit, // snow (day)
    '13n': Icons.ac_unit, // snow (night)
    '50d': Icons.blur_on, // mist (day)
    '50n': Icons.blur_on, // mist (night)
  };

  @override
  Widget build(BuildContext context) {
    {
      IconData? iconData = weatherIconMapping[iconName];
      return Icon(
        iconData,
        size: 32,
      );
    }
  }
}
