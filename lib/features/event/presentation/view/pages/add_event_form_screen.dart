import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../../../core/strings/strings.dart';

@RoutePage()
class AddEventFormScreen extends StatefulWidget {
  const AddEventFormScreen({super.key});

  @override
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

  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        controller.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        controller.text =
            "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";
      });
    }
  }

  // create some values
  Color pickerColor = Colors.green;
  Color? _dressCodeColor; // Set initial color to null

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  String? _selectedEventType;
  String? _selectedPostType;
  bool _adultsOnly = false;
  bool _food = false;
  bool _alcohol = false;

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
                        label: Wrap(direction: Axis.horizontal,
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
                  decoration: InputDecoration(labelText: 'Event Type'),
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
                  decoration: InputDecoration(labelText: 'Post Type'),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a post type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                SwitchListTile(
                  title: Text('Adults Only'),
                  value: _adultsOnly,
                  onChanged: (value) {
                    setState(() {
                      _adultsOnly = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                SwitchListTile(
                  title: Text('Food'),
                  value: _food,
                  onChanged: (value) {
                    setState(() {
                      _food = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                SwitchListTile(
                  title: Text('Alcohol'),
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
                          _submitForm();
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

  void _submitForm() {
    print('Submitted Information:');
    print('Event Title: ${_titleController.text}');
    print('Event Description: ${_descriptionController.text}');
    print('Seat Number: ${_seatNumberController.text}');
    print('Starting Date: ${_startingDateController.text}');
    print('Ending Date: ${_endingDateController.text}');
    print('Starts At: ${_startsAtController.text}');
    print('Ends At: ${_endsAtController.text}');
    print('Dress Code: $_dressCodeColor');
    print('Event Type: ${_eventTypeController.text}');
    print('Post Type: ${_postTypeController.text}');
    print('Adults Only: $_adultsOnly');
    print('Food: $_food');
    print('Alcohol: $_alcohol');
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

    super.dispose();
  }
}
