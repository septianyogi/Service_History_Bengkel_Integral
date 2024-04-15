// ignore_for_file: unused_import

import 'package:bengkel_service/models/service_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchByPlatStatusProvider = StateProvider((ref) => '');

setSearchByPlatStatus(WidgetRef ref, String newStatus) {
  ref.read(searchByPlatStatusProvider.notifier).state = newStatus;
}

final searchByPlatListProvider = 
  StateNotifierProvider.autoDispose<SearchByPlatList, List<ServiceModel>>(
  (ref) => SearchByPlatList([]));

class SearchByPlatList extends StateNotifier<List<ServiceModel>> {
  SearchByPlatList(super.state);

  setData(List<ServiceModel> newList) {
    state = newList;
  }
}