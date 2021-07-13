import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinto/box-button.dart';
import 'package:vinto/box-text-field.dart';
import 'package:vinto/helper/colors.dart';
import 'package:vinto/services/user/user_service.dart';

class UpdatePassword extends StatefulWidget {
  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  TextEditingController _password = new TextEditingController();
  TextEditingController _repeatPassword = new TextEditingController();
  TextEditingController _oldPassword = new TextEditingController();
  bool showPassword = false;
  bool _loading = false;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Future update() async {
    setState(() {
      _loading = true;
    });
    final _response = await UserService().updatePassword({
      "old_password": _oldPassword.text,
      "new_password": _repeatPassword.text
    });

    if (_response.isRight()) {
      _response.fold((l) => null, (r) async {
        setState(() {
          _loading = false;
        });
        Navigator.of(context).pop();

        Get.snackbar(
          'Password Update',
          "password successfully updated",
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
      });
    } else if (_response.isLeft()) {
      _response.fold((l) {
        Get.snackbar(
          'Update Error',
          l.message,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
      }, (r) => null);
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Update Password",
          style: TextStyle(
              fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black45),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 80,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.vpn_key_rounded,
                                      size: 120, color: Mycolors.green),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ))),
                      SizedBox(
                        height: 10,
                      ),
                      BoxTextField(
                        label: "Old Password",
                        controller: _oldPassword,
                        obsecure: !showPassword,
                        validator: (str) {
                          if (str.isEmpty) {
                            return "required";
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BoxTextField(
                        label: "New Password",
                        controller: _password,
                        obsecure: !showPassword,
                        validator: (str) {
                          if (str.isEmpty) {
                            return "required";
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BoxTextField(
                        label: "Confirm Password",
                        controller: _repeatPassword,
                        obsecure: !showPassword,
                        validator: (str) {
                          if (str.isEmpty) {
                            return "Please confirm";
                          } else if (str != _password.text) {
                            return "Passwords must match";
                          }

                          return null;
                        },
                      ),
                      Center(
                        child: BoxButton(
                          loading: _loading,
                          lable: "update",
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              await update();
                            }
                          },
                        ),
                      ),
                    ],
                  )),
            )
          ]))
        ],
      ),
    );
  }
}
