import 'package:flutter/material.dart';
import 'package:our_spotify/common/helpers/is_dark_mode.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? action;
  final Color? backgroundColor;
  final bool hideback;
  const BasicAppBar(
      {super.key,
      this.title,
      this.hideback = false,
      this.action,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: title ?? const Text(''),
      actions: [
        action ?? Container(),
      ],
      leading: hideback
          ? null
          : IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: context.isDarkMode
                        ? Colors.white.withAlpha(10)
                        : Colors.black.withAlpha(10),
                    shape: BoxShape.circle),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 15,
                  color: context.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
