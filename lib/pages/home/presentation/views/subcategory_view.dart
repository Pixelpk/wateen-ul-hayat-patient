import 'package:flutter_svg/flutter_svg.dart';
import 'package:swift_care/components/default_app_bar.dart';
import 'package:swift_care/components/subcategory_widget.dart';
import 'package:swift_care/export.dart';
import 'package:swift_care/pages/cart/presentation/cart_screen.dart';
import 'package:swift_care/pages/cart/presentation/controller/cart_controller.dart';
import '../../../../search_delegate.dart';
import '../controllers/home_tab_controller.dart';

class SubCategoryView extends StatefulWidget {
  final int index;

  const SubCategoryView({Key? key, required this.index}) : super(key: key);

  @override
  State<SubCategoryView> createState() => _SubCategoryViewState();
}

class _SubCategoryViewState extends State<SubCategoryView> {
  @override
  void initState() {
    print("The title is" + widget.index.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return GetBuilder<HomeTabController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Color(0xffF5F5F5),
          appBar: DefaultAppBar(
            title: controller.allServiceIssueList[widget.index].title ?? "",
            actions: [
              InkWell(
                onTap: () {
                  var ctrl = Get.put(CartController());
                  ctrl.queryAll();
                  Get.to(CartScreen(ctrl.providerId));
                },
                child: Container(
                    margin: EdgeInsets.only(right: 12),
                    child: SvgPicture.asset("assets/images/cart_icon.svg")),
              )
            ],
          ),
          body: DefaultTabController(
            length: controller.subCateLocalData.tabList.length,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 10, right: 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      onTap: () {
                      final list =   controller.subCateLocalData.subServices.expand((element) => element!.toList()).toList();
                        showSearch(
                          context: context,
                          delegate: CustomSearchDelegate(
                              categoryListItem: list),
                        );
                      },
                      leading: Icon(
                        Icons.search_rounded,
                        color: buttonColor,
                      ),
                      title: Text("Search"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, bottom: 5),
                  child: TabBar(
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: buttonColor)),
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: buttonColor,
                      unselectedLabelColor: buttonColor,
                      tabs: controller.subCateLocalData.tabList.map((e) => Tab(
                        text: e,
                      )).toList()
                  ),
                ),
                Expanded(
                    child: TabBarView(children: controller.subCateLocalData.subServices.map((e) =>   SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          ((e!.isEmpty) && controller.isLoading == false)
                              ? Container(
                              margin: EdgeInsets.only(top: Get.height * 0.38),
                              child: Center(
                                  child: Text(
                                    STRING_NoServiceFound.tr,
                                    style: Theme.of(context).textTheme.subtitle1,
                                  )))
                              : ListView.builder(
                              shrinkWrap: true,
                              padding:
                              EdgeInsets.symmetric(horizontal: hMargin),
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                              e.length,
                              itemBuilder: (_, index) {
                                return SubcategoryWidget(
                                  categoryListItem: e[index],
                                );
                              }),
                          SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                    ),).toList())
                )
              ],
            ),
          ),
        );
        },
    );
  }
}
