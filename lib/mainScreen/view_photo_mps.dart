

// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/model/list_mps_model.dart';
import 'package:photo_view/photo_view.dart';

class ViewPhotoMpsScreen extends StatefulWidget {
  ListMpsModel? modelMps;

  ViewPhotoMpsScreen({
    super.key,
    this.modelMps,
  });
  @override
  State<ViewPhotoMpsScreen> createState() => _ViewPhotoMpsScreen();
}

class _ViewPhotoMpsScreen extends State<ViewPhotoMpsScreen> {
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
      backgroundColor: colorBG,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: 
          Text(
          '${widget.modelMps!.kodeDesignMdbc}',
          style: const TextStyle(color: Colors.black)),
        
        backgroundColor: Colors.grey.shade700,
      
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
          imageProvider:CachedNetworkImageProvider(
            ApiConstants.baseUrlImage + widget.modelMps!.imageUrl!,
          )
       ,
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
