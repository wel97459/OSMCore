import 'package:flutter/material.dart';
import 'package:chat_template/utils/avatar_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserAvatar extends StatelessWidget {
  final String handle;
  final IconData? iconData;
  final double size;

  const UserAvatar({
    super.key,
    required this.handle,
    this.iconData,
    this.size = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = AvatarUtils.getColorFromString(handle);
    final avatarText = AvatarUtils.getAvatarText(handle);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: iconData != null
          ? FaIcon(
              iconData,
              size: size * 0.5,
              color: Colors.white,
            )
          : Text(
              avatarText,
              style: TextStyle(
                color: Colors.white,
                fontSize: size * 0.45,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
