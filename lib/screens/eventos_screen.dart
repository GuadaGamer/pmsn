import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:psmnn/models/event_model.dart';
import 'package:psmnn/utils.dart';
import 'package:table_calendar/table_calendar.dart';

import '../database/database_helper.dart';

class EventosScreen extends StatefulWidget {
  const EventosScreen({super.key});

  @override
  State<EventosScreen> createState() => _EventosScreenState();
}

class _EventosScreenState extends State<EventosScreen> {
  DatabaseHelper database = DatabaseHelper();

  EventModel? objEventModel;

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();

     _selectedDay = _focusedDay;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

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
  bool? cambio = false;

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
                      activeColor: const Color.fromARGB(255, 52, 138, 55),
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
                  focusedDay: _focusedDay,
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
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
                  onDaySelected: _onDaySelected,
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
    bool isChecked = false;
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Añadir un nuevo evemto',
                  textAlign: TextAlign.center),
              content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Fecha: ${DateFormat('yyyy-MM-dd').format(_selectedDay!)}',
                        textAlign: TextAlign.center,style: const TextStyle(color: Colors.green)),
                      TextField(
                        controller: descpController,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: 'Descripción',
                        ),
                      ),
                      CheckboxListTile(
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: isChecked,
                        title: const Text('Evento completado'),
                        onChanged: (value) {
                          setState(() {
                            isChecked = value!;
                          });
                        }),
                    ],
                  );
                }
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
                      //print(descpController.text);
                      database.INSERT('tblEvent', {
                        'dscEvent': descpController.text,
                        'fechaEvent': _selectedDay.toString(),
                        'completado': cambio,
                      }).then((value) {
                        var msj = value > 0
                            ? 'Registro insertado'
                            : 'ocurrio un error';

                        var snackBar = SnackBar(content: Text(msj));

                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });

                      setState(() {});

                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ));
  }
}
