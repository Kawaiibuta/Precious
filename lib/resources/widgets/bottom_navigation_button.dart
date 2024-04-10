import 'package:flutter/material.dart';

class BottomNavigationButton extends StatefulWidget {
  const BottomNavigationButton(
      {super.key,
      this.title,
      required this.icon,
      this.splashColor,
      this.titleDecoration,
      this.showTitleSelected = false,
      this.selected = false,
      this.iconBackgroundColor,
      this.selectedIconColor,
      this.selectedIconBackgroundColor,
      this.titleBackgroundColor,
      this.selectedTitleBackgroundColor,
      this.onClick});
  final String? title;
  final IconData icon;
  final Color? splashColor;
  final TextStyle? titleDecoration;
  final bool showTitleSelected;
  final bool selected;
  final Color? selectedIconColor;
  final Color? iconBackgroundColor;
  final Color? selectedIconBackgroundColor;
  final Color? titleBackgroundColor;
  final Color? selectedTitleBackgroundColor;
  final Function? onClick;
  @override
  _BottomNavigationButtonState createState() => _BottomNavigationButtonState();
}

class _BottomNavigationButtonState extends State<BottomNavigationButton> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textSize = _textSize(widget.title ?? "",
        widget.titleDecoration ?? DefaultTextStyle.of(context).style);
    return InkWell(
        onTap: () {
          if (widget.onClick != null) widget.onClick!();
        },
        borderRadius: BorderRadius.circular(20),
        splashColor: widget.splashColor,
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 700),
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  height: 35,
                  width: 35,
                  duration: const Duration(milliseconds: 700),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.selected
                        ? widget.selectedIconBackgroundColor
                        : widget.iconBackgroundColor,
                  ),
                  child: Icon(widget.icon,
                      size: 25,
                      color: widget.selected ? widget.selectedIconColor : null),
                ),
                widget.showTitleSelected
                    ? AnimatedContainer(
                        margin: EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        duration: const Duration(milliseconds: 700),
                        width: widget.selected ? textSize.width : 0,
                        child: Text(
                          textAlign: TextAlign.center,
                          softWrap: false,
                          widget.title ?? "",
                          style: widget.titleDecoration,
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            )));
  }

  //get text size
  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}
