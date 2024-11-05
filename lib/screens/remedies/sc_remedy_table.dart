import 'package:admin/controllers/ct_plant.dart';
import 'package:admin/controllers/ct_remedy.dart';
import 'package:admin/routes/rt_routers.dart';
import 'package:admin/widgets/wg_appbar.dart';
import 'package:admin/widgets/wg_drawer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class RemedyTableScreen extends StatelessWidget {
  RemedyTableScreen({super.key});
  var remedyController = Get.put(RemedyController());

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: customDrawer(),
      appBar: customAppBar(
        context,
        isPrimary: true,
        title: 'Remedy Table',
        actions: [
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {},
            child: const CircleAvatar(
              radius: 18,
              child: Icon(
                Icons.notifications,
                color: Color(0xFF007E62),
              ),
            ),
          ),
          const Gap(10),
          Builder(
            builder: (BuildContext context) {
              return InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: const CircleAvatar(
                  radius: 18,
                  child: Icon(
                    Icons.menu_sharp,
                    color: Color(0xFF007E62),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return Container(
          color: Colors.white,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          width: constraint.maxWidth,
          height: constraint.maxHeight,
          child: Column(
            children: [
              _buildSmallNavigation('Go To Plant Table'),
              const Gap(20),
              _buildTable(constraint),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSmallNavigation(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            spacing: 20,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              TextField(
                controller: TextEditingController(),
                style: const TextStyle(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  constraints:
                      const BoxConstraints(maxWidth: 240, maxHeight: 40),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              MaterialButton(
                color: const Color(0xFF007E62),
                textColor: Colors.white,
                onPressed: () {
                  Get.toNamed(CustomRoute.path.remediesCreate);
                },
                child: const Text(
                  'Add Remedy',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              Get.offAndToNamed(CustomRoute.path.plantsTable);
            },
            child: Text(
              title,
              style: const TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFF007E62),
                color: Color(0xFF007E62),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTable(constraint) {
    return Container(
      color: const Color(0xFFE4FFF2),
      width: constraint.maxWidth,
      height: constraint.maxHeight - 140,
      child: Obx(() {
        return ListView.builder(
            itemCount: remedyController.remedyData.value.length,
            itemBuilder: (context, index) {
              var remedy = remedyController.remedyData.value[index];
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: Color.fromARGB(255, 231, 231, 231),
                    ),
                  ),
                ),
                child: ListTile(
                  tileColor: Colors.white,
                  style: ListTileStyle.list,
                  leading: SizedBox(
                    width: 60,
                    height: 60,
                    child: Image.asset('assets/sample_image/ast_sample1.png'),
                  ),
                  title: Text(
                    '${remedy.name}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${remedy.type}'),
                  trailing: _buildStatusContainer('${remedy.status}'),
                ),
              );
            });
      }),
    );
  }

  Widget _buildStatusContainer(String status) {
    return Container(
      color: status == 'Active'
          ? Colors.green
          : status == 'In Active'
              ? const Color(0xFFD3A21A)
              : Colors.grey,
      width: 80,
      height: 20,
      child: Center(
          child: Text(status, style: const TextStyle(color: Colors.white))),
    );
  }

  Widget _buildLoading(constraint) {
    return SizedBox(
      // color: Colors.green,
      width: constraint.maxWidth,
      height: constraint.maxHeight,

      /// if there is overflow in the x-axis.
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildError(constraint) {
    return SizedBox(
      // color: Colors.red,
      width: constraint.maxWidth,
      height: constraint.maxHeight,
      child: Center(
        child: MaterialButton(
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: () {
            remedyController.loadAllData();
          },
          child: const Text('Retry'),
        ),
      ),
    );
  }
}
