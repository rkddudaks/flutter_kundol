import 'package:flutter/material.dart';
// import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/tweaks/app_localization.dart';
import 'package:flutter_svg/svg.dart';

class MyBottomNavigation extends StatelessWidget {
  final Function(int position) selectCurrentItem;
  final int selectedIndex;

  const MyBottomNavigation(this.selectCurrentItem, this.selectedIndex);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey,
              blurRadius: 4.0,
              offset: Offset(5.0, 5.0),
              spreadRadius: 2.0)
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppStyles.CARD_RADIUS),
          topRight: Radius.circular(AppStyles.CARD_RADIUS),
        ),
        child: BottomNavigationBar(
          selectedItemColor: Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).primaryColorLight
              : Theme.of(context).primaryColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          onTap: (value) {
            selectCurrentItem(value);
          },
          unselectedItemColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[700]
              : Colors.grey[700],
          items: [
            BottomNavigationBarItem(
              label: AppLocalizations.of(context)!.translate('home'),
              icon: SvgPicture.asset(
                "assets/icons/ic_home_new.svg",
                color: Colors.grey[700],
              ),
              activeIcon: SvgPicture.asset(
                  "assets/icons/ic_home_filled_new.svg",
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).primaryColorLight
                      : Theme.of(context).primaryColor),
            ),
            BottomNavigationBarItem(
              label: AppLocalizations.of(context)!.translate('categories'),
              icon: SvgPicture.asset(
                "assets/icons/ic_category_new.svg",
                color: Colors.grey[700],
              ),
              activeIcon: SvgPicture.asset(
                  "assets/icons/ic_category_filled_new.svg",
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).primaryColorLight
                      : Theme.of(context).primaryColor),
            ),
            BottomNavigationBarItem(
              label: AppLocalizations.of(context)!.translate('wishlist'),
              icon: SvgPicture.asset(
                "assets/icons/ic_basket_new.svg",
                color: Colors.grey[700],
              ),
              activeIcon: SvgPicture.asset(
                  "assets/icons/ic_basket_filed_new.svg",
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).primaryColorLight
                      : Theme.of(context).primaryColor),
            ),
            BottomNavigationBarItem(
              label: AppLocalizations.of(context)!.translate('news'),
              icon: Icon(
                Icons.article_outlined,
                color: Colors.grey[700],
              ),
              activeIcon: Icon(Icons.article_outlined,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).primaryColorLight
                      : Theme.of(context).primaryColor),
            ),
            BottomNavigationBarItem(
              label: AppLocalizations.of(context)!.translate('me'),
              icon: SvgPicture.asset(
                "assets/icons/ic_profile_new.svg",
                color: Colors.grey[700],
              ),
              activeIcon: SvgPicture.asset(
                  "assets/icons/ic_profile_filed_new.svg",
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).primaryColorLight
                      : Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
