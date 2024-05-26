import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:precious/models/user/user.dart';
import 'package:precious/presenters/admin_user_presenter.dart';
import 'package:precious/resources/app_export.dart';
import 'package:precious/resources/widgets/custom_search_bar.dart';
import 'package:precious/views/admin/user_detail_admin.dart';

class UserPageAdmin extends StatefulWidget {
  const UserPageAdmin({Key? key}) : super(key: key);

  @override
  _UserPageAdminState createState() => _UserPageAdminState();
}

class _UserPageAdminState extends State<UserPageAdmin>
    implements AdminUserContract {
  late AdminUserPresenter _presenter;
  bool loading = true;
  bool error = false;
  @override
  void initState() {
    super.initState();
    _presenter = Get.put(AdminUserPresenter(this));
    _presenter.init();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: loading || error
            ? Center(
                child: error
                    ? const Text('Some things wrong have happened.')
                    : const CircularProgressIndicator())
            : Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0),
                child: SingleChildScrollView(
                    child: Column(children: [
                  CustomSearchBar(
                    onChange: (p0) {
                      setState(() {
                        _presenter.searchParam = p0;
                      });
                    },
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _presenter.userList.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () => Get.to(UserDetailAdmin(
                              user: _presenter.userList[index]))!
                          .then((value) => _presenter.refresh()),
                      child: UserCardAdmin(
                        user: _presenter.userList[index],
                        contactEmail: () =>
                            _presenter.contactEmail(_presenter.userList[index]),
                        contactPhoneNumber: () => _presenter
                            .contactPhoneNumber(_presenter.userList[index]),
                      ),
                    ),
                  )
                ]))),
        onRefresh: () => _presenter.refresh());
  }

  @override
  onEndAsyncFunction() {
    setState(() {
      loading = false;
    });
  }

  @override
  onInitFail() {
    setState(() {
      error = true;
    });
  }

  @override
  onInitSuccess() {}

  @override
  onRefreshFail() {
    setState(() {
      error = true;
    });
  }

  @override
  onRefreshSuccess() {}

  @override
  onStartAsyncFunction() {
    setState(() {
      loading = true;
    });
  }

  @override
  void onContactFail() {
    Get.snackbar("Error", "Unable to contact with user");
  }
}

class UserCardAdmin extends StatelessWidget {
  final User user;
  const UserCardAdmin(
      {super.key,
      required this.user,
      this.contactEmail,
      this.contactPhoneNumber});
  final Function? contactEmail;
  final Function? contactPhoneNumber;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.h)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Container(
              decoration: const BoxDecoration(),
              clipBehavior: Clip.antiAlias,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 50.h,
                    height: 50.h,
                    margin: EdgeInsets.only(right: 10.h),
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    clipBehavior: Clip.antiAlias,
                    child: user.avatar_url != null
                        ? SvgPicture.network(user.avatar_url!)
                        : Icon(
                            Icons.person,
                            size: 50.h,
                          ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Id: ${user.id}"),
                      Text(
                        "Email: ${user.email ?? "Unknown."}",
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {
                    if (contactEmail != null) {
                      contactEmail!();
                    }
                  },
                  icon: const Icon(
                    Icons.email,
                    color: Colors.black45,
                  )),
              IconButton(
                  onPressed: () {
                    if (contactPhoneNumber != null) contactPhoneNumber!();
                  },
                  icon: const Icon(
                    Icons.phone,
                    color: Colors.black45,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
