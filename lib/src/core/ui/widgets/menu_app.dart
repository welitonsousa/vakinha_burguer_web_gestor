import 'package:animate_icons/animate_icons.dart';
import 'package:dw10/src/core/ui/style/colors.dart';
import 'package:dw10/src/core/ui/widgets/menu_button.dart';
import 'package:dw10/src/models/enums/enum_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MenuApp extends StatefulWidget {
  const MenuApp({super.key});

  @override
  State<MenuApp> createState() => _MenuAppState();
}

class _MenuAppState extends State<MenuApp> {
  final iconController = AnimateIconController();
  bool isMenuOpen = false;
  int selectedMenuIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: isMenuOpen ? 300 : 65,
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.only(right: 10),
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: context.colors.black.withOpacity(0.5),
              blurRadius: 2,
              offset: const Offset(1, 1),
            ),
          ]),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: AnimateIcons(
              startIcon: Icons.menu,
              endIcon: Icons.menu_open_outlined,
              endIconColor: context.colors.black,
              startIconColor: context.colors.black,
              duration: const Duration(milliseconds: 300),
              controller: iconController,
              onStartIconPress: () {
                setState(() {
                  isMenuOpen = true;
                });
                return true;
              },
              onEndIconPress: () {
                setState(() {
                  isMenuOpen = false;
                });
                return true;
              },
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: EnumMenu.values.length,
              itemBuilder: (c, i) {
                return MenuButton(
                  menu: EnumMenu.values[i],
                  isSelected: i == selectedMenuIndex,
                  callBack: (value) {
                    setState(() {
                      selectedMenuIndex = value.index;
                    });
                    Modular.to.navigate(value.route);
                  },
                );
              })
        ],
      ),
    );
  }
}
