import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    super.key,
    required this.onChange,
    required this.colorCodes,
  });

  final List<String> colorCodes;
  final void Function(String selsctedColorCode) onChange;

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
          for (int index = 0; index < widget.colorCodes.length; index++)
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    selectedIndex = index;
                    widget.onChange(widget.colorCodes[index]);
                    setState(() {});
                  },
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(int.parse(widget.colorCodes[index], radix: 16)),
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
