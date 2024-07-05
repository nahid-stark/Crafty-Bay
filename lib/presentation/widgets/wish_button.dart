import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:flutter/material.dart';

class WishButton extends StatelessWidget {
  const WishButton({
    super.key,
    this.showAddToWishList = true,
    this.isSelected = false,
    required this.onTap,
  });

  final bool showAddToWishList;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: showAddToWishList,
      replacement: _getIconButton(Icons.delete_outline_sharp),
      child: InkWell(
        onTap: onTap,
        child: _getIconButton(_getIconData()),
      ),
    );
  }

  Widget _getIconButton(IconData icon) {
    return Card(
      color: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Icon(
          icon,
          color: Colors.white,
          size: 19,
        ),
      ),
    );
  }

  IconData _getIconData() {
    return isSelected ? Icons.favorite : Icons.favorite_border_outlined;
  }
}
