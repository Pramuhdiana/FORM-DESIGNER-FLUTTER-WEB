// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/model/form_designer_model.dart';
import 'package:photo_view/photo_view.dart';

class ViewPhotoScreen extends StatefulWidget {
  FormDesignerModel? model;

  ViewPhotoScreen({
    super.key,
    this.model,
  });
  @override
  State<ViewPhotoScreen> createState() => _ViewPhotoScreen();
}

class _ViewPhotoScreen extends State<ViewPhotoScreen> {
  late PhotoViewScaleStateController scaleStateController;

  @override
  void initState() {
    super.initState();
    scaleStateController = PhotoViewScaleStateController();
  }

  @override
  void dispose() {
    scaleStateController.dispose();

    super.dispose();
  }

  void goBack() {
    scaleStateController.scaleState = PhotoViewScaleState.originalSize;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          '${widget.model!.kodeDesignMdbc}',
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.blue,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.blue,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
        ),
        // leading: IconButton(
        //   icon: Image.asset(
        //     "assets/arrow.png",
        //     width: 35,
        //     height: 35,
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      body: Stack(clipBehavior: Clip.none, children: <Widget>[
        Positioned(
          right: -547.0,
          top: -47.0,
          child: InkResponse(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.close),
            ),
          ),
        ),
        PhotoView(
          scaleStateController: scaleStateController,
          backgroundDecoration: const BoxDecoration(
            color: Colors.white,
          ),
          imageProvider: CachedNetworkImageProvider(
            ApiConstants.baseUrlImage + widget.model!.imageUrl!,
          ),
          maxScale: PhotoViewComputedScale.covered * 1.8,
          minScale: PhotoViewComputedScale.covered * 0.2,
          initialScale: PhotoViewComputedScale.contained * 1,
          enableRotation: true,
          customSize: MediaQuery.of(context).size,
          gaplessPlayback: false,
          basePosition: Alignment.center,
        )
      ]),
      // Stack(children: <Widget>[
      //   Positioned.fill(
      //     child: PhotoView(
      //       scaleStateController: scaleStateController,
      //       // backgroundDecoration: const BoxDecoration(
      //       //   color: Colors.white,
      //       // ),
      //       imageProvider: CachedNetworkImageProvider(
      //         ApiConstants.baseUrlImage + widget.model!.imageUrl!,
      //       ),
      //       // enableRotation: true,
      //       // minScale: PhotoViewComputedScale.covered * 0.2,
      //     ),
      //   ),
      //   ElevatedButton(
      //     onPressed: goBack,
      //     child: const Text("Go to original size"),
      //   )
      // ]),
    );
  }
}
