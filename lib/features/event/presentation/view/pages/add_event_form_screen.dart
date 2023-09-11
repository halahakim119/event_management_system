import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../../core/strings/strings.dart';
import '../../../../profile/data/models/user_profile_model.dart';

@RoutePage()
class AddEventFormScreen extends StatefulWidget {
  const AddEventFormScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddEventFormScreenState createState() => _AddEventFormScreenState();
}

class _AddEventFormScreenState extends State<AddEventFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _seatNumberController = TextEditingController();
  final TextEditingController _startingDateController = TextEditingController();
  final TextEditingController _endingDateController = TextEditingController();
  final TextEditingController _startsAtController = TextEditingController();
  final TextEditingController _endsAtController = TextEditingController();
  final TextEditingController _eventTypeController = TextEditingController();
  final TextEditingController _postTypeController = TextEditingController();
  String? _selectedEventType;
  String? _selectedPostType;
  bool _adultsOnly = false;
  bool _food = false;
  bool _alcohol = false;
  UserProfileModel? user;
  final userBox = Hive.box<UserProfileModel>('userBox');

  DateTime _selectedDate = DateTime.now();

  void _onBoxChange() {
    setState(() {
      getUserData();
    });
  }

  @override
  void initState() {
    super.initState();

    getUserData();
    userBox.listenable().addListener(_onBoxChange);
  }

  void getUserData() {
    if (userBox.isNotEmpty) {
      user = userBox.getAt(0);
    }
  }

  Future<DateTime?> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      controller.text =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')} " +
              "${_selectedDate.hour.toString().padLeft(2, '0')}:${_selectedDate.minute.toString().padLeft(2, '0')}";
      return picked;
    }
    return null;
  }

  Future<DateTime?> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final DateTime selectedTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        picked.hour,
        picked.minute,
      );
      controller.text =
          "${selectedTime.year}-${selectedTime.month.toString().padLeft(2, '0')}-${selectedTime.day.toString().padLeft(2, '0')} " +
              "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";
      return selectedTime;
    }
    return null;
  }

  // create some values
  Color pickerColor = Colors.green;
  Color? _dressCodeColor; // Set initial color to null

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(labelText: 'Event Title'),
                  controller: _titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Event title cannot be empty';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  maxLength: 500,
                  decoration:
                      const InputDecoration(labelText: 'Event Description'),
                  controller: _descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Event description cannot be empty';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Seat Number'),
                  controller: _seatNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Seat number cannot be empty';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Seat number must be a valid integer';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => _selectDate(context, _startingDateController),
                  child: AbsorbPointer(
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'It cannot be empty';
                        }
                        return null;
                      },
                      controller: _startingDateController,
                      decoration:
                          const InputDecoration(labelText: 'Starting Date'),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => _selectDate(context, _endingDateController),
                  child: AbsorbPointer(
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'It cannot be empty';
                        }
                        return null;
                      },
                      controller: _endingDateController,
                      decoration:
                          const InputDecoration(labelText: 'Ending Date'),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'It cannot be empty';
                    }
                    return null;
                  },
                  controller: _startsAtController,
                  onTap: () => _selectTime(context, _startsAtController),
                  decoration: const InputDecoration(labelText: 'Starts At'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'It cannot be empty';
                    }
                    return null;
                  },
                  controller: _endsAtController,
                  onTap: () => _selectTime(context, _endsAtController),
                  decoration: const InputDecoration(labelText: 'Ends At'),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Pick a color!'),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            showLabel: true,
                            pickerColor: _dressCodeColor ?? Colors.transparent,
                            onColorChanged: (color) {
                              setState(() {
                                _dressCodeColor = color;
                              });
                            },
                          ),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text('Got it'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          ElevatedButton(
                            child: const Text('delete color selected'),
                            onPressed: () {
                              setState(() {
                                _dressCodeColor = null;
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        label: Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runAlignment: WrapAlignment.spaceBetween,
                          spacing: MediaQuery.of(context).size.width * 1 - 292,
                          children: [
                            const Text('Dress Code'),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              direction: Axis.horizontal,
                              children: [
                                Text(
                                  _dressCodeColor != null
                                      ? 'R: ${_dressCodeColor!.red}, G: ${_dressCodeColor!.green}, B: ${_dressCodeColor!.blue}'
                                      : 'Not selected',
                                  style: const TextStyle(fontSize: 12),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color:
                                        _dressCodeColor ?? Colors.transparent,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  borderRadius: BorderRadius.circular(25),
                  value: _selectedEventType,
                  onChanged: (value) {
                    setState(() {
                      _selectedEventType = value;
                      _eventTypeController.text = _selectedEventType!;
                    });
                  },
                  items: getEventTypes().map<DropdownMenuItem<String>>(
                    (String eventType) {
                      return DropdownMenuItem<String>(
                        value: eventType,
                        child: Text(eventType),
                      );
                    },
                  ).toList(),
                  decoration: const InputDecoration(labelText: 'Event Type'),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select an event type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  borderRadius: BorderRadius.circular(25),
                  value: _selectedPostType,
                  onChanged: (value) {
                    setState(() {
                      _selectedPostType = value;
                      _postTypeController.text = _selectedPostType!;
                    });
                  },
                  items: getPostTypes().map<DropdownMenuItem<String>>(
                    (String postType) {
                      return DropdownMenuItem<String>(
                        value: postType,
                        child: Text(postType),
                      );
                    },
                  ).toList(),
                  decoration: const InputDecoration(labelText: 'Post Type'),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a post type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                SwitchListTile(
                  title: const Text('Adults Only'),
                  value: _adultsOnly,
                  onChanged: (value) {
                    setState(() {
                      _adultsOnly = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                SwitchListTile(
                  title: const Text('Food'),
                  value: _food,
                  onChanged: (value) {
                    setState(() {
                      _food = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                SwitchListTile(
                  title: const Text('Alcohol'),
                  value: _alcohol,
                  onChanged: (value) {
                    setState(() {
                      _alcohol = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).disabledColor),
                      onPressed: _clearForm,
                      child: const Text('RESET'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Submit the form

                          log("Title: ${_titleController.text}");
                          log("Description: ${_descriptionController.text}");

                          log("Seat Number: ${_seatNumberController.text}");

                          log("Starting Date: ${_startingDateController.text}");
                          log("Ending Date: ${_endingDateController.text}");
                          log("Starts At: ${_startsAtController.text}");
                          log("Ends At: ${_endsAtController.text}");

                          log("Event Type: $_selectedEventType");
                          log("Post Type: $_selectedPostType");

                          log('plannerid${user!.id}');

                          log(_dressCodeColor.toString());

                          log("Adults Only: $_adultsOnly");
                          log("Food: $_food");
                          log("Alcohol: $_alcohol");
                        }
                      },
                      child: const Text('CREATE EVENT'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method to clear all form fields
  void _clearForm() {
    setState(() {
      _titleController.clear();
      _descriptionController.clear();
      _seatNumberController.clear();
      _startingDateController.clear();
      _endingDateController.clear();
      _startsAtController.clear();
      _endsAtController.clear();

      _eventTypeController.clear();
      _postTypeController.clear();
      _adultsOnly = false;
      _food = false;
      _alcohol = false;
      _selectedEventType = null;
      _selectedPostType = null;
      _dressCodeColor = null; // Clear color selection
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _seatNumberController.dispose();
    _startingDateController.dispose();
    _endingDateController.dispose();
    _startsAtController.dispose();
    _endsAtController.dispose();

    _eventTypeController.dispose();
    _postTypeController.dispose();
    _adultsOnly = false;
    _food = false;
    _alcohol = false;
    _selectedEventType = null;
    _selectedPostType = null;
    _dressCodeColor = null;
    userBox.listenable().removeListener(_onBoxChange);
    super.dispose();
  }
}
