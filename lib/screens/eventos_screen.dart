import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:psmnn/models/event_model.dart';
import 'package:psmnn/models/post_model.dart';
import 'package:psmnn/utils.dart';
import 'package:table_calendar/table_calendar.dart';

import '../database/database_helper.dart';

class EventosScreen extends StatefulWidget {
  const EventosScreen({super.key});

  @override
  State<EventosScreen> createState() => _EventosScreenState();
}

class _EventosScreenState extends State<EventosScreen> {
  DatabaseHelper? database;

  EventModel? objEventModel;

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Map<DateTime, List> events = {};
  List<EventModel> eventDetails = List.empty();

  @override
  void initState() {
    super.initState();

    database = DatabaseHelper();
    _cargarEventos();
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

  bool isChecked = false;

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

  _cargarEventos() async {
    List<EventModel> loadedEvents =
        (await database!.GETALLEVENT()).cast<EventModel>();
    setState(() {
      events = {};
      for (EventModel event in loadedEvents) {
        DateTime eventDate = DateTime.parse(event.fechaEvemt!);
        if (events[eventDate] == null) {
          events[eventDate] = [event];
        } else {
          events[eventDate]!.add(event);
        }
      }
    });
  }

  _cargarEventos2() async {
    return eventDetails = (await database!.GETALLEVENT()).cast<EventModel>();
  }

  List _EventosxDia(DateTime day) {
    return events[day] ?? [];
  }

  bool light = true;
  bool? cambio = false;
  bool dia = false;

  int cont = 0;

  @override
  Widget build(BuildContext context) {

    bool isCompletado = false;

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
              ? Expanded(
                  child: Column(
                    children: [
                      TableCalendar(
                        calendarFormat: _calendarFormat,
                        focusedDay: _focusedDay,
                        firstDay: kFirstDay,
                        locale: 'es_ES',
                        lastDay: kLastDay,
                        selectedDayPredicate: (day) =>
                            isSameDay(_selectedDay, day),
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
                        eventLoader: _EventosxDia,
                        onDaySelected: _onDaySelected,
                        availableGestures: AvailableGestures.all,
                        calendarBuilders: CalendarBuilders(
                          markerBuilder: (context, day, events) {
                            BoxDecoration? decoration;
                            TextStyle? textStyle;
                            int daysDifference =
                                day.difference(DateTime.now()).inDays;
                            if (events.isNotEmpty) {
                              for (var element in eventDetails) {
                                DateTime eventDate =
                                    DateTime.parse(element.fechaEvemt!);
                                if (eventDate == day) {
                                  isCompletado = element.completado!;
                                }
                              }
                              if (daysDifference == 0 || isCompletado) {
                                decoration = const BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.green);
                              } else if (daysDifference == 1 ||
                                  daysDifference == 2) {
                                // Event is in 1 or 2 days
                                decoration = const BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.yellow,
                                );
                              } else if (daysDifference < 0) {
                                // Event has passed and not completed
                                decoration = const BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.red,
                                );
                              } else if (daysDifference > 2) {
                                decoration = const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                );
                              }
                              return Container(
                                width: 22,
                                height: 22,
                                decoration: decoration,
                                child: Center(
                                  child: Text(
                                      events.isNotEmpty
                                          ? '${_EventosxDia(day).length}'
                                          : '',
                                      style: textStyle),
                                ),
                              );
                            }
                          },
                        ),
                        onDayLongPressed: (selectedDay, focusedDay) async {
                          await _cargarEventos2();
                          for (var element in eventDetails) {
                            DateTime eventDate =
                                DateTime.parse(element.fechaEvemt!);
                            if (eventDate.day == focusedDay.day) {
                              objEventModel = element;
                              break;
                            } else {
                              objEventModel = null;
                            }
                          }
                          setState(() {
                            _showEventDetails(focusedDay);
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text('Codigo colores', style: TextStyle(color: Color.fromARGB(255, 28, 135, 32), fontSize: 20),),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(10), color: Colors.green,),
                              margin: EdgeInsets.all(5),
                              height: 50,
                              child: const Center(child: Text('Eventos completados')),
                            ),
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(10), color: Colors.yellow,),
                              margin: EdgeInsets.all(5),
                              height: 50,
                              child: const Center(child: Text('Eventos a menos de 2 dias')),
                            ),
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(10), color: Colors.blue,),
                              margin: EdgeInsets.all(5),
                              height: 50,
                              child: const Center(child: Text('Eventos proximos')),
                            ),
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(10), color: Colors.red,),
                              margin: EdgeInsets.all(5),
                              height: 50,
                              child: const Center(child: Text('Eventos no completados')),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Expanded(
                  child: FutureBuilder(
                      future: database?.GETALLEVENT(),
                      builder: (context, snapshot) {
                        List<EventModel>? evemtos = snapshot.data;
                        if (evemtos == null || evemtos.isEmpty) {
                          return Container(
                            child: const Text(
                              "No hay eventos",
                              style: TextStyle(color: Colors.orange),
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: evemtos.length,
                          itemBuilder: (context, idx) {
                            var colorS;
                            EventModel c = evemtos[idx];
                            DateTime eventDate = DateTime.parse(c.fechaEvemt!);
                            int daysDifference =
                                eventDate.difference(DateTime.now()).inDays;
                            if (daysDifference == 0 || c.completado!) {
                              colorS = Colors.green;
                            } else if (daysDifference == 1 ||
                                daysDifference == 2) {
                              // Event is in 1 or 2 days
                              colorS = Colors.yellow;
                            } else if (daysDifference < 0) {
                              // Event has passed and not completed
                              colorS = Colors.red;
                            } else if (daysDifference > 2) {
                              colorS = Colors.blue;
                            }
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  ListTile(
                                    tileColor: colorS,
                                    title: Center(
                                        child: Text(c.dscEvent.toString())),
                                    subtitle: Center(
                                        child: Text(DateFormat('yyyy-MM-dd')
                                            .format(DateTime.parse(
                                                c.fechaEvemt.toString())))),
                                    onTap: () {},
                                  ),
                                  Row(
                                    children: [
                                      Expanded(child: Container()),
                                      IconButton(
                                        onPressed: () async {
                                          descpController.text = c.dscEvent!;
                                          bool changed = c.completado!;
                                          await showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                    'Actualiza la Tarea',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  content: StatefulBuilder(
                                                      builder:
                                                          (BuildContext context,
                                                              StateSetter
                                                                  setState) {
                                                    return Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        TextField(
                                                          controller:
                                                              descpController,
                                                          decoration:
                                                              const InputDecoration(
                                                                  labelText:
                                                                      'Descripción del evento'),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Checkbox(
                                                                value: changed,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    changed =
                                                                        value!;
                                                                  });
                                                                }),
                                                            const Text(
                                                                'Marcar como completado'),
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  }),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        if (descpController
                                                            .text.isEmpty) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            const SnackBar(
                                                              content: Text(
                                                                  'Se requiere descripción'),
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          2),
                                                            ),
                                                          );
                                                          return;
                                                        } else {
                                                          database?.UPDATEevent(
                                                              'tblEvent', {
                                                            'idEvent':
                                                                c.idEvent,
                                                            'dscEvent':
                                                                descpController
                                                                    .text,
                                                            'completado':
                                                                changed == true
                                                                    ? 1
                                                                    : 0,
                                                          }).then((value) {
                                                            var msg = value > 0
                                                                ? 'Registro actualizado'
                                                                : 'Error';
                                                            var snackBar =
                                                                SnackBar(
                                                                    content: Text(
                                                                        msg));
                                                            descpController
                                                                .clear();
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    snackBar);
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {});
                                                          });
                                                        }
                                                      },
                                                      child: const Text('OK'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          const Text('Cancel'),
                                                    )
                                                  ],
                                                );
                                              });
                                        },
                                        icon: const Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text(
                                                  'Confirmar el Borrado'),
                                              content: const Text(
                                                  'Se borrara la tarea seleccionado'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    database?.DELETEevent(
                                                            'tblEvent',
                                                            c.idEvent!)
                                                        .then((value) {
                                                          setState(() {});
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Cancel'),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.delete),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEventDialog(),
        label: const Text('Add Event'),
        backgroundColor: const Color.fromARGB(255, 116, 148, 116),
        icon: const Icon(Icons.add_task),
      ),
      floatingActionButtonLocation: light == false
          ? FloatingActionButtonLocation.startFloat
          : FloatingActionButtonLocation.endFloat,
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

    descpController.clear();

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
                    Text(
                        'Fecha: ${DateFormat('yyyy-MM-dd').format(_selectedDay!)}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.green)),
                    TextField(
                      controller: descpController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: 'Descripción',
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                            fillColor:
                                MaterialStateProperty.resolveWith(getColor),
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value!;
                              });
                            }),
                        const Text('Marcar como completado'),
                      ],
                    ),
                  ],
                );
              }),
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
                      database?.INSERT('tblEvent', {
                        'dscEvent': descpController.text,
                        'fechaEvent': _selectedDay.toString(),
                        'completado': isChecked == true ? 1 : 0,
                      }).then((value) {
                        var msj = value > 0
                            ? 'Registro insertado'
                            : 'ocurrio un error';

                        var snackBar = SnackBar(content: Text(msj));
                        descpController.clear;
                        _cargarEventos();

                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });

                      setState(() {});
                    }
                  },
                )
              ],
            ));
  }

  _showEventDetails(DateTime focusedDay) async {
    bool changed = false;
    String comp = 'No hay eventos disponibles';
    if (objEventModel != null) {
      comp = objEventModel!.dscEvent.toString();
      changed = objEventModel!.completado!;
      focusedDay = DateTime.parse(objEventModel!.fechaEvemt.toString());
    }
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Detalles del evento.',
              textAlign: TextAlign.center,
            ),
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Fecha: ${DateFormat('yyyy-MM-dd').format(focusedDay)}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.green),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Descripción: $comp',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  Row(
                    children: [
                      Checkbox(value: changed, onChanged: null),
                      const Text('¿Completado?'),
                    ],
                  ),
                ],
              );
            }),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              )
            ],
          );
        });
  }
}
