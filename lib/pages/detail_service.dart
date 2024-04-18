// ignore_for_file: unused_import, unnecessary_import, prefer_const_constructors

import 'package:bengkel_service/config/nav.dart';
import 'package:bengkel_service/models/serviceItem_model.dart';
import 'package:bengkel_service/models/service_model.dart';
import 'package:bengkel_service/pages/add_service_page.dart';
import 'package:bengkel_service/pages/services_tile.dart';
import 'package:bengkel_service/providers/search_by_plat_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailServicePage extends StatelessWidget {
  const DetailServicePage({super.key, required this.service});
  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, 
          children: [
        Text(
          'Detail Service',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        OutlinedButton.icon(
          onPressed: () {
            Nav.push(context, AddServicePage(service: service));
          },
          icon: Icon(Icons.add),
          label: const Text(
            'Tambah',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
        ),
      ])),
      body: ListView(
        children: [
          Container(
            color: Colors.blue[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          service.noPlat.toUpperCase(),
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Mobil :',
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            service.mobil,
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pemilik :',
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            service.pemilik,
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Nomor :',
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            service.noPemilik,
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Row(
                        children: const [
                          Icon(Icons.miscellaneous_services),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Riwayat Service',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: service.services.length,
                      itemBuilder: (context, index) {
                        ServiceItemModel services = service.services[index];
                        return ServicesTile(services: services);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
