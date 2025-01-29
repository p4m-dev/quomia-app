import 'package:flutter/material.dart';
import 'package:quomia/theme/palette.dart';

class ChoiceChips extends StatefulWidget {
  const ChoiceChips({super.key});

  @override
  _ChoiceChipsState createState() => _ChoiceChipsState();
}

class _ChoiceChipsState extends State<ChoiceChips> {
  String? _selectedChip;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          child: Wrap(
            spacing: 10,
            runSpacing: 8,
            alignment: WrapAlignment.start,
            children: [
              _buildChoiceChip('immagini'),
              _buildChoiceChip('Video'),
              _buildChoiceChip('Audio'),
              _buildChoiceChip('Testo'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChoiceChip(String label) {
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          fontFamily: 'DM Sans',
          color: _selectedChip == label
              ? AppColors.light.primaryText
              : AppColors.light.secondaryText,
        ),
      ),
      selected: _selectedChip == label,
      selectedColor: AppColors.light.secondary,
      onSelected: (isSelected) {
        setState(() {
          _selectedChip = isSelected ? label : null;
        });
      },
      backgroundColor: AppColors.light.primaryBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }
}
