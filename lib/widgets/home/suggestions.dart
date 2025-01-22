import 'package:flutter/material.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/designSystem/label.dart';
import 'package:quomia/designSystem/label_placeholder.dart';
import 'package:quomia/http/timer_http.dart';
import 'package:quomia/models/box/timer.dart';
import 'package:quomia/widgets/home/timer_suggestions_widget.dart';
import 'package:quomia/widgets/home/timer_suggestions_placeholder.dart';

class TimerSuggestion extends StatefulWidget {
  const TimerSuggestion({super.key});

  @override
  State<TimerSuggestion> createState() => _TimerSuggestionState();
}

class _TimerSuggestionState extends State<TimerSuggestion> {
  late Future<List<Timer>> _timers;
  final HttpTimerService httpTimerService = HttpTimerService();
  bool _isLoading = true;

  Future<void> _loadTimers() async {
    try {
      _timers = httpTimerService.fetchTimers();
      await _timers;
    } catch (e) {
      debugPrint('Errore durante il caricamento dei timers: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadTimers();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        _isLoading
            ? const LabelPlaceholder()
            : const Label(data: 'I miei suggerimenti', fontSize: 24),
        const Gap(
          height: 8.0,
        ),
        SizedBox(
          height: 120,
          child: FutureBuilder<List<Timer>>(
              future: _timers,
              builder: (context, snapshot) {
                // Loading state
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const TimerSuggestionsPlaceholderWidget();
                }

                // Error state
                if (snapshot.hasError) {
                  return const TimerSuggestionsPlaceholderWidget();
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No timers found'));
                }

                final timers = snapshot.data!;

                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: timers.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return TimerSuggestionsWidget(timer: timers[index]);
                    });
              }),
        ),
      ],
    );
  }
}
