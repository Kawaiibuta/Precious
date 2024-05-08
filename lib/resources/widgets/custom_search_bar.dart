import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key, this.onFocus, this.onChange});
  final Function? onFocus;
  final void Function(String)? onChange;
  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus && widget.onFocus != null) {
        widget.onFocus!();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      // width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xfff3f4f6)),
      child: Row(
        children: [
          const Icon(Icons.search),
          Expanded(
              child: TextField(
            focusNode: focusNode,
            onChanged: widget.onChange,
            decoration: const InputDecoration.collapsed(
                hintText: "Search anything here"),
          ))
        ],
      ),
    );
  }
}
