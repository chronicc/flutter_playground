class TimelineEvent {
  TimelineEvent({
    required this.description,
    required this.title,
    required this.time,
    this.topics = const {},
  });

  final String description;
  final DateTime time;
  final String title;
  final Set<String> topics;
}
