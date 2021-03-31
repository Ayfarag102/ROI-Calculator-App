import 'package:flutter/material.dart';
import 'package:note_keeper_app/components/z_animated_toggle.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import './../models_providers/theme_provider.dart';

class MainDrawer extends StatefulWidget {
  double width;

  MainDrawer(this.width);

  @override
  _MainDrawerState createState() => _MainDrawerState(this.width);
}

@override
class _MainDrawerState extends State<MainDrawer>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    super.initState();
  }

// function to toggle circle animation
  changeThemeMode(bool theme) {
    if (!theme) {
      _animationController.forward(from: 0.0);
    } else {
      _animationController.reverse(from: 1.0);
    }
  }

  // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int count = 0;
  double width;
  _MainDrawerState(this.width);
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Preferences',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: themeProvider.isLightTheme
                      ? Color(0xFF1E1F28)
                      : Colors.white),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: width * 0.35,
            height: width * 0.35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: themeProvider.themeMode().gradient,
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text("Change your theme preference here"),
          SizedBox(
            height: 10,
          ),
          ZAnimatedToggle(
            values: ['Light', 'Dark'],
            onToggleCallback: (v) async {
              await themeProvider.toggleThemeData();
              setState(() {});
              changeThemeMode(themeProvider.isLightTheme);
            },
          ),
          SizedBox(
            height: 150,
          ),
          Text(
            "MXS DEV & PRODUCTIONS\n© 2021",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
