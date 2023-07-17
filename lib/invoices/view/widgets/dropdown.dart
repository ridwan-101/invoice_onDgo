import 'package:flutter/material.dart';

class CustomMultiselectDropDown extends StatefulWidget {
  final Function(List<String>) selectedList;
  final List<String> listOFStrings;

  CustomMultiselectDropDown(
      {required this.selectedList, required this.listOFStrings});

  @override
  createState() {
    return new _CustomMultiselectDropDownState();
  }
}

class _CustomMultiselectDropDownState extends State<CustomMultiselectDropDown> {
  List<String> listOFSelectedItem = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: ExpansionTile(
        iconColor: Colors.grey,
        title: Text(
          listOFSelectedItem.isEmpty ? "Select" : listOFSelectedItem.join(', '),
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
            fontSize: 15.0,
          ),
        ),
        children: <Widget>[
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.listOFStrings.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 8.0),
                child: _ViewItem(
                  item: widget.listOFStrings[index],
                  selected: (val) {
                    if (listOFSelectedItem.contains(val)) {
                      listOFSelectedItem.remove(val);
                    } else {
                      listOFSelectedItem.add(val);
                    }
                    widget.selectedList(listOFSelectedItem);
                  },
                ),
              );
            },
          ),
        ],
        onExpansionChanged: (bool) {},
      ),
    );
  }
}

class _ViewItem extends StatefulWidget {
  final String item;
  final Function(String) selected;

  const _ViewItem({Key? key, required this.item, required this.selected})
      : super(key: key);

  @override
  __ViewItemState createState() => __ViewItemState();
}

class __ViewItemState extends State<_ViewItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.selected(widget.item);
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            isSelected
                ? const Icon(
                    Icons.check_box,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.check_box_outline_blank,
                    color: Colors.grey,
                  ),
            const SizedBox(width: 8.0),
            Text(widget.item),
          ],
        ),
      ),
    );
  }
}