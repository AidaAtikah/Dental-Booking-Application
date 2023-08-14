import 'package:flutter/material.dart';
import 'package:dental_check/Widget/appointment_builder.dart';
import 'package:dental_check/Widget/service_type_builder.dart';
import 'package:dental_check/Model/dental_service.dart';
import 'package:dental_check/Model/booking.dart';
import 'package:dental_check/Screen/service_form_page.dart';
import 'package:dental_check/Screen/booking_form_page.dart';
import 'package:dental_check/Databases/database_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
} 
class _HomePageState extends State<HomePage> {
  final DatabaseService _databaseService = DatabaseService();
  Future<List<Booking>> _getAppointments() async {
    return await _databaseService.appointments();
  } 

  Future<List<DentalService>> _getServicesType() async {
    return await _databaseService.servicestype();
  } 

  Future<void> _onAppointmentDelete(Booking appointment) async {
    await _databaseService.deleteAppointment(appointment.id);
    setState(() {});
  } 

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dental Clinic A&A'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Booking Appointment'),
              ), 
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Services'),
              ), 
            ],
          ), 
        ), 
        body: TabBarView(
          children: [
            AppointmentBuilder(
              future: _getAppointments(),
              onEdit: (value) {
                { 
                  Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                      builder: (_) => BookingFormPage(appointment: value),
                      fullscreenDialog: true,
                    ), 
                  ) 
                  .then((_) => setState(() {}));
                } 
              },
              onDelete: _onAppointmentDelete,
            ), 
            ServiceTypeBuilder(
            future: _getServicesType(),
            ), 
          ],
        ), 
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                .push(
                  MaterialPageRoute(
                    builder: (context) => const ServiceTypeFormPage(),
                    fullscreenDialog: true,
                  ), 
                ) 
                .then((_) => setState(() {}));
              },
              heroTag: 'addServiceType',
              child: const FaIcon(FontAwesomeIcons.plus),
            ), 
            const SizedBox(height: 12.0),
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                .push(
                  MaterialPageRoute(
                    builder: (context) => const BookingFormPage(),
                    fullscreenDialog: true,
                  ), 
                ) 
                .then((_) => setState(() {}));
              },
              heroTag: 'addAppointment',
              child: const FaIcon(FontAwesomeIcons.bookMedical),
            ), 
          ],
        ), 
      ), 
    ); 
  } 
} 