import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key, required this.colors, required this.onChange});

  final List<Color> colors;
  final void Function(Color selsctedColor) onChange;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int index = 0; index < widget.colors.length; index++)
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    selectedIndex = index;
                    widget.onChange(widget.colors[index]);
                    setState(() {});
                  },
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: widget.colors[index],
                    child: selectedIndex == index
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
        ],
      ),
    );
  }
}
