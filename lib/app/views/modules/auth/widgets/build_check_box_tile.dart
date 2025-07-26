import 'package:enter_tainer/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:neuss_utils/widgets/src/txt.dart';

class BuildCheckBoxTile extends StatelessWidget {
  const BuildCheckBoxTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.appMainColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        Flexible(child: Txt(title, fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}
