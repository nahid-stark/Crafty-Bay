import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:flutter/material.dart';

class SizePicker extends StatefulWidget {
  const SizePicker({super.key, required this.sizes, required this.onChange});

  final List<String> sizes;
  final void Function(String selectedSize) onChange;

  @override
  State<SizePicker> createState() => _SizePickerState();
}

class _SizePickerState extends State<SizePicker> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int index = 0; index < widget.sizes.length; index++)
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    selectedIndex = index;
                    widget.onChange(widget.sizes[index]);
                    setState(() {});
                  },
                  child: Container(
                    height: 37,
                    width: 37,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: index == selectedIndex ? AppColors.primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: selectedIndex == index ? AppColors.primaryColor : Colors.black54, width: 1.3),
                    ),
                    child: index == selectedIndex
                        ? Text(
                            widget.sizes[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : Text(
                            widget.sizes[index],
                            style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
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
