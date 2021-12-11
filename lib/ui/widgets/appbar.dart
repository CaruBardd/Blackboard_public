import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends AppBar {
  final BuildContext context;
  final String picUrl;
  final Widget tile;
  final VoidCallback onSignOff;

  // Creating a custom AppBar that extends from Appbar with super();
  CustomAppBar(
      {Key? key,
      required this.context,
      required this.picUrl,
      required this.tile,
      required this.onSignOff})
      : super(
          key: key,
          centerTitle: true,
          leading: Center(
            child: CircleAvatar(
              minRadius: 18.0,
              maxRadius: 18.0,
              backgroundImage: NetworkImage(picUrl),
            ),
          ),
          title: tile,
          actions: [
            IconButton(
              key: const Key("themeAction"),
              icon: const Icon(
                Icons.brightness_4_rounded,
              ),
              onPressed: () async {
                /* var currentTheme = Get.isDarkMode ? "dark" : "light"; */
                SharedPreferences prefs = await SharedPreferences.getInstance();
                /* prefs.setString("theme", currentTheme); */
                Get.changeThemeMode(
                    Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                if (!Get.isDarkMode) {
                  prefs.setString("theme", "dark");
                } else {
                  prefs.setString("theme", "light");
                }

                dynamic theme = prefs.getString("theme");
                print("El tema es: " + theme);
              },
            ),
            IconButton(
              key: const Key("logoutAction"),
              icon: const Icon(
                Icons.logout,
              ),
              onPressed: onSignOff,
            )
          ],
        );
}
