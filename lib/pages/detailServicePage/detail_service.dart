// ignore_for_file: unused_import, unnecessary_import, prefer_const_constructors, type_literal_in_constant_pattern, avoid_print, prefer_const_literals_to_create_immutables

import 'package:bengkel_service/config/app_response.dart';
import 'package:bengkel_service/config/failure.dart';
import 'package:bengkel_service/config/nav.dart';
import 'package:bengkel_service/datasource/service_datasource.dart';
import 'package:bengkel_service/models/serviceItem_model.dart';
import 'package:bengkel_service/models/service_model.dart';
import 'package:bengkel_service/pages/detailServicePage/detail_add_service_page.dart';
import 'package:bengkel_service/providers/search_by_plat_provider.dart';
import 'package:bengkel_service/providers/service_item_provider.dart';
import 'package:d_info/d_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailServicePage extends ConsumerStatefulWidget {
  const DetailServicePage({super.key, required this.service});
  final ServiceModel service;

  @override
  ConsumerState<DetailServicePage> createState() => _DetailServicePageState();
}

class _DetailServicePageState extends ConsumerState<DetailServicePage> {
  deleteServiceItem(int id) {
    ServiceDataSource.deleteService(id).then((value) {
      value.fold((failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            DInfo.toastError('Server Error');
            break;
          case NotFoundFailure:
            DInfo.toastError('Laundry has been claimed');
            break;
          case ForbiddenFailure:
            DInfo.toastError('You dan\'t have access');
            break;
          case BadRequestFailure:
            DInfo.toastError('Laundry has been claimed');
            break;
          case InvalidInputFailure:
            AppResponse.invalidInput(context, failure.message ?? '{}');
            break;
          case UnauthorisedFailure:
            DInfo.toastError('Unauthorized');
            break;
          default:
            DInfo.toastError('Request Error');
            break;
        }
      }, (result) {
        DInfo.toastSuccess("Data Berhasil dihapus");
        getServiceItem();
        setState(() {});
      });
    });
  }

  getServiceItem() {
    ServiceDataSource.getServiceItem(widget.service.noPlat).then((value) {
      setServiceItemStatus(ref, 'Loading');
      value.fold((failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            setServiceItemStatus(ref, 'Server Error');
            break;
          case NotFoundFailure:
            setServiceItemStatus(ref, 'Not Found');
            break;
          case ForbiddenFailure:
            setServiceItemStatus(ref, 'You don\'t have access');
            break;
          case BadRequestFailure:
            setServiceItemStatus(ref, 'bad Request');
            break;
          case UnauthorisedFailure:
            setServiceItemStatus(ref, 'Unauthorized');
            break;
          default:
            setServiceItemStatus(ref, 'Request Error');
            break;
        }
      }, (result) {
        setServiceItemStatus(ref, 'Success');
        List data = result['data'];
        List<ServiceItemModel> list =
            data.map((e) => ServiceItemModel.fromJson(e)).toList();
        ref.read(serviceItemListProvider.notifier).setData(list);
        print(value);
      });
    });
  }

  @override
  void initState() {
    getServiceItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue[200],
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'Detail Service',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            OutlinedButton.icon(
              onPressed: () {
                Nav.push(
                    context, DetailAddServicePage(service: widget.service));
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
                          widget.service.noPlat.toUpperCase(),
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
                            widget.service.mobil,
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
                            widget.service.pemilik,
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
                            widget.service.noPemilik,
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
                    Consumer(builder: (_, wiRef, __) {
                      List<ServiceItemModel> list =
                          wiRef.watch(serviceItemListProvider);

                      return ListView.builder(
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          ServiceItemModel services = list[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                    )
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Tanggal : ${services.tanggal}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                              color: Colors.black),
                                        ),
                                        IconButton(
                                            onPressed: () {deleteServiceItem(services.id);},
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ))
                                      ],
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Sparepart :',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          services.barang,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 17),
                                        ),
                                        const Text(
                                          'Jasa :',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          services.jasa,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 17),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    })
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
