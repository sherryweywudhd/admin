import 'package:admin/models/plant/md_plant.dart';
import 'package:get/get.dart';

import '../api/plant/api_plant.dart';

class PlantController extends GetxController with DataSourceApi {
  @override
  void onInit() {
    super.onInit();
    loadPlantData();
  }

  final RxList<PlantModel> plantData = RxList<PlantModel>([]);
  final RxList<PlantModel> plantActive = RxList<PlantModel>([]);

  //FUNCTIONS
  List<PlantModel> filterByStatus(String status) {
    return plantData.value
        .where((plant) => plant.status!.toLowerCase() == status.toLowerCase())
        .toList();
  }

  void loadPlantData() async {
    plantData.value = await plantApiData() ?? [];

    plantActive.value = filterByStatus('Active');
  }
}

// mixin DummyDataSource {
//   List<PlantModel> dummyData() {
//     return PLANTS_DUMMY_DATA;
//   }
// }

mixin DataSourceApi {
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;

  Future<List<PlantModel>?> plantApiData() async {
    stateReset();

    //
    isLoading.value = true;
    var value = await ApiPlant.fetchAllPlants();

    if (value == null) {
      isLoading.value = false;
      isError.value = true;
    } else {
      isLoading.value = false;
      isError.value = false;
    }

    return value;
  }

  Future<PlantModel> getApiDataById(int id) async {
    stateReset();

    isLoading.value = true;

    var value = await ApiPlant.getPlants(id);

    if (value == null) {
      isLoading.value = false;
      isError.value = true;
    } else {
      isLoading.value = false;
      isError.value = false;
    }

    return value!;
  }

  void stateReset() {
    isLoading.value = false;
    isError.value = false;
  }
}
