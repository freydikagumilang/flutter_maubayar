import 'package:flutter/material.dart';

class MenuMasterData {
  MenuMasterData({    
    this.index = 0,
    this.direction,
    this.animationController,
    this.menu,
    this.icon,
  });


  String menu;
  IconData icon;
  String direction;
  int index;

  AnimationController animationController;

  static List<MenuMasterData> listmenu = <MenuMasterData>[
    MenuMasterData(
      index: 0,
      direction : "/kategori",
      animationController: null,
      menu:"Kategori",
      icon: Icons.account_tree
    ),
    MenuMasterData(
      index: 1,
      direction : "/produk",
      animationController: null,
      menu:"Item / Layanan",
      icon: Icons.article
    ),
    MenuMasterData(
      index: 2,
      direction : "/pelanggan",
      animationController: null,
      menu:"Pelanggan",
      icon: Icons.people
    ),
    MenuMasterData(
      index: 3,
      direction : "/kapster",
      animationController: null,
      menu:"Beautycian",
      icon: Icons.face
    ),
  ];
}
