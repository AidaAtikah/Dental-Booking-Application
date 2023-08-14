import 'dart:convert';

class DentalService {
  final int id;
  final String name;
  final String description;
  DentalService({ 
    this.id,
     this.name,
     this.description,
  });

  Map<String, dynamic> toMap() {
    return {
    'id': id,
    'name': name,
    'description': description,
    };
  } 

  factory DentalService.fromMap(Map<String, dynamic> map) {
    return DentalService(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
    ); 
  }

  String toJson() => json.encode(toMap());
  factory DentalService.fromJson(String source) => DentalService.fromMap(json.decode(source));
  
  @override
  String toString() => 'ServiceType(id: $id, name: $name, description: $description)';
}