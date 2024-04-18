import 'package:bengkel_service/config/app_response.dart';
import 'package:bengkel_service/config/failure.dart';
import 'package:bengkel_service/datasource/service_datasource.dart';
import 'package:bengkel_service/models/service_model.dart';
import 'package:bengkel_service/providers/search_by_plat_provider.dart';
import 'package:d_info/d_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AddServicePage extends ConsumerStatefulWidget {
  const AddServicePage({super.key, required this.service});
  final ServiceModel service;

  @override
  ConsumerState<AddServicePage> createState() => _AddServicePageState();
}

class _AddServicePageState extends ConsumerState<AddServicePage> {
  final TextEditingController edtNoPlat = TextEditingController();
  final TextEditingController edtMobil = TextEditingController();
  final TextEditingController edtPemilik = TextEditingController();
  final TextEditingController edtNoPemilik = TextEditingController();
  final TextEditingController edtJasa = TextEditingController();
  final TextEditingController edtBarang = TextEditingController();
  final formKey = GlobalKey<FormState>();

  getData() {
    ServiceDataSource.searchPlat(edtNoPlat.text).then((value) {
      value.fold((failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            DInfo.toastError('Server Error');
            break;
          case NotFoundFailure:
            DInfo.toastError('Not Found');
            break;
          case ForbiddenFailure:
            DInfo.toastError('You don\'t have access');
            break;
          case BadRequestFailure:
            DInfo.toastError('bad Request');
            break;
          case UnauthorisedFailure:
            DInfo.toastError('Unauthorized');
            break;
          default:
            DInfo.toastError('Request Error');
            break;
        }
      }, (result) {
        List data = result['data'];
        List<ServiceModel> list =
            data.map((e) => ServiceModel.fromJson(e)).toList();
        ref.read(searchByPlatListProvider.notifier).setData(list);
        print(value);
      });
    });
  }

  store(String no_plat, String mobil, String pemilik, String no_pemilik,
      String tanggal, String jasa, String barang) {
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
        getData();
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

  String currentDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    Future<void> getDate(BuildContext context) async {
      final DateTime? date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(200),
          lastDate: DateTime(3000));

      if (date != null) {
        setState(() {
          currentDate = DateFormat("yyyy-MM-dd").format(date);
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: const Text(
          'Tambah Service',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Consumer(
        builder: (_, wiRef, __) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: const Text(
                      'Tambah data',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                          Row(
                            children: [
                              Text(
                                currentDate,
                                style: TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                  onPressed: () {
                                    getDate(context);
                                  },
                                  icon: Icon(Icons.date_range))
                            ],
                          ),
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
                            height: 20,
                          ),
                          OutlinedButton(
                              onPressed: () {
                                store(
                                    edtNoPlat.text,
                                    edtMobil.text,
                                    edtPemilik.text,
                                    edtNoPemilik.text,
                                    currentDate,
                                    edtJasa.text,
                                    edtBarang.text);
                              },
                              style: OutlinedButton.styleFrom(
                                minimumSize: Size.fromHeight(50),
                                backgroundColor: Colors.blue[200],
                              ),
                              child: Text(
                                "Tambah Service",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ))
                        ],
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
