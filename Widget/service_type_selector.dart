import 'package:flutter/material.dart';

class ServiceTypeSelector extends StatelessWidget {
  const ServiceTypeSelector({ Key key, this.servicestype, this.selectedIndex,  this.onChanged, }) : 
  super(key: key);
  final List<String> servicestype;
  final int selectedIndex;
  final Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Service',
          style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          ), 
        ), 
        const SizedBox(height: 12.0),
        SizedBox(
          height: 40.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: servicestype.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => onChanged(index),
                child: Container(
                  height: 40.0,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  margin: const EdgeInsets.only(right: 12.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      width: 3.0,
                      color:
                      selectedIndex == index ? Colors.teal : Colors.black,
                    ), 
                  ), 
                  child: Text(servicestype[index]),
                ), 
              ); 
            },
          ), 
        ), 
      ],
    ); 
  } 
} 