import 'package:flutter/material.dart';
import 'package:proyecto_final_factores_flutter_web/app/utils/utils.dart';

class ItemMenu extends StatelessWidget {
  const ItemMenu({
    super.key,
    required this.iconData,
    required this.text,
    required this.onTap,
  });
  final IconData iconData;
  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    // color: Palette.orange,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Icon(
              iconData,
              color: Palette.mainBlue,
            ),
          ],
        ),
      ),
    );
  }
}
