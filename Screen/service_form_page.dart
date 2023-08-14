import 'package:flutter/material.dart';
import 'package:dental_check/Model/dental_service.dart';
import 'package:dental_check/Databases/database_service.dart';

class ServiceTypeFormPage extends StatefulWidget {
  const ServiceTypeFormPage({Key key}) : super(key: key);
  @override
  _ServiceTypeFormPageState createState() => _ServiceTypeFormPageState();
} 

class _ServiceTypeFormPageState extends State<ServiceTypeFormPage> {
  final TextEditingController _nameController = TextEditingController(); 
  final TextEditingController _descController = TextEditingController();
  final DatabaseService _databaseService = DatabaseService();
  Future<void> _onSave() async {
    final name = _nameController.text;
    final description = _descController.text;
    await _databaseService
    .insertServiceType(DentalService(name: name, description: description));
    Navigator.pop(context);
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new service'),
        centerTitle: true,
      ), 
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter name of the service here',
              ), 
            ), 
            const SizedBox(height: 16.0),
            TextField(
              controller: _descController,
              maxLines: 7,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter description about the service',
              ), 
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 45.0,
              child: ElevatedButton(
                onPressed: _onSave,
                child: const Text(
                  'Save the Service',
                  style: TextStyle(
                    fontSize: 16.0,
                  ), 
                ), 
              ), 
            ),
          ],
        ),
      ),
    );
  } 
}