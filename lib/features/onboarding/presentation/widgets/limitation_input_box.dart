// lib/features/onboarding/presentation/widgets/limitation_input_box.dart

import 'package:flutter/material.dart';
import 'package:fitness/common/res/colors.dart';
import 'limitation_chip.dart'; // Assuming they are in the same directory

class LimitationInputBox extends StatelessWidget {
  final List<String> mainLimitations;
  final List<String> selectedLimitations;
  final int maxSelections;
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onAddCustom;
  final Function(String) onToggle;

  const LimitationInputBox({
    super.key,
    required this.mainLimitations,
    required this.selectedLimitations,
    required this.maxSelections,
    required this.controller,
    required this.focusNode,
    required this.onAddCustom,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isMaxedOut = selectedLimitations.length >= maxSelections;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.cardDark.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: AppColors.primary,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Predefined Chips
          Wrap(
            spacing: 8.0,
            runSpacing: 0.0,
            children: mainLimitations
                .map((limitation) => LimitationChip(
                      limitation: limitation,
                      isSelected: selectedLimitations.contains(limitation),
                      isRemovable: false,
                      onTap: () => onToggle(limitation),
                    ))
                .toList(),
          ),

          // Manual Input Field
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            focusNode: focusNode,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => onAddCustom(),
            style: const TextStyle(color: AppColors.textPrimary),
            enabled: !isMaxedOut,
            decoration: InputDecoration(
              hintText: 'Type custom limitation here (e.g., Torn ACL)',
              hintStyle:
                  const TextStyle(color: AppColors.textSecondary, fontSize: 14),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              suffixIcon: IconButton(
                icon: Icon(Icons.add, color: AppColors.primary),
                onPressed: onAddCustom, // Hooked up the + button
              ),
            ),
          ),
          const Divider(height: 1, color: AppColors.dividerColor),

          // Counter
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '${selectedLimitations.length}/$maxSelections',
                style: TextStyle(
                  color: isMaxedOut ? AppColors.error : AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
