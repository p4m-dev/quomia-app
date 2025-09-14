import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class LocationPicker extends StatefulWidget {
  final TextEditingController controller;
  final Function(double lat, double lng)? onLocationSelected;

  const LocationPicker({
    super.key,
    required this.controller,
    this.onLocationSelected,
  });

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  double? _latitude;
  double? _longitude;
  bool _loading = false;

  Future<void> _searchLocation() async {
    if (widget.controller.text.isEmpty) return;

    setState(() => _loading = true);

    try {
      final locations = await locationFromAddress(widget.controller.text);

      if (locations.isNotEmpty) {
        final loc = locations.first;
        setState(() {
          _latitude = loc.latitude;
          _longitude = loc.longitude;
        });

        if (widget.onLocationSelected != null) {
          widget.onLocationSelected!(loc.latitude, loc.longitude);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Trovata posizione: ${loc.latitude}, ${loc.longitude}",
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Errore: $e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: widget.controller,
                decoration: const InputDecoration(
                  hintText: "Es. Colosseo Roma",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci un luogo!';
                  }
                  return null;
                },
              ),
            ),
            IconButton(
              icon: _loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.search),
              onPressed: _loading ? null : _searchLocation,
            ),
          ],
        ),
        if (_latitude != null && _longitude != null) ...[
          const SizedBox(height: 8),
          Text(
            "Coordinate: $_latitude, $_longitude",
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ]
      ],
    );
  }
}
