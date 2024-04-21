import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:precious/presenters/product_presenter.dart';
import 'package:precious/views/admin/product_page_admin.dart';
import 'package:sidebarx/sidebarx.dart';

class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({super.key});
  static const name = "home_page_admin";
  @override
  _HomePageAdminState createState() => _HomePageAdminState();
}

final divider = Divider(color: Colors.white.withOpacity(0.3), height: 1);
final _controller = SidebarXController(selectedIndex: 0, extended: true);

final floatingButtonList = [Icons.add, Icons.delete, Icons.edit];

class _HomePageAdminState extends State<HomePageAdmin> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var openList = <IconData>[Icons.add];
  List<int> itemList = [];
  final productPresenter = ProductPresenter();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: ProductPageAdmin(
          openFloatingButton: (List<int> i) {
            setState(() {
              openList = i.map((e) => floatingButtonList[e]).toList();
            });
          },
        ),
        drawer: SidebarX(
          controller: _controller,
          theme: SidebarXTheme(
            margin: const EdgeInsets.all(10),
            textStyle: const TextStyle(color: Colors.white),
            selectedTextStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            itemTextPadding: const EdgeInsets.only(left: 30),
            selectedItemTextPadding: const EdgeInsets.only(left: 30),
            selectedItemDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white24,
            ),
            iconTheme: const IconThemeData(
              color: Colors.white,
              size: 20,
            ),
          ),
          extendedTheme: SidebarXTheme(
            width: MediaQuery.of(context).size.width / 1.6,
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            margin: const EdgeInsets.only(right: 10),
          ),
          footerDivider: divider,
          headerBuilder: (context, extended) {
            return SafeArea(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: CachedNetworkImage(
                            imageUrl:
                                "https://cdn2.thecatapi.com/images/_6x-3TiCA.jpg"),
                      ),
                      const Text(
                        "Hello, \nPhap",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          items: [
            SidebarXItem(
              icon: Icons.home,
              label: 'Home',
              onTap: () {
                debugPrint('Hello');
              },
            ),
            const SidebarXItem(
              icon: Icons.search,
              label: 'Product',
            ),
            const SidebarXItem(
              icon: Icons.people,
              label: 'User',
            ),
            const SidebarXItem(
              icon: Icons.favorite,
              label: 'Order',
            ),
            const SidebarXItem(
              icon: Icons.favorite,
              label: 'Statistics',
            ),
          ],
        ),
        floatingActionButton: Stack(
          children: [
            ...openList.reversed
                .toList()
                .asMap()
                .map((key, value) => MapEntry(
                    key,
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeOut,
                      bottom: openList.isNotEmpty && key != 0 ? key * 65 : 0,
                      right: 10.0,
                      child: Container(
                        width: 60,
                        height: 60,
                        child: FloatingActionButton(
                          backgroundColor: Colors.black,
                          onPressed: () {},
                          child: Icon(
                            value,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )))
                .values
          ],
        ));
  }
}
