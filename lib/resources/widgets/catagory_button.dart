import 'package:flutter/material.dart';

class CatagoryButton extends StatefulWidget {
  const CatagoryButton(
      {super.key,
      required this.icon,
      required this.title,
      required this.quantity});
  final IconData icon;
  final String title;
  final int quantity;
  @override
  _CatagoryButtonState createState() => _CatagoryButtonState();
}

class _CatagoryButtonState extends State<CatagoryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40), color: Colors.black),
        child: Row(
          children: [
            Icon(
              widget.icon,
              color: Colors.white,
              size: 30,
            ),
            Flexible(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    "${widget.quantity} products",
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
            ))
          ],
        ));
  }
}
