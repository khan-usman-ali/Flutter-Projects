import 'package:flutter/material.dart';

class AdditionalInformation extends StatelessWidget {
  final IconData icon;
  final String info1;
  final String info2;
  const AdditionalInformation(
      {super.key,
      required this.icon,
      required this.info1,
      required this.info2});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Icon(
        icon,
        size: 40,
        color: Colors.white,
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        info1,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
      Text(
        info2,
        style: const TextStyle(fontSize: 20),
      ),
    ]);
  }
}
