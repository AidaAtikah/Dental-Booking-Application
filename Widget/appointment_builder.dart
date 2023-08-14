import 'package:flutter/material.dart';
import 'package:dental_check/Model/booking.dart';
import 'package:dental_check/Databases/database_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppointmentBuilder extends StatelessWidget {
  const AppointmentBuilder({Key key, this.future,  this.onEdit, this.onDelete, }) 
  : super(key: key);
  final Future<List<Booking>> future;
  final Function(Booking) onEdit;
  final Function(Booking) onDelete;
  Future<String> getServiceTypeName(int id) async {
    final DatabaseService _databaseService = DatabaseService();
    final servicetype = await _databaseService.servicetype(id);
    return servicetype.name;
  } 

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Booking>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) 
        { 
          return const Center(
          child: CircularProgressIndicator(),
          ); 
        } 
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.builder( 
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              final appointment = snapshot.data[index];
              return _buildAppointmentCard(appointment, context);
            },
          ), 
        ); 
      },
    ); 
  } 

  Widget _buildAppointmentCard(Booking appointment, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
              ), 
              alignment: Alignment.center,
              child: const FaIcon(FontAwesomeIcons.userDoctor, size: 18.0), 
            ), 
            const SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appointment.name,
                    style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                    FutureBuilder<String>(
                    future: getServiceTypeName(appointment.servicetypeId),
                    builder: (context, snapshot) {
                    return Text('Service: ${snapshot.data}');
                    },
                  ), 
                ],
              ), 
            ), 
            const SizedBox(width: 20.0),
            GestureDetector(
              onTap: () => onEdit(appointment),
              child: Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ), 
                alignment: Alignment.center,
                child: Icon(Icons.edit, color: Colors.orange[800]),
              ), 
            ), 
            const SizedBox(width: 20.0),
            GestureDetector(
              onTap: () => onDelete(appointment),
              child: Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ), 
                alignment: Alignment.center,
                child: Icon(Icons.delete, color: Colors.red[800]),
              ), 
            ), 
          ],
        ), 
      ), 
    ); 
  } 
} 