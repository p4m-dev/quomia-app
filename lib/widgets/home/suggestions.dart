import 'package:flutter/material.dart';
import 'package:quomia/http/timer_http.dart';
import 'package:quomia/models/box/timer.dart';

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
    return FutureBuilder<List<Timer>>(
        future: _timers,
        builder: (context, snapshot) {
          // Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error state
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No timers found'));
          }

          final timers = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: timers.length,
              itemBuilder: (context, index) {
                final timer = timers[index];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(
                        timer.avatar,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          timer.username,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        });
  }
}
