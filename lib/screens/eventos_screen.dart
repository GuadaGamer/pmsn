import 'package:flutter/material.dart';
import 'package:psmnn/models/event_model.dart';
import 'package:psmnn/utils.dart';
import 'package:table_calendar/table_calendar.dart';

import '../database/database_helper.dart';

class EventosScreen extends StatefulWidget {
  EventosScreen({super.key});

  DatabaseHelper database = DatabaseHelper();

  EventModel? objEventModel;

  @override
  State<EventosScreen> createState() => _EventosScreenState();
}

class _EventosScreenState extends State<EventosScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

  final titleController = TextEditingController();
  final descpController = TextEditingController();

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      // Thumb icon when the switch is selected.
      if (states.contains(MaterialState.selected)) {
        return const Icon(
          Icons.list_sharp,
          color: Colors.white,
        );
      }
      return const Icon(Icons.calendar_month, color: Colors.black);
    },
  );

  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuestros eventos'),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: light == true
                      ? const Text('Vista calendario')
                      : const Text('Vista en lista'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 14, 0),
                  child: Transform.scale(
                    scale: 2.0,
                    child: Switch(
                      activeColor: Color.fromARGB(255, 52, 138, 55),
                      thumbIcon: thumbIcon,
                      value: light,
                      onChanged: (bool value) {
                        setState(() {
                          light = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          light == true
              ? TableCalendar(
                  calendarFormat: _calendarFormat,
                  focusedDay: kToday,
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                )
              : const Text('Ok'),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEventDialog(),
        label: const Text('Add Event'),
      ),
    );
    // Center(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       const SizedBox(height: 20.0),
    //       ElevatedButton(
    //         child: Text('Basics'),
    //         onPressed: () => Navigator.push(
    //           context,
    //           MaterialPageRoute(builder: (_) => TableBasicsExample()),
    //         ),
    //       ),
    //       const SizedBox(height: 12.0),
    //       ElevatedButton(
    //         child: Text('Range Selection'),
    //         onPressed: () => Navigator.push(
    //           context,
    //           MaterialPageRoute(builder: (_) => TableRangeExample()),
    //         ),
    //       ),
    //       const SizedBox(height: 12.0),
    //       ElevatedButton(
    //         child: Text('Events'),
    //         onPressed: () => Navigator.push(
    //           context,
    //           MaterialPageRoute(builder: (_) => TableEventsExample()),
    //         ),
    //       ),
    //       const SizedBox(height: 12.0),
    //       ElevatedButton(
    //         child: Text('Multiple Selection'),
    //         onPressed: () => Navigator.push(
    //           context,
    //           MaterialPageRoute(builder: (_) => TableMultiExample()),
    //         ),
    //       ),
    //       const SizedBox(height: 12.0),
    //       ElevatedButton(
    //         child: Text('Complex'),
    //         onPressed: () => Navigator.push(
    //           context,
    //           MaterialPageRoute(builder: (_) => TableComplexExample()),
    //         ),
    //       ),
    //       const SizedBox(height: 20.0),
    //     ],
    //   ),
  }

  _showAddEventDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Añadir un nuevo evemto',
                  textAlign: TextAlign.center),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: descpController,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      labelText: 'Descripción',
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar')),
                TextButton(
                  child: const Text('Añadir evento'),
                  onPressed: () {
                    if (descpController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Se requiere descripción'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    } else {
                      print(descpController.text);

                      setState(() {});

                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ));
  }
}
