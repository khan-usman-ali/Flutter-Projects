import 'package:flutter/material.dart';

class DisplayProducts extends StatelessWidget {
  final String title;
  final double price;
  final Color color;
  final String images;
  const DisplayProducts({
    super.key,
    required this.title,
    required this.price,
    required this.images,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          20,
        ),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(
            height: 5,
          ),
          Text(
            "\$$price",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(
            height: 5,
          ),
          Center(
            child: Image(
              image: AssetImage(images),
              height: 175,
            ),
          ),
        ],
      ),
    );
  }
}
