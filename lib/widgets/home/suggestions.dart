import 'package:flutter/material.dart';
import 'package:quomia/http/timer_http.dart';
import 'package:quomia/models/box/timer.dart';
import 'package:quomia/widgets/home/timer_suggestions_widget.dart';
import 'package:quomia/widgets/home/timer_suggestions_widget_placeholder.dart';

class TimerSuggestion extends StatefulWidget {
  const TimerSuggestion({super.key});

  @override
  State<TimerSuggestion> createState() => _TimerSuggestionState();
}

class _TimerSuggestionState extends State<TimerSuggestion> {
  late Future<List<Timer>> _timers;
  final HttpTimerService httpTimerService = HttpTimerService();

  @override
  void initState() {
    super.initState();
    _timers = httpTimerService.fetchTimers();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              print("error");
              return const Center(child: Text('No timers found'));
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
    );
  }
}
