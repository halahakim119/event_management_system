import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/strings/strings.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../domain/entities/filter_host_entity.dart';
import '../../logic/cubit/hosts_cubit.dart';

class HostFilter extends StatefulWidget {
  const HostFilter({super.key});

  @override
  State<HostFilter> createState() => _HostFilterState();
}

class _HostFilterState extends State<HostFilter> {
  String? selectedProvince;
  String? selectedCategory;
  List<String> selectedServices = [];
  double? minCapacity;
  double? maxCapacity;
  RangeValues _currentRangeValues = RangeValues(0, 10); // Set initial values

  String translateProvince(String province, {required bool toEnglish}) {
    // Map containing Arabic province names as keys and their corresponding English names as values
    Map<String, String> provincesTranslation = {
      // Replace these values with the correct English names for the provinces
      'الأنبار': 'AlAnbar',
      'المثنى': 'AlMuthanna',
      'القادسية': 'AlQadisiyah',
      'النجف': 'AlNajaf',
      'أربيل': 'Erbil',
      'السليمانية': 'AlSulaymaniyah',
      'بابل': 'Babil',
      'بغداد': 'Baghdad',
      'البصرة': 'Basra',
      'ذي قار': 'DhiQar',
      'ديالى': 'Diyala',
      'دهوك': 'Duhok',
      'كربلاء': 'Karbala',
      'كركوك': 'Kirkuk',
      'ميسان': 'Maysan',
      'نينوى': 'Ninawa',
      'صلاح الدين': 'Saladin',
      'واسط': 'Wasit',
      'حلبجة': 'Halabja',
    };

    if (toEnglish) {
      return provincesTranslation[province] ?? province;
    } else {
      var reversedMap = provincesTranslation.map((k, v) => MapEntry(v, k));
      return reversedMap[province] ?? province;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(25),
          border:
              Border.all(width: 0.5, color: Theme.of(context).dividerColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: DropdownButtonFormField<String>(
                    value: selectedProvince,
                    iconSize: 0,
                    borderRadius: BorderRadius.circular(25),
                    items: getProvinces().map((province) {
                      return DropdownMenuItem<String>(
                        value: province,
                        child: Text(province),
                      );
                    }).toList(),
                    onChanged: (selectedValue) {
                      setState(() {
                        selectedProvince = selectedValue ?? selectedProvince;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: LocaleKeys.Province.tr(), suffixIcon: null)),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: DropdownButtonFormField<String>(
                  hint: const Text(
                    'Category',
                  ),
                  iconSize: 0,
                  value: selectedCategory,
                  borderRadius: BorderRadius.circular(25),
                  onChanged: (newValue) {
                    setState(() {
                      selectedCategory = newValue;
                    });
                  },
                  items: getHostCategorys().map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          const Divider(height: 50, thickness: 0.5),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Min Capacity: ${_currentRangeValues.start.toStringAsFixed(0)}'),
                  Text(
                      'Max Capacity: ${_currentRangeValues.end.toStringAsFixed(0)}'),
                ],
              ), // Display the end value of the range
              RangeSlider(
                values: _currentRangeValues,
                min: 0,
                max: 1000,
                onChanged: (RangeValues values) {
                  // Update the current values when the user interacts with the slider
                  setState(() {
                    _currentRangeValues = values;
                    minCapacity = values.start; // Update minCapacity
                    maxCapacity = values.end; // Update maxCapacity
                  });
                },
              ),
            ],
          ),
          const Divider(height: 50, thickness: 0.5),
          const Text('Select Services:'),
          Wrap(
            children: getServices().map((service) {
              return CheckboxListTile(
                title: Text(service),
                controlAffinity: ListTileControlAffinity.leading,
                checkColor: Theme.of(context).primaryColor,
                activeColor: Colors.transparent,
                value: selectedServices.contains(service),
                onChanged: (bool? value) {
                  setState(() {
                    if (value != null) {
                      if (value) {
                        selectedServices.add(service);
                      } else {
                        selectedServices.remove(service);
                      }
                    }
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              FilterHostEntity filterHostEntity = FilterHostEntity(
                category: selectedCategory,
                province: selectedProvince,
                services: selectedServices,
                maxCapacity: maxCapacity == null ? null : maxCapacity!.toInt(),
                minCapacity: minCapacity == null ? null : minCapacity!.toInt(),
              );
              context.read<HostsCubit>()
                ..filterHosts(filterHostEntity: filterHostEntity);
            },
            child: const Text('Apply filter'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                selectedCategory = null;
                selectedProvince = null;
                selectedServices = [];
                maxCapacity = 0;
                minCapacity = 0;
                _currentRangeValues = RangeValues(0, 10);
              });

              context.read<HostsCubit>()..filterHosts();
            },
            child: const Text('reset and show all'),
          ),
        ],
      ),
    );
  }
}
