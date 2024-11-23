import 'package:flutter/material.dart';

class ChoiceChips extends StatefulWidget {
  const ChoiceChips({super.key});

  @override
  _ChoiceChipsState createState() => _ChoiceChipsState();
}

class _ChoiceChipsState extends State<ChoiceChips> {
  String? _selectedChip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
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
        ),
      ),
    );
  }

  Widget _buildChoiceChip(String label) {
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          fontFamily: 'DM Sans',
          color: _selectedChip == label ? Colors.white : Colors.grey,
          letterSpacing: 0.0,
        ),
      ),
      selected: _selectedChip == label,
      selectedColor: Theme.of(context).colorScheme.secondary,
      onSelected: (isSelected) {
        setState(() {
          _selectedChip = isSelected ? label : null;
        });
      },
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
