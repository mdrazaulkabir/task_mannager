import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_mannager/ui/ulits/asset_path.dart';
class ScreenBackground extends StatelessWidget {
  const ScreenBackground({super.key,required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          //'assets/images/background.svg',
          assetPath.backgroundSvg,
          fit: BoxFit.cover,
        ),
       child,
      ],
    );
  }
}
