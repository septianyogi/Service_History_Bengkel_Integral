import 'package:bengkel_service/models/serviceItem_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final serviceItemStatusProvider = StateProvider((ref) => '');

setServiceItemStatus(WidgetRef ref, String newStatus) {
  ref.read(serviceItemStatusProvider.notifier).state = newStatus;
}

final serviceItemListProvider =
    StateNotifierProvider.autoDispose<ServiceItemList, List<ServiceItemModel>>(
        (ref) => ServiceItemList([]));

class ServiceItemList extends StateNotifier<List<ServiceItemModel>> {
  ServiceItemList(super.state);

  setData(List<ServiceItemModel> newList) {
    state = newList;
  }
}
