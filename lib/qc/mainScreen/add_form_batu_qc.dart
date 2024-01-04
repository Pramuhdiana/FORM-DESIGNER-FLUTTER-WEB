// ignore_for_file: sized_box_for_whitespace, avoid_print, depend_on_referenced_packages
import 'package:flutter/material.dart';

class AddFormBatuQc extends StatefulWidget {
  const AddFormBatuQc({super.key});

  @override
  State<AddFormBatuQc> createState() => _AddFormBatuQcState();
}

class _AddFormBatuQcState extends State<AddFormBatuQc> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            "Form Batu QC",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
              child: Column(
            children: [
              Container(
                height: 50,
                width: 500,
                child: ElevatedButton(
                  child: const Text('Tambah Batu'),
                  onPressed: () {
                    showGeneralDialog(
                        barrierColor: Colors.black.withOpacity(0.5),
                        transitionBuilder: (context, a1, a2, widget) {
                          return Transform.scale(
                            scale: a1.value,
                            child: Opacity(
                              opacity: a1.value,
                              child: AlertDialog(
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0)),
                                title: const Text('Pilih Kategori'),
                                content: Stack(
                                    clipBehavior: Clip.none,
                                    children: <Widget>[
                                      ConstrainedBox(
                                        constraints: const BoxConstraints(
                                            maxHeight: 400),
                                        // ignore: avoid_unnecessary_containers
                                        child: Container(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Center(
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    for (var i = 0; i < 3; i++)
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 15),
                                                            child: SizedBox(
                                                              width: 150,
                                                              height: 60,
                                                              child:
                                                                  ElevatedButton(
                                                                style:
                                                                    ButtonStyle(
                                                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                            RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50.0),
                                                                  // side: BorderSide(color: Colors.grey.shade200)
                                                                ))),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    //icon
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              5),
                                                                      child: Image
                                                                          .asset(
                                                                              'images/diamond.png'),
                                                                    ),
                                                                    const Expanded(
                                                                      child:
                                                                          Text(
                                                                        'tes',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16),
                                                                        maxLines:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 25),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 15),
                                                            child: SizedBox(
                                                              width: 150,
                                                              height: 60,
                                                              child:
                                                                  ElevatedButton(
                                                                style:
                                                                    ButtonStyle(
                                                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                            RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50.0),
                                                                  // side: BorderSide(color: Colors.grey.shade200)
                                                                ))),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    const Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    //icon
                                                                    Padding(
                                                                        padding: EdgeInsets.only(
                                                                            right:
                                                                                5),
                                                                        child: Icon(
                                                                            Icons.arrow_forward_ios)),
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        'bagian 2',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16),
                                                                        maxLines:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                  ]),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Positioned(
                                      //   right: -5.0,
                                      //   top: -9.0,
                                      //   child: InkResponse(
                                      //     onTap: () {
                                      //       Navigator.of(context).pop();
                                      //     },
                                      //     //! Cancel
                                      //     child: Transform.scale(
                                      //         scale: 1,
                                      //         child: SizedBox(
                                      //             height: 40,
                                      //             child: Lottie.asset(
                                      //                 "json/icon_delete.json"))),
                                      //   ),
                                      // ),
                                    ]),
                              ),
                            ),
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 200),
                        barrierDismissible: true,
                        barrierLabel: '',
                        context: context,
                        pageBuilder: (context, animation1, animation2) {
                          return const Text('');
                        });
                  },
                ),
              ),
            ],
          )),
        ));
  }
}
