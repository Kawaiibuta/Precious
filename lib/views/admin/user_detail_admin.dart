import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious/data_sources/user_repository.dart';
import 'package:precious/models/user/user.dart';
import 'package:precious/resources/app_export.dart';

class UserDetailAdmin extends StatefulWidget {
  const UserDetailAdmin({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  _UserDetailAdminState createState() => _UserDetailAdminState();
}

class _UserDetailAdminState extends State<UserDetailAdmin> {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final genderController = TextEditingController();
  final roleController = TextEditingController();
  final ageController = TextEditingController();
  User? user;
  bool isEditing = false;
  @override
  void initState() {
    super.initState();
    user = widget.user;
    emailController.text = widget.user.email ?? "Unknown";
    phoneController.text = widget.user.phoneNumber ?? "Unknown";
    genderController.text = widget.user.gender == 1 ? "Female" : "Male";
    roleController.text = widget.user.userRole;
    ageController.text =
        widget.user.age != null ? widget.user.age.toString() : "Unknown";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isEditing = !isEditing;
                });
              },
              icon: const Icon(
                Icons.edit_square,
                color: Colors.white,
              ))
        ],
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            children: [
              Flexible(
                  child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.black, Colors.white],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
              )),
            ],
          ),
          if (user != null)
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 10.h, right: 10.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 80.h,
                        height: 80.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: widget.user.avatarUrl != null
                            ? SvgPicture.network(widget.user.avatarUrl!)
                            : Icon(
                                Icons.person,
                                size: 50.h,
                              ),
                      ),
                    ],
                  ),
                  AnimatedContainer(
                      duration: Durations.medium3,
                      height: isEditing ? 500.h : 170.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.h),
                          color: Colors.white),
                      margin: EdgeInsets.symmetric(
                          horizontal: 30.h, vertical: 40.h),
                      padding: EdgeInsets.all(10.h),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SwitchTextInput(
                                  controller: emailController,
                                  editing: isEditing,
                                  hintText: "Email",
                                  label: "Email"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SwitchTextInput(
                                  controller: ageController,
                                  editing: isEditing,
                                  keyboardType: TextInputType.number,
                                  hintText: "Age",
                                  label: "Age"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SwitchTextInput(
                                  controller: phoneController,
                                  editing: isEditing,
                                  keyboardType: TextInputType.phone,
                                  hintText: "Phone number",
                                  label: "Phone number"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SwitchTextInput(
                                controller: genderController,
                                editing: isEditing,
                                hintText: "Gender",
                                label: "Gender",
                                isRadio: true,
                                radioValueList: const ["Male", 'Female'],
                                radioCurrentValue: genderController.text,
                                onChangeRadioButton: (value) => setState(() {
                                  if (value != null) {
                                    genderController.text = value;
                                  }
                                }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SwitchTextInput(
                                controller: roleController,
                                editing: isEditing,
                                hintText: "role",
                                label: "Role",
                                isRadio: true,
                                radioValueList: const ["USER", 'ADMIN'],
                                radioCurrentValue: roleController.text,
                                onChangeRadioButton: (value) => setState(() {
                                  if (value != null)
                                    roleController.text = value;
                                }),
                              ),
                            ),
                            if (isEditing)
                              TextButton(
                                onPressed: () {
                                  _handleUpdateInformation();
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.black)),
                                child: Text(
                                  "Update information",
                                  style: GoogleFonts.openSans(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                          ],
                        ),
                      ))
                ],
              ),
            )
        ],
      )),
    );
  }

  Future<void> _handleUpdateInformation() async {
    Get.dialog(const Center(child: CircularProgressIndicator()));
    var map = <String, Object?>{
      "gender": genderController.text == "Male" ? 0 : 1,
      "email": checkEmailFormat(emailController.text),
      "age": int.tryParse(ageController.text),
      "phone_number": int.tryParse(phoneController.text) != null
          ? phoneController.text
          : widget.user.phoneNumber,
      "userRole": roleController.text,
    };
    debugPrint(map.toString());
    final response = await UserRepository.update(widget.user.id!, map);
    Get.back();
    if (response != null) {
      Get.snackbar("Update successfully",
          "Successfully update user with id ${widget.user.id}",
          backgroundColor: Colors.white);
    } else {
      Get.snackbar("Error",
          "An error has ocurred when updating user with id ${widget.user.id}",
          backgroundColor: Colors.white);
    }
    setState(() {
      isEditing = false;
      if (response != null) user = response;
    });
  }

  String? checkEmailFormat(String value) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (emailValid) return value;
    return widget.user.email;
  }
}

class SwitchTextInput extends StatelessWidget {
  final TextEditingController controller;
  final bool editing;
  final String hintText;
  final String label;
  final bool isRadio;
  final List<String>? radioValueList;
  final String? radioCurrentValue;
  final Function(String? value)? onChangeRadioButton;

  final TextInputType? keyboardType;
  const SwitchTextInput(
      {super.key,
      required this.controller,
      required this.editing,
      required this.hintText,
      required this.label,
      this.isRadio = false,
      this.radioValueList,
      this.radioCurrentValue,
      this.onChangeRadioButton,
      this.keyboardType})
      : assert(!isRadio ||
            (isRadio && radioValueList != null && radioCurrentValue != null));

  @override
  Widget build(BuildContext context) {
    if (editing) {
      return isRadio
          ? Column(
              children: [
                Row(
                  children: [
                    Text(
                      "$label: ",
                      style: GoogleFonts.openSans(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                ...radioValueList!.map(
                  (e) => ListTile(
                      title: Text(e),
                      leading: Radio<String>(
                          value: e,
                          groupValue: radioCurrentValue,
                          onChanged: (value) {
                            if (onChangeRadioButton != null) {
                              onChangeRadioButton!(value);
                            }
                          })),
                )
              ],
            )
          : Flexible(
              child: TextField(
                controller: controller,
                keyboardType: keyboardType,
                decoration:
                    InputDecoration(hintText: hintText, labelText: label),
              ),
            );
    }
    return Row(
      children: [
        Text("$label: ${controller.text}"),
      ],
    );
  }
}
