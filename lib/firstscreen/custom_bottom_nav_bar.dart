import 'package:e_auction/firstscreen/home/components/WishList/WishList_page.dart';
import 'package:e_auction/firstscreen/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/constant.dart';
import 'home/home_screen.dart';

enum MenuState { home, favourite, message, profile }

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({
    Key key,
    this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Shop Icon.svg",
                  color: MenuState.home == widget.selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return HomeScreen();
                  }),
                ),
              ),
              IconButton(
                icon: SvgPicture.asset("assets/icons/Heart Icon.svg",color: Colors.red,),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return wishListPage();
                    }),
                  );
                },
              ),
              IconButton(
                icon: SvgPicture.asset("assets/icons/Chat bubble Icon.svg"),
                onPressed: () {

                },
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  color: MenuState.profile == widget.selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ProfileScreen();
                  }),
                ),
              ),
            ],
          )),
    );
  }
}
