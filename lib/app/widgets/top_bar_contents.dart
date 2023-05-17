import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_factores_flutter_web/app/routes/app_pages.dart';
import 'package:proyecto_final_factores_flutter_web/app/services/firebase_services/auth_service.dart';
import 'package:proyecto_final_factores_flutter_web/app/utils/utils.dart';

class TopBarContents extends StatefulWidget {
  @override
  _TopBarContentsState createState() => _TopBarContentsState();
}

class _TopBarContentsState extends State<TopBarContents> {
  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(Get.width, 1000),
      child: Container(
        color: Palette.mainBlue,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => Get.toNamed(Routes.HOME),
                child: Image.asset(
                  'assets/images/main_logo.png',
                  height: 45,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(width: Get.width / 30),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[0] = true
                              : _isHovering[0] = false;
                        });
                      },
                      onTap: () => Get.toNamed(Routes.REGISTER_PRODUCT),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Registrar produto',
                            style: TextStyle(
                              color: _isHovering[0]
                                  ? Palette.lightGreen
                                  : Palette.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[0],
                            child: Container(
                              height: 2,
                              width: 20,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: Get.width / 30),
                    // InkWell(
                    //   onHover: (value) {
                    //     setState(() {
                    //       value
                    //           ? _isHovering[1] = true
                    //           : _isHovering[1] = false;
                    //     });
                    //   },
                    //   onTap: () => Get.toNamed(Routes.HOME),
                    //   child: Column(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       Text(
                    //         'Agregar empresa',
                    //         style: TextStyle(
                    //           color: _isHovering[1]
                    //               ? Palette.yellow
                    //               : Palette.white,
                    //           fontWeight: FontWeight.w300,
                    //           fontSize: 20,
                    //         ),
                    //       ),
                    //       const SizedBox(height: 5),
                    //       Visibility(
                    //         maintainAnimation: true,
                    //         maintainState: true,
                    //         maintainSize: true,
                    //         visible: _isHovering[1],
                    //         child: Container(
                    //           height: 2,
                    //           width: 20,
                    //           color: Colors.white,
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(width: Get.width / 30),
                    // InkWell(
                    //   onHover: (value) {
                    //     setState(() {
                    //       value
                    //           ? _isHovering[2] = true
                    //           : _isHovering[2] = false;
                    //     });
                    //   },
                    //   onTap: () => Get.toNamed(Routes.HOME),
                    //   child: Column(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       Text(
                    //         'Contáctanos',
                    //         style: TextStyle(
                    //           color: _isHovering[2]
                    //               ? Palette.yellow
                    //               : Palette.white,
                    //           fontWeight: FontWeight.w300,
                    //           fontSize: 20,
                    //         ),
                    //       ),
                    //       const SizedBox(height: 5),
                    //       Visibility(
                    //         maintainAnimation: true,
                    //         maintainState: true,
                    //         maintainSize: true,
                    //         visible: _isHovering[2],
                    //         child: Container(
                    //           height: 2,
                    //           width: 20,
                    //           color: Colors.white,
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(width: Get.width / 30),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[3] = true
                              : _isHovering[3] = false;
                        });
                      },
                      onTap: () async {
                        await auth.signOut();
                        Get.offAllNamed(Routes.LOGIN);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Cerrar sesión',
                            style: TextStyle(
                              color: _isHovering[3]
                                  ? Palette.lightGreen
                                  : Palette.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[3],
                            child: Container(
                              height: 2,
                              width: 20,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
