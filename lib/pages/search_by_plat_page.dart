// ignore_for_file: type_literal_in_constant_pattern, unused_import, prefer_const_constructors, avoid_print, unused_local_variable

import 'package:bengkel_service/datasource/service_datasource.dart';
import 'package:bengkel_service/models/main_service_model.dart';
import 'package:bengkel_service/models/serviceItem_model.dart';
import 'package:bengkel_service/models/service_model.dart';
import 'package:bengkel_service/providers/search_by_plat_provider.dart';
import 'package:d_view/d_view.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bengkel_service/config/failure.dart';

class SearchByPlatPage extends ConsumerStatefulWidget {
  const SearchByPlatPage({super.key,});

  @override
  ConsumerState<SearchByPlatPage> createState() => _SearchByPlatPageState();
}


class _SearchByPlatPageState extends ConsumerState<SearchByPlatPage> {
  final edtSearch = TextEditingController();

  execute() {
    
    ServiceDataSource.searchPlat(edtSearch.text).then((value) {
      setSearchByPlatStatus(ref, 'Loading');
      value.fold(
        (failure) {
          switch (failure.runtimeType) {
            case ServerFailure:
              setSearchByPlatStatus(ref, 'Server Error');
              break;
            case NotFoundFailure:
              setSearchByPlatStatus(ref, 'Not Found');
              break;
            case ForbiddenFailure:
              setSearchByPlatStatus(ref, 'You don\'t have access');
              break;
            case BadRequestFailure:
              setSearchByPlatStatus(ref, 'bad Request');
              break;
            case UnauthorisedFailure:
              setSearchByPlatStatus(ref, 'Unauthorized');
              break;
            default:
              setSearchByPlatStatus(ref, 'Request Error');
              break;
          }
        },
        (result) {
          setSearchByPlatStatus(ref, 'Success');
          List data = result['data'];
          List<ServiceModel> list = 
            data.map((e) => ServiceModel.fromJson(e)).toList();
          ref.read(searchByPlatListProvider.notifier).setData(list);
        }
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        titleSpacing: 0,
        title: Container(
          padding: EdgeInsets.only(left: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                const Text(
                  'No Plat:',
                  style: TextStyle(
                    color: Colors.black,
                    height: 1,
                    fontSize: 16
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: edtSearch,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    style: const TextStyle(height: 1),
                    onSubmitted: (value) => execute(),
                  ),
                )
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => execute(), 
            icon: const Icon(Icons.search))
        ],
        
      ),

      body: Consumer(
        builder: (_, wiRef, __) {
          String status = wiRef.watch(searchByPlatStatusProvider);
          List<ServiceModel> list = wiRef.watch(searchByPlatListProvider);

          // list[index].services.map((e) => ServiceItemModel.fromJson(e)).toList();


          print(status);
          if(status == ''){
            return DView.nothing();
          }

          if(status == 'Loading') {
            return DView.loadingCircle();
          }

          if(status == 'Success'){
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                ServiceModel service = list[index];

                final subservice = service.services.map((e) => e).toList();


                return ListTile(
                  onTap: () {},
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    radius: 18,
                    child: Text('${index + 1}'),
                  ),
                  title: Text(service.noPlat),
                  subtitle: Text(service.mobil),
                  
                  trailing: const Icon(Icons.navigate_next),
                );
              },
            );

          }
          return DView.error(data: status);
        },
      ),
    );
  }
}

