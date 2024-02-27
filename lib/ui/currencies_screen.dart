import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/blocs/auth/auth_bloc.dart';
import 'package:flutter_kundol/blocs/currency/currency_bloc.dart';
import 'package:flutter_kundol/blocs/get_currencies/get_currency_bloc.dart';
import 'package:flutter_kundol/blocs/get_languages/get_language_bloc.dart';
import 'package:flutter_kundol/main.dart';
// import 'package:flutter_kundol/blocs/language/language_bloc.dart';
// import 'package:flutter_kundol/blocs/page/page_bloc.dart';
// import 'package:flutter_kundol/blocs/theme/theme_bloc.dart';
// import 'package:flutter_kundol/constants/app_data.dart';
// import 'package:flutter_kundol/repos/pages_repo.dart';
// import 'package:flutter_kundol/tweaks/shared_pref_service.dart';
// import 'package:flutter_kundol/ui/content_screen.dart';
// import 'package:in_app_review/in_app_review.dart';
// import 'package:share/share.dart';

class CurrenciesScreen extends StatefulWidget {
  @override
  _CurrenciesScreenState createState() => _CurrenciesScreenState();
}

class _CurrenciesScreenState extends State<CurrenciesScreen> {
  GetCurrenciesBloc? currencyBloc;

  @override
  void initState() {
    super.initState();
    currencyBloc = BlocProvider.of<GetCurrenciesBloc>(context);
    currencyBloc!.add(GetCurrencies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Currencies",
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).cardColor,
        elevation: 0.0,
      ),
      body: BlocBuilder(
        bloc: currencyBloc,
        builder: (BuildContext context, dynamic state1) {
          if (state1 is GetCurrencyLoaded)
            return BlocBuilder<CurrencyBloc, CurrencyState>(
              // builder: (context, state) => ListView.builder(
              //   physics: NeverScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   itemBuilder: (context, index) {
              //     return ListTile(
              //       onTap: () {
              //         BlocProvider.of<CurrencyBloc>(context).add(
              //             CurrencySelected(state1
              //                 .currenciesResponse.data[index]));
              //         RestartWidget.restartApp(context);
              //       },
              //       title:
              //       Text(state1.currenciesResponse.data[index].title),
              //       subtitle: Text(state1.currenciesResponse.data[index].code),
              //       trailing: Icon((state1.currenciesResponse.data[index].currencyId == state.currency.currencyId)
              //           ? Icons.radio_button_on
              //           : Icons.radio_button_off),
              //     );
              //   },
              //   itemCount: state1.currenciesResponse.data.length,
              // ),
              builder: (context, state) => Container(
                margin: EdgeInsets.all(15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    width: double.maxFinite,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Theme.of(context).cardColor
                        : Colors.white,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            BlocProvider.of<CurrencyBloc>(context).add(
                                CurrencySelected(
                                    state1.currenciesResponse.data![index]));
                            RestartWidget.restartApp(context);
                          },
                          child:
                              state1.currenciesResponse.data![index].symbol ==
                                      state.currency.symbol
                                  ? Container(
                                      padding: EdgeInsets.all(10),
                                      color: Theme.of(context).primaryColor,
                                      child: Text(
                                        state1.currenciesResponse.data![index]
                                            .name!,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  : Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(state1.currenciesResponse
                                          .data![index].name!),
                                    ),
                        );
                      },
                      itemCount: state1.currenciesResponse.data!.length,
                    ),
                  ),
                ),
              ),
            );
          else if (state1 is GetLanguageError)
            return Text(state1.error);
          else
            return Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
    );
  }
}
