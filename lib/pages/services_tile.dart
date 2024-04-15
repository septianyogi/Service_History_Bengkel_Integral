import 'package:bengkel_service/models/serviceItem_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ServicesTile extends StatelessWidget {
  const ServicesTile({required this.services});
  final ServiceItemModel services;

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("dd-MM-yyy");
    String tanggal = dateFormat.format(services.tanggal);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        color: Colors.blue[100],
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                'Tanggal : $tanggal',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sparepart :',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 18),
                  ),
                  Text(
                    services.barang,
                    style: TextStyle(
                        color: Colors.black, 
                        fontWeight: FontWeight.w400,
                        fontSize: 17),
                  ),
                  Text(
                    'Jasa :',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 18),
                  ),
                  Text(
                    services.jasa,
                    style: TextStyle(
                        color: Colors.black, 
                        fontWeight: FontWeight.w400,
                        fontSize: 17),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
