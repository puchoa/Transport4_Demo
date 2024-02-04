import 'package:flutter/material.dart';
import 'package:transport4_demo_app/screens/add_items.dart';

class EmptyList extends StatefulWidget {
  final bool isTags;
  final bool isWeb;
  final String title;
  final int index;
  const EmptyList(
      {super.key,
      required this.isTags,
      required this.isWeb,
      required this.index,
      required this.title});
  @override
  State<EmptyList> createState() => _EmptyListState();
}

class _EmptyListState extends State<EmptyList> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
          width: MediaQuery.of(context).size.width * .9,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .7,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: IconButton(
                    onPressed: () async {
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (builder) => AddItems(
                                isGrocery: false,
                                index: widget.index,
                                isTags: widget.isTags,
                                isWeb: widget.isWeb,
                                items: const [],
                                title: widget.title,
                              )));
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.grey.shade500,
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
