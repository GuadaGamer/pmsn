class EventModel {
  int? idEvent;
  String? dscEvent;
  String? fechaEvemt;
  bool? completado;

  EventModel({this.idEvent, this.dscEvent, this.fechaEvemt, this.completado});
  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
        idEvent: map['idEvent'],
        dscEvent: map['dscEvent'],
        fechaEvemt: map['fechaEvent'],
        completado: map['completado'] == 0 ? false : true,);
  }
}
