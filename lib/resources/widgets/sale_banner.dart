import 'package:flutter/material.dart';

class SaleBanner extends StatefulWidget {
  const SaleBanner(
      {super.key,
      required this.title,
      this.description,
      this.color,
      required this.image});
  final String title;
  final String? description;
  final Color? color;
  final ImageProvider<Object> image;
  @override
  _SaleBannerState createState() => _SaleBannerState();
}

class _SaleBannerState extends State<SaleBanner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 250,
      decoration: BoxDecoration(
        color: const Color(0xffdadada),
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: widget.image, fit: BoxFit.cover),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: widget.color),
            )
          ],
        ),
      ),
    );
  }
}
