import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mapsuygulama/product/utils/const/string_const.dart';

class AboutMeWidget extends StatelessWidget {
  const AboutMeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Text(
        aboutMeText.tr(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
