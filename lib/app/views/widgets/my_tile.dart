import 'package:flutter/material.dart';
import 'package:neuss_utils/utils/constants.dart';

class MyTile extends StatelessWidget {
  const MyTile(
      {super.key,
      this.leading,
      this.trailing,
      this.title,
      this.subTitle,
      this.contentPadding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4)});

  final Widget? leading;
  final Widget? trailing;
  final Widget? title;
  final Widget? subTitle;
  final EdgeInsets contentPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: contentPadding,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (leading != null) leading!,
          hSpace16,
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) title!,
                if (subTitle != null) subTitle!,
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
