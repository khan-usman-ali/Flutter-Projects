import 'package:flutter/material.dart';
import 'package:weather_app/weather_icon_mapping.dart';
import 'package:intl/intl.dart';

class HourlyWeatherCard extends StatelessWidget {
  final String time;
  final IconMapping icon;
  final String temperature;

  const HourlyWeatherCard(
      {super.key,
      required this.time,
      required this.icon,
      required this.temperature});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateFormat("yyy-MM-dd HH:mm:ss").parse(time);

    return Card(
      elevation: 8,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        width: 100,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              DateFormat.Hm().format(dateTime),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 8,
            ),
            icon,
            const SizedBox(
              height: 8,
            ),
            Text(
              temperature,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
