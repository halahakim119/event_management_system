import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:filter_list/filter_list.dart';

@RoutePage()
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> selectedFilterList = [];
  List<String> filterList = [
    "Option 1",
    "Option 2",
    "Option 3",
    "Option 4",
    "Option 5",
  ];
void _openFilterDialog() async {
  await FilterListDialog.display<String>(context,
      listData: filterList,
      selectedListData: selectedFilterList,
      height: 480,
      borderRadius: 20,
      headlineText: "Select Options",
      
      choiceChipLabel: (item) {
        return item;
      },
      validateSelectedItem: (list, val) {
        return list!.contains(val);
      },
      onItemSearch: (list, text) {
        if (text.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      },
      onApplyButtonClick: (list) {
        if (list != null) {
          setState(() {
            selectedFilterList = List.from(list);
          });
        }
        Navigator.pop(context);
      });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Hero(
            tag: 'searchIcon',
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: _openFilterDialog,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Display selected filter options
            Container(
              padding: const EdgeInsets.all(10),
              child: Wrap(
                spacing: 8.0, // Gap between items
                runSpacing: 4.0, // Gap between lines
                children: selectedFilterList
                    .map((filter) => Chip(label: Text(filter)))
                    .toList(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedFilterList = List.from(filterList);
                });
              },
              child: Text("Select All"),
            ),
            ElevatedButton(
              onPressed: _openFilterDialog,
              child: Text("Apply Filter"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedFilterList.clear();
                });
              },
              child: Text("Reset Filter"),
            )
          ],
        ),
      ),
    );
  }
}
