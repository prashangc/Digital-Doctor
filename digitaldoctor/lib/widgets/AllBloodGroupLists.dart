import 'package:flutter/material.dart';

import '../model/BloodGroupsDataModel.dart';

class AllBloodGroupLists extends StatefulWidget {
  final BloodGroups bloodGroups;

  final onTap;
  final isSelected;
  const AllBloodGroupLists(this.bloodGroups, this.onTap, this.isSelected);

  @override
  State<AllBloodGroupLists> createState() => _AllBloodGroupListsState();
}

class _AllBloodGroupListsState extends State<AllBloodGroupLists> {
  final _color = Colors.green;
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 100,
        width: width / 5,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: widget.isSelected
                    ? _color
                    : const Color.fromARGB(255, 223, 220, 220))),
        child: Center(
          child: Text(
            widget.bloodGroups.bloodGroup.toString(),
          ),
        ),
      ),
    );
  }
}
