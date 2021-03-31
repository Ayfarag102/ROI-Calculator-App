import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:roi_calculator_app/models_providers/theme_provider.dart';
import 'package:roi_calculator_app/widgets/main_drawer.dart';

class ROIForm extends StatefulWidget {
  @override
  _ROIFormState createState() => _ROIFormState();
}

class _ROIFormState extends State<ROIForm> {
  var _formKey = GlobalKey<FormState>();

  var amountInvested = 0.0;
  var amountInvestedHintTxt = 'Enter Amount Invested';
  var amountInvestedLblTxt = 'Amount Invested';
  var amountReturned = 0.0;
  var amountReturnedHintTxt = 'Enter Amount Returned';
  var amountReturnedLblTxt = 'Amount Returned';
  var displayResult = '';
  var investmentLengthHintTxt = 'Enter Investment Period (in Years)';
  var investmentLengthLblTxt = 'Investment Period (in Years)';

  TextEditingController _amountInvestedTextController = TextEditingController();
  TextEditingController _amountReturnedTextController = TextEditingController();
  var _currentSelectedInvestmentPeriod;
  var _investmentLength =
      new List<String>.generate(50, (counter) => '${counter + 1}');

  final _minPadding = 5.0;

  @override
  void initState() {
    super.initState();
    _currentSelectedInvestmentPeriod = _investmentLength[0];
  }

