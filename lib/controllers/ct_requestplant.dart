import 'package:admin/api/request/api_request_fetch.dart';
import 'package:admin/models/request/md_request_plant.dart';
import 'package:get/get.dart';

class RequestPlantController extends GetxController with DataSourceApi {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadAllData();
  }

  RxList<RequestPlantModel> requestPlantData = RxList<RequestPlantModel>([]);

  //SETTERS

  List<RequestPlantModel> get getPendingStatus => filterByStatus("Pending");

  //FUNCTIONS
  List<RequestPlantModel> filterByStatus(String status) {
    return requestPlantData.value
        .where(
            (request) => request.status!.toLowerCase() == status.toLowerCase())
        .toList();
  }

  void loadAllData() async {
    requestPlantData.value = await requestApiData() ?? [];
  }
}

// mixin DummyDataSource {
//   List<RequestPlantModel> dummyData() {
//     return REQUEST_DUMMY_DATA;
//   }
// }

mixin DataSourceApi {
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  Future<List<RequestPlantModel>?> requestApiData() async {
    stateReset();

    isLoading.value = true;
    var value = await ApiRequest.fetchAllRequests();

    if (value == null) {
      isLoading.value = false;
      isError.value = true;
    } else {
      isLoading.value = false;
      isError.value = false;
    }
    return value;
  }

  void stateReset() {
    isLoading.value = false;
    isError.value = false;
  }
}
