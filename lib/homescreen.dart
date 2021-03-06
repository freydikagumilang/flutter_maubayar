import 'package:flutter/material.dart';
import 'package:maubayar/dashboard/dashboard.dart';
import 'package:maubayar/masterdata.dart';
import 'package:maubayar/models/tabIcon_data.dart';
import 'package:maubayar/ui_view/biaya/input_biaya.dart';
import 'package:maubayar/ui_view/sysconfig/sysconfig.dart';
import 'bottom_navigation_view/bottom_bar_view.dart';
import 'fintness_app_theme.dart';

class HomeScreen extends StatefulWidget {
  final int tab_id;
  HomeScreen({this.tab_id=0});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>with TickerProviderStateMixin {

  AnimationController animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );


  @override
  void initState() {
    // TODO: implement initState
     tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[widget.tab_id].isSelected = true;

    animationController = AnimationController(
    duration: const Duration(milliseconds: 600), vsync: this);
    if(widget.tab_id==0){
      tabBody = Dashboard();
    }else if(widget.tab_id==1){
      tabBody = MasterData();
    }else if(widget.tab_id==2){
      tabBody = InputBiaya();
    }else if(widget.tab_id==3){
      tabBody = SysConfig();
    }
    

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async=>false,
          child: Container(
        color: FitnessAppTheme.background,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: FutureBuilder<bool>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              } else {
                return Stack(
                  children: <Widget>[
                    tabBody,
                    bottomBar(),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }
  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {
            Navigator.of(context, rootNavigator: true)
                  .pushNamed("/kasir");
          },
          changeIndex: (int index) {
            if (index == 0) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      Dashboard();
                });
              });
            } else if (index == 1) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      MasterData();
                });
              });
            }else if (index == 2) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      InputBiaya();
                });
              });
            }
            else if (index == 3) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      SysConfig();
                });
              });
            }
            // else if (index == 1 || index == 3) {
            //   animationController.reverse().then<dynamic>((data) {
            //     if (!mounted) {
            //       return;
            //     }
            //     setState(() {
            //       tabBody =
            //           TrainingScreen(animationController: animationController);
            //     });
            //   });
            // }
          },
        ),
      ],
    );
  }
}

