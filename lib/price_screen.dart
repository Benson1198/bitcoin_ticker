import 'dart:ffi';
import 'package:flutter/material.dart';
import 'coin_dart.dart';
import 'networking.dart';
import 'dart:core';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String cryptType = 'BTC';
  List cryptoList = ['BTC', 'ETH', 'LTC'];
  List rateList;

  @override
  void initState() {
    super.initState();
    getAllRates(selectedCurrency);
  }

  List<DropdownMenuItem> getDropdownItems() {
    List<DropdownMenuItem<String>> dropdownitems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownitems.add(newItem);
    }
    return dropdownitems;
  }

  Future<dynamic> getAllRates(String countryCode) async {
    List<String> rList = [];
    BitcoinData bitcoinData = BitcoinData();

    for (String crypt in cryptoList) {
      double newRate = await bitcoinData.getRate(crypt, countryCode);
      String newRateRound = newRate.toStringAsFixed(2);
      rList.add(newRateRound);
    }
    rateList = rList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              children: <Widget>[
                RateCard(
                    crpytL: cryptoList[0],
                    selectedCurr: selectedCurrency,
                    rate: rateList[0]),
                RateCard(
                    crpytL: cryptoList[1],
                    selectedCurr: selectedCurrency,
                    rate: rateList[1]),
                RateCard(
                    crpytL: cryptoList[2],
                    selectedCurr: selectedCurrency,
                    rate: rateList[2])
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
                value: selectedCurrency,
                items: getDropdownItems(),
                onChanged: (value) {
                  setState(() {
                    selectedCurrency = value;
                  });
                }),
          ),
        ],
      ),
    );
  }
}

class RateCard extends StatelessWidget {
  const RateCard({
    @required this.crpytL,
    @required this.selectedCurr,
    @required this.rate,
  });

  final String crpytL;
  final String selectedCurr;
  final String rate;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 ${crpytL} = $rate $selectedCurr',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
