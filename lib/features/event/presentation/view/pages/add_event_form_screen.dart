import 'package:auto_route/auto_route.dart';
import 'package:event_management_system/core/utils/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

enum EventType { conference, seminar, workshop } // Add other event types

enum PostType { private, public } // Add other post types

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
  final TextEditingController _dressCodeController = TextEditingController();
  final TextEditingController _eventTypeController = TextEditingController();
  final TextEditingController _postTypeController = TextEditingController();
  final TextEditingController _adultsOnlyController = TextEditingController();
  final TextEditingController _foodController = TextEditingController();
  final TextEditingController _alcoholController = TextEditingController();

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
  Color pickerColor = Color(0xff443a49);
  Color _dressCodeColor = Color(0xff443a49); // Default color

  // ValueChanged<Color> callback
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
              children: [
                const SizedBox(height: 10),
                CustomTextField(
                  max: 50,
                  controller: _titleController,
                  labelText: 'Event Title',
                  validator: (value) {
                    if (value == null) {
                      return 'Event title cannot be empty';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  max: 500,
                  controller: _descriptionController,
                  labelText: 'Event Description',
                  validator: (value) {
                    if (value == null) {
                      return 'Event description cannot be empty';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _seatNumberController,
                  labelText: 'Seat Number',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null) {
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
                      controller: _endingDateController,
                      decoration:
                          const InputDecoration(labelText: 'Ending Date'),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _startsAtController,
                  onTap: () => _selectTime(context, _startsAtController),
                  decoration: const InputDecoration(labelText: 'Starts At'),
                ),
                const SizedBox(height: 10),
                TextFormField(
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
                            pickerColor: _dressCodeColor,
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
                        ],
                      ),
                    );
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      enableInteractiveSelection: true,
                      controller: _dressCodeController,
                      decoration: InputDecoration(
                        labelText: 'Dress Code',
                        suffixIcon: Container(
                          margin: const EdgeInsets.all(10),
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: _dressCodeColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField(
                  // value: _eventTypeController.text,
                  onChanged: (value) {
                    // Add onChanged logic for event type
                  },
                  items: EventType.values.map<DropdownMenuItem<String>>(
                    (EventType eventType) {
                      return DropdownMenuItem<String>(
                        value: eventType.toString(),
                        child: Text(eventType.toString()),
                      );
                    },
                  ).toList(),
                  decoration: InputDecoration(labelText: 'Event Type'),
                  validator: (value) {
                    // Add validation logic for event type
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField(
                  // value: _postTypeController.text,
                  onChanged: (value) {
                    // Add onChanged logic for post type
                  },
                  items: PostType.values.map<DropdownMenuItem<String>>(
                    (PostType postType) {
                      return DropdownMenuItem<String>(
                        value: postType.toString(),
                        child: Text(postType.toString()),
                      );
                    },
                  ).toList(),
                  decoration: InputDecoration(labelText: 'Post Type'),
                  validator: (value) {
                    // Add validation logic for post type
                  },
                ),
                const SizedBox(height: 10),
                SwitchListTile(
                  title: Text('Adults Only'),
                  value: _adultsOnlyController.text.toLowerCase() == 'true',
                  onChanged: (value) {
                    // Add onChanged logic for adults only
                  },
                ),
                const SizedBox(height: 10),
                SwitchListTile(
                  title: Text('Food'),
                  value: _foodController.text.toLowerCase() == 'true',
                  onChanged: (value) {
                    // Add onChanged logic for food
                  },
                ),
                const SizedBox(height: 10),
                SwitchListTile(
                  title: Text('Alcohol'),
                  value: _alcoholController.text.toLowerCase() == 'true',
                  onChanged: (value) {
                    // Add onChanged logic for alcohol
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Submit the form
                      _submitForm();
                    }
                  },
                  child: Text('Submit'),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
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
    print('Dress Code: ${_dressCodeController.text}');
    print('Event Type: ${_eventTypeController.text}');
    print('Post Type: ${_postTypeController.text}');
    print('Adults Only: ${_adultsOnlyController.text}');
    print('Food: ${_foodController.text}');
    print('Alcohol: ${_alcoholController.text}');
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
    _dressCodeController.dispose();
    _eventTypeController.dispose();
    _postTypeController.dispose();
    _adultsOnlyController.dispose();
    _foodController.dispose();
    _alcoholController.dispose();
    super.dispose();
  }
}
