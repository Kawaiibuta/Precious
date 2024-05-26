import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious/data_sources/product_repository.dart';
import 'package:precious/presenters/admin_product_presenter.dart';
import 'package:precious/presenters/category_presenter.dart';
import 'package:precious/resources/app_export.dart';
import 'package:precious/resources/widgets/custom_search_bar.dart';
import 'package:precious/resources/widgets/product_card_admin.dart';
import 'package:precious/resources/widgets/variant_dialog.dart';

class ProductPageAdmin extends StatefulWidget {
  const ProductPageAdmin({super.key, this.openFloatingButton});
  final Function? openFloatingButton;
  @override
  _ProductPageAdminState createState() => _ProductPageAdminState();
}

class _ProductPageAdminState extends State<ProductPageAdmin>
    implements AdminProductContract {
  final categoryPresenter = ProductCategoryPresenter();
  late AdminProductPresenter _presenter;
  var loading = false;
  var reverse = false;
  var loadingMore = false;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _presenter = Get.put(AdminProductPresenter(this));
    _scrollController.addListener(() {
      debugPrint(
          "Pixel ${_scrollController.position.maxScrollExtent - _scrollController.position.pixels}");
      if (_scrollController.position.maxScrollExtent -
                  _scrollController.position.pixels <=
              200.h &&
          !loadingMore) {
        _presenter.getMoreItem();
      }
    });
    _presenter.init();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await _presenter.refresh();
        return;
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomSearchBar(
              onChange: (p0) {
                setState(() {
                  _presenter.searchParam = p0;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    _handleChangeFilter();
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          _presenter.selectedCategory.isEmpty
                              ? Colors.transparent
                              : Colors.black)),
                  label: Text(
                    "Filters",
                    style: GoogleFonts.openSans(
                        fontSize: 15,
                        color: _presenter.selectedCategory.isEmpty
                            ? Colors.black
                            : Colors.white),
                  ),
                  icon: Icon(Icons.tune,
                      size: 15,
                      color: _presenter.selectedCategory.isEmpty
                          ? Colors.black
                          : Colors.white),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.list_alt_rounded,
                          size: 15,
                        )),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            reverse = !reverse;
                          });
                        },
                        icon: const Icon(
                          Icons.swap_vert,
                          size: 15,
                        ))
                  ],
                )
              ],
            ),
            if (loading)
              const Expanded(
                  child: Center(
                child: CircularProgressIndicator(),
              ))
            else
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  reverse: reverse,
                  scrollDirection: Axis.vertical,
                  itemCount: _presenter.productList.length,
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.only(top: 5.0, bottom: 3.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ProductCardAdmin(
                          multiSelect: _presenter.multipleSelection,
                          onLongTap: (i) => setState(() {
                            _presenter.multipleSelection = true;
                          }),
                          product: _presenter.productList[index],
                          onSelected: (int i) {
                            _handleSelect(i);
                          },
                          onDisSelected: (int i) {
                            _handleSelect(i);
                          },
                        ),
                        if (ProductRepository.maximum &&
                            index == (_presenter.productList.length - 1))
                          Center(
                              child: IconButton(
                                  onPressed: () {
                                    _scrollController.position
                                        .moveTo(0, duration: Durations.medium4);
                                  },
                                  icon: const Icon(Icons.arrow_circle_up)))
                      ],
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  void _handleSelect(int i) {
    if (_presenter.selected.contains(i)) {
      _presenter.deselect(i);
    } else {
      _presenter.select(i);
    }
    _configFloatingButton();
  }

  void _configFloatingButton() {
    if (widget.openFloatingButton != null) {
      if (_presenter.selected.length >= 2) {
        widget.openFloatingButton!([0, 1]);
      }
      if (_presenter.selected.isEmpty) {
        widget.openFloatingButton!([0]);
        setState(() {
          _presenter.multipleSelection = false;
        });
      }
      if (_presenter.selected.length == 1) {
        widget.openFloatingButton!([0, 1, 2]);
      }
    }
  }

  void _handleChangeFilter() {
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
              return Dialog(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [Icon(Icons.tune), Text("Filters")],
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.close))
                        ],
                      ),
                      Row(
                        children: [
                          Text("Categories:",
                              style: GoogleFonts.openSans(
                                  fontSize: 15, fontWeight: FontWeight.w600)),
                        ],
                      ),
                      Wrap(
                        children: [
                          ..._presenter.categoryList.map((e) => Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: OutlinedButton(
                                    onPressed: () {
                                      if (_presenter.selectedCategory
                                          .contains(e)) {
                                        _presenter.selectedCategory.remove(e);
                                      } else {
                                        _presenter.selectedCategory.add(e);
                                      }
                                      setState(() {});
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(_presenter
                                                    .selectedCategory
                                                    .contains(e)
                                                ? Colors.black
                                                : Colors.transparent)),
                                    child: Text(e.name,
                                        style: GoogleFonts.openSans(
                                            fontSize: 15,
                                            color: _presenter.selectedCategory
                                                    .contains(e)
                                                ? Colors.white
                                                : Colors.black))),
                              ))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OutlinedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white)),
                                  onPressed: () {
                                    setState(() {
                                      _presenter.selectedCategory.clear();
                                    });
                                  },
                                  child: Text(
                                    "Reset",
                                    style: GoogleFonts.openSans(
                                        color: Colors.black),
                                  )),
                              OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black)),
                                  child: Text("OK",
                                      style: GoogleFonts.openSans(
                                          color: Colors.white))),
                            ]),
                      )
                    ],
                  ),
                ),
              );
            })).then((value) => _presenter.refresh());
  }

  @override
  void onInitSuccess() {
    setState(() {
      if (widget.openFloatingButton != null) widget.openFloatingButton!([0]);
    });
  }

  @override
  void onRefreshSuccess() {
    setState(() {
      if (widget.openFloatingButton != null) widget.openFloatingButton!([0]);
    });
  }

  @override
  void onDeleteFail() {
    Get.snackbar("Error", "Cannot delete the product.");
  }

  @override
  void onDeleteSuccess() {}

  @override
  void onEndAsyncTask() {
    if (!mounted) return;
    setState(() {
      loading = false;
    });
  }

  @override
  void onStartAsyncTask() {
    if (!mounted) return;
    setState(() {
      loading = true;
    });
  }

  @override
  void onEndGetMoreItem() {
    if (!mounted) return;
    setState(() {
      loadingMore = false;
    });
  }

  @override
  void onGetMoreItemFail() {}

  @override
  void onGetMoreItemSuccess() {}

  @override
  void onStartGetMoreItem() {
    setState(() {
      loadingMore = true;
    });
  }
}
