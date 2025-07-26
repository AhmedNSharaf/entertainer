import 'package:enter_tainer/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:neuss_utils/widgets/src/txt.dart';

class TabItemSelector extends StatelessWidget {
  final bool isSelected;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const TabItemSelector({
    super.key,
    required this.isSelected,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.appMainColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow:
                isSelected
                    ? [
                      BoxShadow(
                        color: AppColors.appMainColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                    : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Txt(
                label,
                color: isSelected ? Colors.white : Colors.black54,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(width: 8),
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
