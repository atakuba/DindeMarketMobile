import 'package:dinde_market/models/district.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dinde_market/pages/opening_pages/district_modal_widget.dart';
import 'package:dinde_market/provider/district_provider.dart';
import 'package:dinde_market/provider/user_provider.dart';
import 'package:dinde_market/utility/utilities.dart';

class EditUserPage extends StatefulWidget {
  final String title;
  final String textFieldLabel;
  final String textFieldValue;
  final String textFieldHint;
  final bool isTextField;
  const EditUserPage(
      {super.key,
      required this.title,
      required this.textFieldLabel,
      required this.textFieldValue,
      required this.textFieldHint,
      required this.isTextField});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  var returnValue = "";
  var selectedDistrict = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =
        TextEditingController(text: widget.textFieldValue);

    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final List<District> districtList =
              ref.read(districtProvider.notifier).state.toList();

          if (selectedDistrict == "") {
            selectedDistrict = ref.read(userProvider).region?.name ?? "";
          }

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                    height: Utilities.setWidgetHeightByPercentage(context, 6)),
                SizedBox(
                  height: Utilities.setWidgetHeightByPercentage(context, 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: Utilities.setWidgetWidthByPercentage(
                              context, 20)),
                      Text(
                        widget.title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      TextButton(
                        child: const Text(
                          "Готово",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        onPressed: () {
                          // Trigger form validation
                          if (widget.isTextField &&
                              _formKey.currentState!.validate()) {
                            returnValue = controller.text;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text("${widget.title} успешно изменено")),
                            );
                            Navigator.of(context).pop(returnValue);
                          } else if (!widget.isTextField) {
                            Navigator.of(context).pop(returnValue);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 3),
                        child: Text(
                          widget.textFieldLabel,
                          style: const TextStyle(
                              color: Color.fromRGBO(135, 146, 155, 1),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      widget.isTextField
                          ? Form(
                              key: _formKey,
                              child: TextFormField(
                                keyboardType: widget.title == "Номер телефона"
                                    ? TextInputType.phone
                                    : TextInputType.text,
                                inputFormatters: widget.title ==
                                        "Номер телефона"
                                    ? [
                                        LengthLimitingTextInputFormatter(19),
                                        PhoneNumberInputFormatter(),
                                      ]
                                    : [],
                                controller: controller,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromRGBO(177, 207, 183, 1)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromRGBO(177, 207, 183, 1)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromRGBO(177, 207, 183, 1)),
                                  ),
                                  hintText: widget.textFieldHint,
                                ),
                                validator: (value) {
                                  if (widget.isTextField) {
                                    if (widget.title == "Имя") {
                                      if (value == null || value.isEmpty) {
                                        return 'Пожалуйста, введите имя';
                                      } else if (value.length < 2) {
                                        return 'Имя должно содержать не менее 2 символов';
                                      } else if (!RegExp(r'^[a-zA-Z]+$')
                                          .hasMatch(value)) {
                                        return 'Имя должно содержать только буквы';
                                      }
                                    } else if (widget.title == "Фамилия") {
                                      if (value == null || value.isEmpty) {
                                        return 'Пожалуйста, введите фамилию';
                                      } else if (value.length < 2) {
                                        return 'Фамилия должна содержать не менее 2 символов';
                                      } else if (!RegExp(r'^[a-zA-Z]+$')
                                          .hasMatch(value)) {
                                        return 'Фамилия должна содержать только буквы';
                                      }
                                    } else if (widget.title ==
                                        "Номер телефона") {
                                      if (value == null || value.isEmpty) {
                                        return 'Пожалуйста, введите номер телефона';
                                      } else if (!RegExp(
                                              r'^\+996 \(\d{3}\) \d{2} \d{2} \d{2}$')
                                          .hasMatch(value)) {
                                        return 'Формат номера телефона: +996 (XXX) XX XX XX';
                                      }
                                    }
                                  }
                                  return null;
                                },
                                maxLines: 1,
                              ),
                            )
                          : SizedBox(
                              width: Utilities.setWidgetWidthByPercentage(
                                  context, 90),
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                    side: const BorderSide(
                                        color: Color.fromRGBO(177, 207, 183, 1),
                                        width: 1.0),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                  ),
                                  child: Text(
                                    selectedDistrict,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(),
                                  ),
                                  onPressed: () async {
                                    final newDistrict =
                                        await DistrictModal.districtModalWidget(
                                            context: context,
                                            districtList: districtList);
                                    setState(() {
                                      selectedDistrict = newDistrict;
                                      returnValue = newDistrict;
                                    });
                                  }),
                            ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class PhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Start with "+996"
    String text = newValue.text;

    // If the input is empty, return the original value
    if (text.isEmpty) return const TextEditingValue();
    // Remove all non-digit characters except for the leading '+'
    text = text.replaceAll(
        RegExp(r'(?<!^)\D'), ''); // This keeps the '+' at the start if present

    // Rebuild the phone number with the format
    String formattedText = '';

    // Handle the '+' symbol
    if (text.startsWith('+')) {
      formattedText += '+996 '; // Prepend the country code
      text =
          text.replaceFirst('+', ''); // Remove the '+' for further formatting
    } else {
      formattedText += '+996 '; // Add country code if no '+' is present
    }

    // Format the rest of the number
    // Remove the country code digits from the input for further processing
    text = text.replaceFirst('996', '');

    // Handle formatting based on the length of the input
    if (text.length > 3) {
      formattedText += '(${text.substring(0, 3)}'; // Area code (XXX)
      if (text.length > 3) {
        formattedText += ') ${text.substring(3, 5)}'; // First two digits (XX)
        if (text.length > 5) {
          formattedText += ' ${text.substring(5, 7)}'; // Next two digits (XX)
          if (text.length > 7) {
            formattedText += ' ${text.substring(7)}'; // Last digits
          }
        }
      } else {
        formattedText += ')'; // Close area code if less than 6 digits
      }
    } else if (text.isNotEmpty) {
      formattedText +=
          '(${text.substring(0)}'; // Handle first three digits only
    }

    // Return the new value with the formatted text
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(
          offset: formattedText.length), // Move the cursor to the end
    );
  }
}
