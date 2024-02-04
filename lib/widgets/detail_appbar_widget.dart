import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:developer' as developer;

import 'package:transport4_demo_app/common.dart';

class DetailAppBar extends StatefulWidget {
  final String title;
  final String imageUrl;
  final bool isWeb;

  const DetailAppBar(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.isWeb});

  @override
  State<DetailAppBar> createState() => _DetailAppBarState();
}

class _DetailAppBarState extends State<DetailAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white,
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Colors.white),
              child: Center(
                  child: Text(
                formatText(widget.title),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              )))),
      expandedHeight: 275,
      flexibleSpace: FlexibleSpaceBar(
          background: widget.isWeb
              ? networkImage()
              : Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(color: Colors.grey.shade300),
                  child: Center(
                    child: FaIcon(
                      FontAwesomeIcons.image,
                      color: Colors.white,
                      size: MediaQuery.of(context).size.width * .3,
                    ),
                  ),
                )),
    );
  }

  Widget networkImage() {
    try {
      return FadeInImage.memoryNetwork(
        fit: BoxFit.cover,
        width: 70,
        height: 70,
        placeholder: kTransparentImage,
        image: widget.imageUrl,
      );
    } catch (e) {
      developer.log(
        "Error loading data: $e",
        name: "DetailAppBar",
      );

      return const Center(child: Text("Error loading image"));
    }
  }
}
