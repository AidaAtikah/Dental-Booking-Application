import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dental_check/Widget/service_type_selector.dart';
import 'package:dental_check/Model/dental_service.dart';
import 'package:dental_check/Model/booking.dart';
import 'package:dental_check/Databases/database_service.dart';

class BookingFormPage extends StatefulWidget {
  const BookingFormPage({Key key, this.appointment}) : super(key: key);
  final Booking appointment;
  @override
  _BookingFormPageState createState() => _BookingFormPageState();
}

class _BookingFormPageState extends State<BookingFormPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  final TextEditingController _appdateController = TextEditingController();
  final TextEditingController _servicesController = TextEditingController();
  bool texterror = false;

  static final List<DentalService> _servicestype = [];
  final DatabaseService _databaseService = DatabaseService();
  int _selectedServiceType = 0;
  @override
  void initState() {
 
    super.initState();
    if (widget.appointment != null) {
      _nameController.text = widget.appointment.name;
      _emailController.text = widget.appointment.email;
      _contactNoController.text = widget.appointment.contactNo;
      _appdateController.text = widget.appointment.appdate;
      _servicesController.text = widget.appointment.servicetypeId as String;

    }
  }

  Future<List<DentalService>> _getServicesType() async {
    final servicestype = await _databaseService.servicestype();
    if (_servicestype.isEmpty) _servicestype.addAll(servicestype);
    if (widget.appointment != null) {
      _selectedServiceType = _servicestype.indexWhere((e) => e.id == widget.appointment.servicetypeId);
    }
    return _servicestype;
  }

  Future<void> _onSave() async {
    final name = _nameController.text;
    final email = _emailController.text;
    final contactNo = _contactNoController.text;
    final appdate = _appdateController.text;

    final servicetype = _servicestype[_selectedServiceType];
    
    widget.appointment == null
        ? await _databaseService.insertAppointment(
            Booking(
                name: name,
                email: email,
                contactNo: contactNo,
                appdate: appdate,
                servicetypeId: servicetype.id),
           
          )
        : await _databaseService.updateAppointment(
            Booking(
              id: widget.appointment.id,
              name: name,
              email: email,
              contactNo: contactNo,
              appdate: appdate,
              servicetypeId: servicetype.id,
            ),
          );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Appointment Record'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16.0),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person), 
                    border: OutlineInputBorder(),
                    hintText: 'Enter your name here',
                    errorText: texterror ? "Please Enter All Field" : null,
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email_outlined), 
                    border: OutlineInputBorder(),
                    hintText: 'Enter email here',
                    errorText: texterror ? "Please Enter All Field" : null,
                  ),
                ),
              
                const SizedBox(height: 16.0),
                TextField(
                  controller: _contactNoController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.phone), 
                    border: OutlineInputBorder(),
                    hintText: 'Enter contact number here',
                    errorText: texterror ? "Please Enter All Field" : null,
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _appdateController, 
                  decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today), 
                      border: OutlineInputBorder(),
                      hintText: "Enter Date", 
                      errorText: texterror ? "Please Enter All Field" : null,
                      ),
                  readOnly:
                      true, 
                  onTap: () async {
                    DateTime pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000), 
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(pickedDate); 
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(formattedDate);
                
                      setState(() {
                        _appdateController.text = formattedDate; 
                        texterror = false;
                      });
                    } else {
                      texterror = true;
                      
                    }
                  },
                ), 
             
                const SizedBox(height: 24.0),
                
                FutureBuilder<List<DentalService>>(
                  future: _getServicesType(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading services...");
                    }
                    return ServiceTypeSelector(
                      servicestype: _servicestype.map((e) => e.name).toList(),
                      selectedIndex: _selectedServiceType,
                      onChanged: (value) {
                        setState(() {
                          _selectedServiceType = value;
                        });
                      },
                    );
                  },
                ),
                const SizedBox(height: 24.0),
                SizedBox(
                  height: 45.0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_nameController.text.isEmpty ||
                          _emailController.text.isEmpty ||
                          _contactNoController.text.isEmpty) {
                        setState(() {
                          texterror = true;
                        });
                      } else {
                        setState(() {
                          _onSave();
                          texterror = false;
                        });
                      }
                    },
                    child: const Text(
                      'Book Appointment',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