  void _onDropDownInvestmentItemSelected(String length) {
    return setState(() {
      this._currentSelectedInvestmentPeriod = length;
    });
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage("./assets/images/money.png");
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minPadding * 10),
    );
  }

  String _calculateROI() {
    /**
     * The basic formula for ROI is:

ROI = 	
Gain from Investment - Cost of Investment
Cost of Investment
As a most basic example, Bob wants to calculate the ROI on his sheep farming operation. From the beginning until present, he invested a total of $50,000 into the project, and his total profits to date sum up to $70,000.

$70,000 - $50,000
$50,000
 = 40%
Bob's ROI on his sheep farming operation is 40%. Conversely, the formula can be used to compute either gain from or cost of investment, given a desired ROI. If Bob wanted an ROI of 40% and knew his initial cost of investment was $50,000, $70,000 is the gain he must make from the initial investment to realize his desired ROI.

An investor has a portfolio with a beginning value of $2,000 and an ending value of $5,000 over a five-year time period. To calculate the total return rate (which is needed to calculate the annualized return), the investor will perform the following formula: (ending value - beginning value) / beginning value, or (5000 - 2000) / 2000 = 1.5. This gives the investor a total return rate of 1.5.

Next, the investor will perform the annualized return formula: (1 + Return) ^ (1 / N) - 1. Using the information given, this gives the investor the following formula to calculate: (1 + 1.5) ^ (1 / 5) - 1. The following are the calculations used to get the answer to this formula:

1 + 1.5 = 2.5

2.5 ^ (1 / 5 or .2) = 1.32

1.32 - 1 = .32 or 32%

Conclusion: The investor's portfolio has an annualized return of 32% over a period of five years in which the beginning value was $2,000 and the ending value is $5,000.
    */
    int invested = int.parse(_amountInvestedTextController.text);
    int returned = int.parse(_amountReturnedTextController.text);
    int investmentGain = returned - invested;
    int investmentPeriod = int.parse(_currentSelectedInvestmentPeriod);
    double expo = 1 / investmentPeriod;
    double roi;
    String annualRoi;
    double exponent;

    ///TODO: Calculate Value

    roi = ((returned - invested) / invested);

    double power = 1 + roi;

    exponent = pow(power, expo);
    // roi *= 100;
    debugPrint(exponent.toString());
    annualRoi = ((exponent - 1) * 100).toStringAsFixed(2);

    return '''
    Investment Gain: \$$investmentGain\n
    Your ROI: ${0 < roi ? roi * 100 : roi * 10}%\n
    Annualized ROI: $annualRoi%\n
    Investment Period: $investmentPeriod years''';
    // finalPrice = (((finalPurity / 24) * 100)) * 55.11;
    // return finalPrice.toString();
  }

  void _reset() {
    _amountInvestedTextController.text = "";
    _amountReturnedTextController.text = "";
    displayResult = "";
    _currentSelectedInvestmentPeriod = _investmentLength[0];
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Simple ROI Calculator App",
            style: Theme.of(context).textTheme.headline6),
      ),
      drawer: MainDrawer(width),
      body: Form(
        key: _formKey,
        // margin: EdgeInsets.all(20.0),
        child: Padding(
          padding: EdgeInsets.all(_minPadding * 2),
          child: ListView(
            children: <Widget>[
              /// Add Image here
              getImageAsset(),

              /// Add Row

              Padding(
                padding: EdgeInsets.only(
                  top: _minPadding,
                  bottom: _minPadding,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: _amountInvestedTextController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: amountInvestedLblTxt,
                          hintText: amountInvestedHintTxt,
                          labelStyle: TextStyle(
                            letterSpacing: 0.5,
                            color: themeProvider.isLightTheme
                                ? Color(0xFF1E1F28)
                                : Colors.white,
                          ),
                          errorStyle: TextStyle(
                            color: Colors.yellowAccent,
                            fontWeight: FontWeight.w700,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onChanged: (String inputAMI) {
                          setState(() {
                            debugPrint(
                                'User Inputted following $amountInvestedLblTxt: $inputAMI');
                            amountInvested = double.parse(inputAMI);
                          });
                        },
                        validator: (String val) {
                          if (val.isEmpty) {
                            return 'Please enter $amountInvestedLblTxt';
                          }

                          return null;
                        },
                      ),
                    ),
                    Container(width: _minPadding * 5),
                    Expanded(
                      child: TextFormField(
                        controller: _amountReturnedTextController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: amountReturnedLblTxt,
                          labelStyle: TextStyle(
                            letterSpacing: 0.5,
                            color: themeProvider.isLightTheme
                                ? Color(0xFF1E1F28)
                                : Colors.white,
                          ),
                          hintText: amountReturnedHintTxt,
                          errorStyle: TextStyle(
                            color: Colors.yellowAccent,
                            fontWeight: FontWeight.w700,
                          ),
                          hintMaxLines: 1,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onChanged: (String inputAMR) {
                          setState(() {
                            debugPrint(
                                'User Inputted following $amountReturnedLblTxt: $inputAMR');
                            amountInvested = double.parse(inputAMR);
                          });
                        },
                        validator: (String val) {
                          if (val.isEmpty) {
                            return 'Please enter $amountReturnedLblTxt';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),

              /// Add Row (W/ Investment Length DropDown & Gold Price TextFormField)
              Padding(
                padding: EdgeInsets.only(
                  top: _minPadding,
                  bottom: _minPadding,
                ),
                //   child:

                child: DropdownButtonFormField<String>(
                  hint: Text(investmentLengthHintTxt),
                  items: _investmentLength.map(
                    (String val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val, textAlign: TextAlign.justify),
                      );
                    },
                  ).toList(),
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: themeProvider.isLightTheme
                          ? Color(0xFF1E1F28)
                          : Colors.white),
                  onChanged: (String length) {
                    debugPrint(length);
                    _onDropDownInvestmentItemSelected(length);
                  },
                  value: _currentSelectedInvestmentPeriod,
                ),
              ),
              // ),

              /// Add Row (W/ Calculate ROI and Reset)

              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_formKey.currentState.validate()) {
                            this.displayResult = _calculateROI();
                          }
                        });
                      },
                      child: Text(
                        "Calculate ROI",
                        textAlign: TextAlign.center,
                        softWrap: true,
                        textScaleFactor: 1.5,
                      ),
                    ),
                  ),
                  Container(width: _minPadding),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _reset();
                        });
                      },
                      child: Text(
                        "Reset",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(_minPadding * 2),
                child: Container(
                  child: Center(
                      child: Text(
                    this.displayResult,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        //fontWeight: FontWeight.w300,
                        color: themeProvider.isLightTheme
                            ? Color(0xFF1E1F28)
                            : Colors.white),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
