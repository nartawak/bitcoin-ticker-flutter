import 'dart:io' show Platform;

import 'package:bitcoin_ticker/services/ticker_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList[0];

  String btcMessage = '';
  String ethMessage = '';
  String ltcMessage = '';

  TickerData td = TickerData();

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
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  btcMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  ethMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  ltcMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? _iOSPicker() : _androidDropdown(),
          ),
        ],
      ),
    );
  }

  void fetchData() {
    fetchDataBTC();
    fetchDataETH();
    fetchDataLTC();
  }

  void fetchDataBTC() async {
    setState(() {
      this.btcMessage = '1 BTC = ? $selectedCurrency';
    });

    double value = await this
        .td
        .getConvertValue(crytpo: 'BTC', currency: this.selectedCurrency);

    setState(() {
      this.btcMessage = '1 BTC = ${value.toString()} $selectedCurrency';
    });
  }

  void fetchDataETH() async {
    setState(() {
      this.ethMessage = '1 BTC = ? $selectedCurrency';
    });

    double value = await this
        .td
        .getConvertValue(crytpo: 'ETH', currency: this.selectedCurrency);

    setState(() {
      this.ethMessage = '1 ETH = ${value.toString()} $selectedCurrency';
    });
  }

  void fetchDataLTC() async {
    setState(() {
      this.ltcMessage = '1 BTC = ? $selectedCurrency';
    });

    double value = await this
        .td
        .getConvertValue(crytpo: 'LTC', currency: this.selectedCurrency);

    setState(() {
      this.ltcMessage = '1 LTC = ${value.toString()} $selectedCurrency';
    });
  }

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  DropdownButton _androidDropdown() {
    List<DropdownMenuItem<String>> items = currenciesList
        .toList(growable: false)
        .map((String item) => DropdownMenuItem<String>(
              child: Text(item),
              value: item,
            ))
        .toList(growable: false);

    return DropdownButton<String>(
        value: selectedCurrency,
        items: items,
        onChanged: (String value) {
          setState(() {
            this.selectedCurrency = value;
            this.fetchData();
          });
        });
  }

  CupertinoPicker _iOSPicker() {
    List<Text> childrens = currenciesList
        .toList(growable: false)
        .map(
          (String item) => Text(item),
        )
        .toList();

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (index) {
        setState(() {
          this.selectedCurrency = currenciesList[index];
          this.fetchData();
        });
      },
      children: childrens,
    );
  }
}
