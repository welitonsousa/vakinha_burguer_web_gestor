import 'package:dw10/src/core/ui/style/colors.dart';
import 'package:dw10/src/core/ui/style/theme.dart';
import 'package:dw10/src/models/enums/enum_menu.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final EnumMenu menu;
  final bool isSelected;
  final Function(EnumMenu) callBack;
  const MenuButton({
    super.key,
    required this.menu,
    required this.isSelected,
    required this.callBack,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => callBack.call(menu),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.only(left: 5),
        decoration: isSelected
            ? BoxDecoration(
                color: context.colors.secondary.withOpacity(.1),
                borderRadius: BorderRadius.circular(10),
              )
            : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 10),
            Image.asset(
              'assets/images/icons/${isSelected ? menu.assetIconSelected : menu.assetIcon}',
              height: 30,
              width: 30,
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                menu.label,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodySmall?.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
