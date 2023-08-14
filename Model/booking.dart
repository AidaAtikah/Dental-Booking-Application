import 'dart:convert';
import 'package:flutter/widgets.dart';

class Booking {
  final int id;
  final String name;
  final String email;
  final String contactNo;
  final String appdate;
  final int servicetypeId;

  Booking({
     this.id,
     this.name,
     this.email,
     this.contactNo,
     this.appdate,
     this.servicetypeId, 
  });


  Map<String, dynamic> toMap() {
    return {
    'id': id,
    'name': name,
    'email': email,
    'contactNo': contactNo,
    'appdate': appdate,
    'servicetypeId': servicetypeId,
    };
  } 
  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      contactNo: map['contactNo'] ?? '',
      appdate: map['appdate'] ?? '',
      servicetypeId: map['servicetypeId']?.toInt() ?? 0,
    ); 
  } 
  String toJson() => json.encode(toMap());
  factory Booking.fromJson(String source) => Booking.fromMap(json.decode(source));
  
  @override
  String toString() {
    return 'Appointment(id: $id, name: $name, email: $email, contactNo: $contactNo, appdate: $appdate, brandId: $servicetypeId)';
  } 
} 