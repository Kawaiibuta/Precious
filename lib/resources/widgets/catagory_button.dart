import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryButton extends StatefulWidget {
  const CategoryButton(
      {super.key, required this.title, required this.selected, this.onClick});
  final String title;
  final bool selected;
  final Function? onClick;
  @override
  _CategoryButtonState createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: widget.selected ? Colors.black : Colors.white,
            border: Border.all(
                color: widget.selected ? Colors.black : Colors.grey)),
        child: InkWell(
          onTap: () {
            if (widget.onClick != null) widget.onClick!();
          },
          child: Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 5.0, bottom: 5.0),
            child: Text(
              widget.title,
              style: GoogleFonts.openSans(
                  fontWeight: FontWeight.bold,
                  color: widget.selected ? Colors.white : Colors.black),
            ),
          ),
        ));
  }
}
