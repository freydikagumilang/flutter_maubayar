import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({    
    this.index = 0,
    this.isSelected = false,
    this.animationController,
    this.menu,
    this.icon,
  });


  String menu;
  IconData icon;
  bool isSelected;
  int index;

  AnimationController animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      index: 0,
      isSelected: true,
      animationController: null,
      menu:"Dashboard",
      icon: Icons.poll
    ),
    TabIconData(
      index: 1,
      isSelected: false,
      animationController: null,
      menu:"Data",
      icon: Icons.folder
    ),
    TabIconData(
      index: 2,
      isSelected: false,
      animationController: null,
      menu:"Biaya",
      icon: Icons.money_off
    ),
    TabIconData(
      index: 3,
      isSelected: false,
      animationController: null,
      menu:"Setting",
      icon: Icons.settings
    ),
  ];
}
