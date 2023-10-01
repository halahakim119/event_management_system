import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';

import '../../../../../core/router/app_router.dart';
import '../../../../../core/strings/strings.dart';
import '../../../domain/entities/draft/draft.dart';
import 'description_field.dart';
import 'end_date_field.dart';
import 'end_time_field.dart';
import 'guest_number_field.dart';
import 'start_date_field.dart';
import 'start_time_field.dart';
import 'title_field.dart';

class CreateEditDraftFormWidget extends StatefulWidget {
  Draft? draft;
  bool? isEdit;
  CreateEditDraftFormWidget({super.key, this.draft, this.isEdit});

  @override
  State<CreateEditDraftFormWidget> createState() =>
      _CreateEditDraftFormWidgetState();
}

class _CreateEditDraftFormWidgetState extends State<CreateEditDraftFormWidget> {
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
  Color? _dressCodeColor;
  String? startingDate;
  String? endingDate;
  String? startsAt;
  String? endsAt;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.draft != null) {
      _titleController.text = widget.draft!.title!;
      _descriptionController.text = widget.draft!.description!;
      _seatNumberController.text = widget.draft!.guestsNumber!.toString();

      DateTime dateStartTime = DateTime.parse(widget.draft!.startingDate!);
      String formattedDate = DateFormat('yyyy-MM-dd').format(dateStartTime);
      _startingDateController.text = formattedDate;

      startingDate = widget.draft!.startingDate!;

      DateTime dateEndTime = DateTime.parse(widget.draft!.endingDate!);
      String formattedDateend = DateFormat('yyyy-MM-dd').format(dateEndTime);
      _endingDateController.text = formattedDateend;
      endingDate = widget.draft!.endingDate!;

      DateTime startTime = DateTime.parse(widget.draft!.startsAt!);
      String startAtTime =
          "${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}";

      _startsAtController.text = startAtTime;
      startsAt = widget.draft!.startsAt!;
      DateTime endTime = DateTime.parse(widget.draft!.startsAt!);
      String endAtTime =
          "${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}";

      _endsAtController.text = endAtTime;
      endsAt = widget.draft!.startsAt!;

      _eventTypeController.text = widget.draft!.type!;
      _selectedEventType = widget.draft!.type!;

      _postTypeController.text = widget.draft!.postType!;
      _selectedPostType = widget.draft!.postType;

      var colorString =
          widget.draft!.dressCode!.replaceAll("Color(", "").replaceAll(")", "");
      Color? dressCode;
      if (colorString.startsWith('0x')) {
        // Remove '0x' to get the hexadecimal color string
        String hexColor = colorString.substring(2);

        // Parse the hexadecimal color string to a Color object
        dressCode = Color(int.parse(hexColor, radix: 16));
      }
      _dressCodeColor = dressCode;

      _adultsOnly = widget.draft!.adultsOnly!;
      _food = widget.draft!.food!;
      _alcohol = widget.draft!.alcohol!;
    }
  }

  Future<void> _selectDate(
    BuildContext context,
  ) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    // ignore: unrelated_type_equality_checks
    if (picked != null && picked != _selectedDate) {
      startingDate = picked.start.toUtc().toIso8601String();
      endingDate = picked.end.toUtc().toIso8601String();

      _startingDateController.text = DateFormat('yMd').format(picked.start);
      _endingDateController.text = DateFormat('yMd').format(picked.end);
    }
  }

  Future<void> _selectTime(BuildContext context, String type) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final formattedTime = DateFormat("yyyy-MM-dd'T'HH:mm").format(DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          picked.hour,
          picked.minute));
      final formattedDateTime = "$formattedTime:00.000Z";
      type == "start"
          ? _startsAtController.text = "${picked.hour}:${picked.minute}"
          : _endsAtController.text = "${picked.hour}:${picked.minute}";
      type == "start"
          ? startsAt = formattedDateTime
          : endsAt = formattedDateTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleField(titleController: _titleController),
            const SizedBox(height: 15),
            DescriptionField(descriptionController: _descriptionController),
            const SizedBox(height: 15),
            GuestNumberField(seatNumberController: _seatNumberController),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: StartDateField(
                  startingDateController: _startingDateController),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: EndDateField(endingDateController: _endingDateController),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                _selectTime(context, 'start');
              },
              child: StartTimeField(startsAtController: _startsAtController),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                _selectTime(context, 'end');
              },
              child: EndTimeField(endsAtController: _endsAtController),
            ),
            const SizedBox(height: 15),
            colorPickerMethod(context),
            const SizedBox(height: 15),
            eventType(),
            const SizedBox(height: 15),
            postType(),
            const SizedBox(height: 15),
            SwitchListTile(
              title: const Text('Adults Only'),
              value: _adultsOnly,
              onChanged: (value) {
                setState(() {
                  _adultsOnly = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Food'),
              value: _food,
              onChanged: (value) {
                setState(() {
                  _food = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Alcohol'),
              value: _alcohol,
              onChanged: (value) {
                setState(() {
                  _alcohol = value;
                });
              },
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceEvenly,
                direction: Axis.horizontal,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.error),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            actionsAlignment: MainAxisAlignment.spaceEvenly,
                            content: const Text(
                                textAlign: TextAlign.center,
                                'Are you sure you want to cancel draft creation?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  _clearForm();
                                  context.router
                                      .popUntilRouteWithName('DraftListRoute');
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('CANCEL'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).disabledColor),
                    onPressed: _clearForm,
                    child: const Text('RESET'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        Draft draft = Draft(
                            id: widget.draft?.id,
                            guestsNumbers: widget.draft?.guestsNumbers,
                            adultsOnly: _adultsOnly,
                            food: _food,
                            alcohol: _alcohol,
                            description: _descriptionController.text,
                            dressCode: _dressCodeColor.toString(),
                            endingDate: endingDate,
                            endsAt: endsAt,
                            guestsNumber: int.parse(_seatNumberController.text),
                            postType: _selectedPostType,
                            startingDate: startingDate,
                            startsAt: startsAt,
                            title: _titleController.text,
                            type: _selectedEventType);
                        context.router.push(InvitationRoute(
                            draft: draft, isEdit: widget.isEdit));
                      }
                    },
                    child: const Text(
                      'NEXT',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

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
      _dressCodeColor = null;
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

    super.dispose();
  }

  DropdownButtonFormField<String> postType() {
    return DropdownButtonFormField<String>(
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
    );
  }

  DropdownButtonFormField<String> eventType() {
    return DropdownButtonFormField<String>(
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
    );
  }

  GestureDetector colorPickerMethod(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Pick a color!'),
            content: SingleChildScrollView(
              child: ColorPicker(
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
                        color: _dressCodeColor ?? Colors.transparent,
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
    );
  }
}
