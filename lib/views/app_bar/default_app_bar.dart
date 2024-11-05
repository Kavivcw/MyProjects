import 'package:flutter/material.dart';
import 'package:sparebess/shared/theme.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.leadingWidth,
  });
  final String title;
  final Widget? leading;
  final double? leadingWidth;
  final List<Widget>? actions;
  @override
  Size get preferredSize => const Size.fromHeight(44);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: appstyle.copyWith(color: Colors.white),
      ),
      forceMaterialTransparency: false,
      backgroundColor: appthemecolor1,
      foregroundColor: Colors.white,
      actions: actions,
      leading: leading,
      leadingWidth: leadingWidth,
    );
  }
}
