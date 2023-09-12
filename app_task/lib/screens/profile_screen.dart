import 'package:app_task/widgets/my_text_field.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredNumber = 1;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  DateTime _selectedBirthDate = DateTime(2017, 1, 2);

  final DateFormat formatter = DateFormat.yMd();

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("name", _enteredName);
      prefs.setInt("phone_no", _enteredNumber);
      prefs.setString("birth_date", _selectedBirthDate.toIso8601String());

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Saved Successfully"),
        ),
      );
    }
  }

  void _resetProfile() async {
    _formKey.currentState!.reset();
    nameController.text = '';
    phoneController.text = '';
    birthDateController.text = '';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", '');
    prefs.setInt("phone_no", 0);
    prefs.setString("birth_date", '');
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String date = prefs.getString("birth_date") ?? '';
    setState(() {
      _enteredName = prefs.getString("name") ?? "";

      _enteredNumber = prefs.getInt("phone_no") ?? 1;
      // _selectedBirthDate = DateTime.parse(date);

      nameController.text = prefs.getString("name") ?? "";
      phoneController.text = prefs.getInt("phone_no").toString() == "null"
          ? ""
          : prefs.getInt("phone_no").toString();
      birthDateController.text = prefs.getString('birth_date') ?? '';
    });
    print(_enteredName);
    print(_enteredNumber);
    print(_selectedBirthDate);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              "assets/images/profile.png",
              height: 350,
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              "Profile",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(
              height: 24,
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyTextField(
                    controller: nameController,
                    hintText: "Enter Your Name",
                    icon: FontAwesomeIcons.user,
                    saveProfile: (value) {
                      setState(() {
                        _enteredName = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  MyTextField(
                    controller: phoneController,
                    hintText: "Enter Your Mobile No.",
                    icon: FontAwesomeIcons.phone,
                    saveProfile: (value) {
                      setState(() {
                        _enteredNumber = int.parse(value);
                      });
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  DateTimeFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(66, 159, 159, 159)
                          .withOpacity(.2),
                      hintText: "Select DOB",
                      prefixIcon: const Icon(
                          size: 20,
                          FontAwesomeIcons.calendar,
                          color: Color.fromARGB(255, 7, 199, 78)),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 7, 199, 78),
                      ),
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (e) =>
                        (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                    onDateSelected: (DateTime value) {
                      setState(() {
                        _selectedBirthDate = value;
                      });
                    },
                    onSaved: (newValue) {
                      setState(() {
                        _selectedBirthDate = newValue!;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: _resetProfile,
                        child: const Text('Reset Profile'),
                      ),
                      ElevatedButton(
                        onPressed: _saveProfile,
                        child: const Text('Save Profile'),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
