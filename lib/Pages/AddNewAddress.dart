import 'package:arkan/Providers/AddressesProvider.dart';
import 'package:arkan/helpers/helpers.dart';
import 'package:arkan/widgets/Buttons.dart';
import 'package:arkan/widgets/SizedBoxWidget.dart';
import 'package:arkan/widgets/Texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class AddNewAddress extends StatefulWidget {
  @override
  _AddNewAddressState createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  Map<String, String> params = {};
  final _formKey = GlobalKey<FormState>();

  AddressProvider _addressProvider;
  @override
  Widget build(BuildContext context) {
    if (_addressProvider == null) {
      _addressProvider = Provider.of(context);
    }
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 3,
            leading: IconButton(
              icon: Icon(
                Boxicons.bx_arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                pop(context);
              },
            ), // icon depends on TargetPlattrom

            title: Texts(
              title: "Add new Address",
              fSize: 16,
              color: Colors.black,
            ),
          ),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZuiefT_KDbBbPL3-aa1r6oIN3AMVhx-J24A&usqp=CAU',
                            height: 130,
                            width: 600,
                            fit: BoxFit.cover,
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.my_location,
                          size: 30,
                          color: mainColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Texts(
                          title: "Change location",
                          fSize: 13,
                          color: mainColor,
                          weight: FontWeight.bold,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Box(18),
              Container(
                color: Colors.black12,
                padding: EdgeInsets.all(18),
                width: double.infinity,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Texts(
                      title: "Address ",
                      fSize: 16,
                      color: Colors.black,
                      weight: FontWeight.bold,
                    )),
              ),
              Box(18),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildTextField(
                          lable: "City",
                          name: 'city',
                          keyboard: TextInputType.text),
                      Box(10),
                      buildTextField(
                          lable: "Street",
                          name: 'street',
                          keyboard: TextInputType.text),
                      Box(10),
                      buildTextField(lable: "Block", name: 'block'),
                      Box(10),
                      buildTextField(lable: "Building", name: 'building'),
                      Box(10),
                      buildTextField(lable: "Floor", name: 'floor'),
                      Box(10),
                      buildTextField(lable: "Flat No", name: 'falt_no'),
                      Box(10),
                      buildTextField(
                          lable: "Additional directions",
                          keyboard: TextInputType.text,
                          name: 'additional_directions'),
                      Box(10),
                      buildTextField(
                          lable: "Add Label",
                          name: 'lable',
                          keyboard: TextInputType.text),
                      Box(10)
                    ],
                  ),
                ),
              ),
              Box(18),
              Container(
                color: Colors.black12,
                padding: EdgeInsets.all(18),
                width: double.infinity,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Texts(
                      title: "Contact",
                      fSize: 16,
                      color: Colors.black,
                      weight: FontWeight.bold,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: buildTextField(
                    lable: "Phone Number",
                    name: 'phone',
                ),
              ),
              Box(10),
              _addressProvider.addLoad
                  ? Center(
                      child: SpinKitRing(
                        size: 37,
                        color: mainColor,
                        lineWidth: 3,
                        duration: Duration(milliseconds: 700),
                      ),
                    )
                  : Container(
                      height: 50,
                      child: Buttons(
                        title: "Save",
                        fSize: 15,
                        bgColor: mainColor,
                        horizontalMargin: 18,
                        radius: 5,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _addressProvider.addNewAddress(context,params);
                          }
                        },
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  buildTextField({lable, name, keyboard = TextInputType.number}) =>
      TextFormField(
          keyboardType: keyboard,
          validator: (v) {
            if (v.toString().trim().isEmpty) {
              return lable + " Is Required";
            }
            return null;
          },
          onChanged: (v) {
            params[name] = v.toString();
          },
          decoration: InputDecoration(labelText: lable));
}
