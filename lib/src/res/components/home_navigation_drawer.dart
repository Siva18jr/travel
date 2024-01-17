import 'package:firebase_auth/firebase_auth.dart';
import 'package:levitate/src/repository/share_data.dart';
import 'package:levitate/src/res/colors/color.dart';
import 'package:levitate/src/res/data_urls/local_keys.dart';
import 'package:levitate/src/utils/routes/routes_name.dart';
import 'package:levitate/src/model/provider_state/package_info_model.dart';
import 'package:levitate/src/utils/utils.dart';
import 'package:levitate/src/view_model/auth_view_model.dart';
import 'package:levitate/src/view_model/local_data_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeNavigationDrawer extends StatefulWidget {
  const HomeNavigationDrawer({super.key});

  @override
  State<HomeNavigationDrawer> createState() => _HomeNavigationDrawerState();
}

class _HomeNavigationDrawerState extends State<HomeNavigationDrawer> {

  final ShareData _shareData = ShareData();
  final PackageInfoModel _packageInfoModel = PackageInfoModel();
  final LocalDataViewModel _localDataViewModel = LocalDataViewModel();
  final AuthViewModel _authViewModel = AuthViewModel();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {

    super.initState();
    _packageInfoModel.fetchPackageData();
    _localDataViewModel.fetchBoolDataList(LocalKeys.localLoginBoolKey);

  }

  @override
  Widget build(BuildContext context) {

    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Drawer(
      backgroundColor: AppColors.greyColor10,
      child: ChangeNotifierProvider<LocalDataViewModel>(
        create: (BuildContext context) => _localDataViewModel,
        child: Consumer<LocalDataViewModel>(
          builder: (context, value, _){

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 88,
                    ),
                    child: SizedBox(
                      height: 115,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            width: screenWidth,
                            height: 125,
                            decoration: const BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25)
                                )
                            ),
                          ),
                          Positioned(
                            top: -25,
                            child: CircleAvatar(
                              backgroundColor: AppColors.whiteColor,
                              minRadius: 40,
                              child: Center(
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: AppColors.appPrimaryColor,
                                      borderRadius: BorderRadius.circular(30)
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "L",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: AppColors.whiteColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 55,
                            child: Column(
                              children: [
                                const Text(
                                  "Levitate",
                                  style: TextStyle(
                                      color: AppColors.appTxtAccentColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12
                                  ),
                                ),
                                Text(
                                  bool.parse(value.loginBoolData.data.toString()) == false ?
                                  "Email" : _auth.currentUser!.email.toString(),
                                  style: const TextStyle(
                                      color: AppColors.appTxtAccentColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  _bodyTile(
                      heading: 'My Visits',
                      onPressed: () => Navigator.pushNamed(context, RoutesName.myOrdersActivity)
                  ),
                  _bodyTile(
                      heading: 'Share with friends',
                      onPressed: () => _shareData.shareData(
                          shareHeader: "choose one",
                          title: "Hey, this is . I am satisfied with Essor products. Now we can buy quality food items anytime. Pls click the below link to download their Mobile App \nhttps://play.google.com/store/apps/details?id=",
                          subject: "Superfoods"
                      )
                  ),
                  _bodyTile(
                      heading: 'Contact Us',
                      onPressed: () => Navigator.pushNamed(context, RoutesName.contactActivity)
                  ),
                  _bodyTile(
                      heading: 'About Us',
                      onPressed: () => Navigator.pushNamed(context, RoutesName.aboutActivity)
                  ),
                  _bodyTile(
                      heading: 'Privacy Policy',
                      onPressed: () => Navigator.pushNamed(context, RoutesName.privacyActivity)
                  ),
                  _bodyTile(
                      heading: 'Terms & Conditions',
                      onPressed: () => Navigator.pushNamed(context, RoutesName.termsActivity)
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: bool.parse(value.loginBoolData.data.toString()) == true ?
                    ListTile(
                      onTap: ()=> _authViewModel.logoutApi(context),
                      tileColor: AppColors.whiteColor10,
                      leading: const Icon(
                          Icons.exit_to_app,
                          color: AppColors.drawerTxtColor
                      ),
                      title: const Text(
                        "Log out",
                        style: TextStyle(
                            color: AppColors.drawerTxtColor
                        ),
                      ),
                    ) :
                    ListTile(
                      onTap: ()=> Navigator.pushNamed(context, RoutesName.loginActivity),
                      tileColor: AppColors.whiteColor10,
                      leading: const Icon(
                          Icons.exit_to_app,
                          color: AppColors.drawerTxtColor
                      ),
                      title: const Text(
                        "Login",
                        style: TextStyle(
                            color: AppColors.drawerTxtColor
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 10,
                        bottom: 66
                    ),
                    child: ChangeNotifierProvider(
                        create: (BuildContext context) => _packageInfoModel,
                        child: Consumer<PackageInfoModel>(
                            builder: (context, value, _){

                              return Text(
                                value.packageVersionInfo,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                    color: AppColors.blackColor
                                ),
                              );

                            }
                        )
                    ),
                  )
                ],
              ),
            );

          }
        ),
      ),
    );

  }

  Widget _bodyTile({required String heading, required Function onPressed}){

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        onTap: () => onPressed(),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)
        ),
        tileColor: AppColors.whiteColor,
        title: Text(
          heading,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor
          ),
        ),
      ),
    );

  }

}