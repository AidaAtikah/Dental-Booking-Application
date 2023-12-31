import 'package:flutter/material.dart';
import 'package:dental_check/Model/dental_service.dart';

class ServiceTypeBuilder extends StatelessWidget {
  const ServiceTypeBuilder({Key key, this.future,}) : super(key: key);
  final Future<List<DentalService>> future;


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DentalService>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
          child: CircularProgressIndicator(),
          ); 
        } 
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              final servicetype = snapshot.data[index];
              return _buildServiceTypeCard(servicetype, context);
            },
          ), 
        ); 
      },
    ); 
  } 

 Widget _buildServiceTypeCard(DentalService servicetype, BuildContext context) {
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
              color: Colors.grey[300],
            ), 
            alignment: Alignment.center,
            child: Text(
              servicetype.id.toString(),
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ), 
            ), 
          ), 
          const SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                servicetype.name,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ), 
                ), 
                const SizedBox(height: 4.0),
                Text(servicetype.description),
              ],
            ), 
          ), 
        ],
      ), 
    ), 
  ); 
 } 
} 