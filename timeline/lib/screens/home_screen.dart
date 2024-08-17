import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:timeline/models/timeline_event.dart';
import 'package:timelines/timelines.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.events,
  });

  final List<TimelineEvent> events;

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  var _selectedTopics = List<String>.empty();

  @override
  Widget build(BuildContext context) {
    var events = widget.events.where((event) {
      if (_selectedTopics.isEmpty) {
        return true;
      }
      return event.topics.any((topic) => _selectedTopics.contains(topic));
    }).toList();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _selectedTopics = List<String>.empty();
              });
            },
          ),
          IconButton(
            icon: Badge.count(
              count: _selectedTopics.length,
              isLabelVisible: _selectedTopics.isNotEmpty,
              child: const Icon(Icons.filter_alt),
            ),
            onPressed: () => showDialog(
              context: context,
              builder: (context) {
                return MultiSelectDialog(
                  items: _buildTopics(widget.events),
                  initialValue: _selectedTopics,
                  listType: MultiSelectListType.CHIP,
                  onConfirm: (values) {
                    setState(() {
                      _selectedTopics = values;
                    });
                  },
                );
              },
            ),
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flutter Timeline Demo'),
      ),
      body: MyTimeline(events: events),
    );
  }

  List<MultiSelectItem<String>> _buildTopics(List<TimelineEvent> events) {
    final topics = events.fold<Set<String>>(
      {},
      (previousValue, element) => previousValue.union(element.topics),
    );

    final topicItems =
        topics.map((topic) => MultiSelectItem<String>(topic, topic)).toList();

    topicItems.sort((a, b) => a.value[0].compareTo(b.value[0]));
    return topicItems;
  }
}

class MyTimeline extends StatelessWidget {
  const MyTimeline({
    super.key,
    required this.events,
  });

  final List<TimelineEvent> events;

  @override
  Widget build(BuildContext context) {
    return Timeline.tileBuilder(
      theme: TimelineThemeData(
        color: Theme.of(context).colorScheme.primary,
        connectorTheme: const ConnectorThemeData(
          thickness: 4,
        ),
        indicatorTheme: const IndicatorThemeData(
          position: 0.5,
          size: 32,
        ),
        nodePosition: 0.3,
      ),
      builder: TimelineTileBuilder.connected(
        contentsAlign: ContentsAlign.basic,
        contentsBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
          child: Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    events[index].title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      DateFormat.yMMMd().format(events[index].time),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  Text(
                    events[index].description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      '#${events[index].topics.join(' #')}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        oppositeContentsBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            events[index].time.year.toString(),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        connectorBuilder: (context, index, type) {
          if (index == events.length - 1) {
            return const SizedBox();
          }
          return const SolidLineConnector();
        },
        indicatorBuilder: (context, index) {
          return DotIndicator(
            color: Theme.of(context).colorScheme.primary,
          );
        },
        itemCount: events.length,
      ),
    );
  }
}
