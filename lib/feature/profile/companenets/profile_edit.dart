import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mapsuygulama/feature/profile/companenets/text/profile_edit_about_text.dart';
import 'package:mapsuygulama/feature/profile/companenets/text/profile_edit_text.dart';
import 'package:mapsuygulama/product/database/database_service.dart';
import 'package:mapsuygulama/product/database/user_data_service.dart';
import 'package:mapsuygulama/feature/profile/companenets/text/profile_edit_input_text.dart';
import 'package:mapsuygulama/feature/google/custom_widget.dart';
import 'package:mapsuygulama/product/utils/const/string_const.dart';
import 'package:mapsuygulama/product/utils/image_util.dart';

class ProfileEdit extends StatefulWidget {
  ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 40, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(width: 3, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.4),
                          )
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: imageUrl != null
                              ? NetworkImage(imageUrl!)
                              : NetworkImage(
                                  StringConstants.iconUrl,
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 0,
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1,
                                color: Colors.white,
                              ),
                              color: Colors.black),
                          child: IconButton(
                            icon: Icon(
                              Icons.add_a_photo,
                            ),
                            color: Colors.white,
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              );

                              try {
                                final file = await getImage();
                                if (file != null) {
                                  final imageUrl =
                                      await DatabaseServices.uploadImage(file);
                                  setState(() {
                                    this.imageUrl = imageUrl;
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                    msg: 'Lütfen başka bir fotoğraf seçin.',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 3,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                  );
                                }
                              } finally {
                                Navigator.pop(
                                  context,
                                );
                              }
                            },
                          )),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AboutMeWidget(),
                  SpecialTexts(text: 'name_surname'.tr()),
                  TextInputField(
                    textController: _nameController,
                  ),
                  SpecialTexts(text: 'location'.tr()),
                  TextInputField(
                    textController: _locationController,
                  ),
                  SpecialTexts(text: 'age'.tr()),
                  TextInputField(
                    textController: _ageController,
                  ),
                ],
              ),
              SizedBox(height: 40),
              Center(
                child: _saveButton(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton _saveButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_nameController.text.isEmpty ||
            _locationController.text.isEmpty ||
            _ageController.text.isEmpty) {
          Fluttertoast.showToast(
            msg: 'all_information_required'.tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );
        } else {
          int? age = int.tryParse(_ageController.text);
          if (age == null) {
            Fluttertoast.showToast(
              msg: 'age_area'.tr(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.black,
              textColor: Colors.white,
            );
          } else {
            if (imageUrl == null) {
              Fluttertoast.showToast(
                msg: "select_image".tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.black,
                textColor: Colors.white,
              );
            } else {
              FirebaseService.saveUserData(
                _nameController.text,
                _locationController.text,
                age.toString(),
                imageUrl.toString(),
              ).then((value) {
                Fluttertoast.showToast(
                  msg: 'correct_data'.tr(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 3,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                );
                Future.delayed(
                  Duration(seconds: 2),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomMarkerInfoWindow(
                       
                        ),
                      ),
                    );
                  },
                );
              });
            }
          }
        }
      },
      child: Text(
        'save'.tr().toUpperCase(),
        style: TextStyle(
          fontSize: 15,
          letterSpacing: 2,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 120),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: Size(10, 50),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        color: Colors.black38,
        onPressed: () {},
      ),
      title: Text(
        StringConstants.profile,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
