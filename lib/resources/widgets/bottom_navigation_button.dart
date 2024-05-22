import 'package:flutter/material.dart';
import 'package:precious/resources/app_export.dart';

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
            child: SizedBox(
              width: widget.showTitleSelected & widget.selected ? 96.h : null,
              child: Stack(
                alignment: Alignment.centerLeft,
                fit: StackFit.loose,
                children: [
                  widget.showTitleSelected & widget.selected
                      ? Positioned(
                          left: 24.h,
                          child: AnimatedContainer(
                            padding: EdgeInsets.only(
                                left: 12.h, right: 8.h, top: 2.v, bottom: 2.v),
                            decoration: BoxDecoration(
                              color: widget.selected
                                  ? widget.selectedTitleBackgroundColor
                                  : widget.titleBackgroundColor,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(26.h),
                                  bottomRight: Radius.circular(26.h)),
                            ),
                            duration: const Duration(milliseconds: 700),
                            child: Text(
                              textAlign: TextAlign.center,
                              softWrap: false,
                              widget.title ?? "",
                              style: widget.titleDecoration,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
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
                        color:
                            widget.selected ? widget.selectedIconColor : null),
                  )
                ],
              ),
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
