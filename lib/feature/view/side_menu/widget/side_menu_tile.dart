// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../../../../product/models/rive_asset.dart';

class SideMenuTile extends StatelessWidget {
  const SideMenuTile({
    Key? key,
    required this.menu,
    required this.press,
    required this.riveonInit,
    required this.isActive,
  }) : super(key: key);

  final RiveAsset menu;
  final VoidCallback press;
  final ValueChanged<Artboard> riveonInit;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Divider(color: Colors.white24, height: 1),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              height: 56,
              width: isActive ? 288 : 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF6792FF),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: press,
              leading: SizedBox(
                height: 34,
                width: 34,
                child: RiveAnimation.asset(menu.src,
                    // onInit: (artboard) {},
                    artboard: menu.artboard,
                    onInit: riveonInit),
              ),
              title: Text(
                menu.title,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
