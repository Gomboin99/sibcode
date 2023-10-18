import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sibcode/features/presentaion/widgets/app_text.dart';


class AppAppBar extends StatefulWidget implements PreferredSizeWidget {
  const AppAppBar({
    required this.icon,
    required this.color,
    required this.onTap,
    this.text,
    super.key,
  });

  final String icon;
  final Color color;
  final String? text;
  final Function() onTap;

  @override
  State<AppAppBar> createState() => _AppAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppAppBarState extends State<AppAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.color,
      centerTitle: true,
      title: widget.text != null
          ? AppText(
              text: widget.text!,
              size: 18,
            )
          : null,
      leading: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => widget.onTap(),
        child: SvgPicture.asset(
          widget.icon,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
