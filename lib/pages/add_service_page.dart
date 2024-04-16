import 'dart:developer';
import 'dart:ffi';

import 'package:bengkel_service/config/app_response.dart';
import 'package:bengkel_service/config/failure.dart';
import 'package:bengkel_service/datasource/service_datasource.dart';
import 'package:bengkel_service/models/service_model.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddServicePage extends StatefulWidget {
  const AddServicePage({super.key, required this.service});
  final ServiceModel service;

  @override
  State<AddServicePage> createState() => _AddServicePageState();
}

class _AddServicePageState extends State<AddServicePage> {
  final TextEditingController edtNoPlat = TextEditingController();
  final TextEditingController edtMobil = TextEditingController();
  final TextEditingController edtPemilik = TextEditingController();
  final TextEditingController edtNoPemilik = TextEditingController();
  final TextEditingController edtJasa = TextEditingController();
  final TextEditingController edtBarang = TextEditingController();
  final formKey = GlobalKey<FormState>();

  DateTime edtTanggal = DateTime.now();

  tambah(String no_plat, String mobil, String pemilik, String no_pemilik,
      DateTime tanggal, String jasa, String barang) {
    ServiceDataSource.storeService(
            no_plat, mobil, pemilik, no_pemilik, tanggal, jasa, barang)
        .then((value) {
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
        DInfo.toastSuccess("berhasil ditambah");
        Navigator.pop(context);
      });
    });
  }

  @override
  void initState() {
    edtNoPlat.text = widget.service.noPlat;
    edtMobil.text = widget.service.mobil;
    edtPemilik.text = widget.service.pemilik;
    edtNoPemilik.text = widget.service.noPemilik;

    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text(
          'Tambah Service',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: const Text(
                  'Tambah data',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'No Plat',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: edtNoPlat,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            contentPadding: EdgeInsets.all(5)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Mobil',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: edtMobil,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            contentPadding: EdgeInsets.all(5)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Pemilik',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: edtPemilik,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            contentPadding: EdgeInsets.all(5)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'No Pemilik',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: edtNoPemilik,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            contentPadding: EdgeInsets.all(5)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Tanggal',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),


                      SfDateRangePicker(
                      ),

                      // Container(
                      //   height: 200,
                      //   child: CupertinoDatePicker(
                      //     mode: CupertinoDatePickerMode.date,
                      //     initialDateTime: selectedDate,
                      //       onDateTimeChanged: (DateTime newDate) {
                      //         setState(() {
                      //           selectedDate = newDate;
                      //         });
                      //       }),
                      // ),
                      const Text(
                        'Jasa',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: edtJasa,
                        maxLines: null,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            contentPadding: EdgeInsets.all(5)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Barang',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: edtBarang,
                        maxLines: null,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            contentPadding: EdgeInsets.all(5)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}