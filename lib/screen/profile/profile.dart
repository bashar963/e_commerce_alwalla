import 'package:e_commerce_alwalla/controller/login_controller.dart';
import 'package:e_commerce_alwalla/generated/l10n.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final LoginController _loginController = Get.find();
  String _firstNameError,
      _lastNameError,
      _emailError,
      _dobError,
      _genderError,
      _gender;
  final _firstNameController = TextEditingController();
  final _dobController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _firstNameController.text = _loginController.user.value.firstname;
    _lastNameController.text = _loginController.user.value.lastname;
    _emailController.text = _loginController.user.value.email;
    _dobController.text = _loginController.user.value.dob;
    _gender = _loginController.user.value.gender;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                'Save',
                style: TextStyle(color: Theme.of(context).accentColor),
              ))
        ],
        brightness: Brightness.light,
        title: Text(S.of(context).my_profile),
        centerTitle: true,
        backgroundColor: whiteColor,
      ),
      body: GestureDetector(
          onTap: () {
            hideKeyboard(context);
          },
          child: body()),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: _firstNameController,
              keyboardType: TextInputType.text,
              cursorWidth: 1,
              textAlign: TextAlign.start,
              textDirection: TextDirection.ltr,
              autofocus: false,
              onChanged: (s) {
                setState(() {
                  _firstNameError = null;
                });
              },
              style: TextStyle(
                  color: blackColor, fontWeight: FontWeight.w800, fontSize: 15),
              decoration: InputDecoration(
                labelText: S.of(context).first_name,
                errorText: _firstNameError,
                labelStyle: subTextStyle,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorAccent)),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: lightGrey)),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            TextFormField(
              controller: _lastNameController,
              keyboardType: TextInputType.text,
              cursorWidth: 1,
              textAlign: TextAlign.start,
              textDirection: TextDirection.ltr,
              autofocus: false,
              onChanged: (s) {
                setState(() {
                  _lastNameError = null;
                });
              },
              style: TextStyle(
                  color: blackColor, fontWeight: FontWeight.w800, fontSize: 15),
              decoration: InputDecoration(
                labelText: S.of(context).last_name,
                errorText: _lastNameError,
                labelStyle: subTextStyle,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorAccent)),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: lightGrey)),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              cursorWidth: 1,
              textAlign: TextAlign.start,
              textDirection: TextDirection.ltr,
              autofocus: false,
              onChanged: (s) {
                setState(() {
                  _emailError = null;
                });
              },
              style: TextStyle(
                  color: blackColor, fontWeight: FontWeight.w800, fontSize: 15),
              decoration: InputDecoration(
                labelText: S.of(context).email,
                errorText: _emailError,
                labelStyle: subTextStyle,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorAccent)),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: lightGrey)),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            TextFormField(
              keyboardType: TextInputType.datetime,
              cursorWidth: 1,
              controller: _dobController,
              textAlign: TextAlign.start,
              textDirection: TextDirection.ltr,
              autofocus: false,
              readOnly: true,
              onTap: () async {
                var date = await showDatePicker(
                    context: Get.context,
                    initialDate: DateTime(1990),
                    firstDate: DateTime(1920),
                    lastDate: DateTime.now());
                if (date != null) {
                  setState(() {
                    _dobController.text = formatDate(date);
                  });
                }
              },
              onChanged: (s) {
                setState(() {
                  _dobError = null;
                });
              },
              style: TextStyle(
                  color: blackColor, fontWeight: FontWeight.w800, fontSize: 15),
              decoration: InputDecoration(
                labelText: S.of(context).dob,
                errorText: _dobError,
                labelStyle: subTextStyle,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorAccent)),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: lightGrey)),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    return '${date.year}/${date.month}/${date.day}';
  }
}
