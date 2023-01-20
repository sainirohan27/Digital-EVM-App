import 'package:flutter/material.dart';
import 'package:flutter_firebase_vote/utilities.dart';

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  String _name;
  String _fname;
  String _voterid;
  String _dob;
  String _aadhar;
  var details = {
    'ABC1234567': 'ABCD EFGH',
    'XYZ7654321': 'Zyan Malik',
    'a': 'a',
    'ZMR3480680': 'ROHAN SAINI',
    'ZMR3465656': 'SHAGUN',
  };

  var details2 = {  //sample data
    'ABC1234567': '123456789012',
    'XYZ7654321': '111111111111',
    'a': 'a',
    'ZMR3580681': '305084224162',
    'ZMR3565657': '333333444444',
  };

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Authentication Failed!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Your entered details are not correct!'),
                Text('Enter correct Details again'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name of Card Holder'),
      maxLength: 20,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildFName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Fathers Name'),
      maxLength: 20,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Fathers name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _fname = value;
      },
    );
  }

  Widget _buildvoterid() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Voter ID'),
      keyboardType: TextInputType.visiblePassword,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Voter ID is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _voterid = value;
      },
    );
  }

  Widget _buildaadhar() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Aadhar No.'),
      keyboardType: TextInputType.visiblePassword,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Aadhar no. is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _aadhar = value;
      },
    );
  }

  Widget _buildob() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Date of Birth (DD/MM/YYYY)'),
      keyboardType: TextInputType.url,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Date of Birth is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _dob = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Voter ID Details for Authentication")),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildName(),
                _buildFName(),
                _buildvoterid(),
                _buildaadhar(),
                _buildob(),
                SizedBox(height: 100),
                RaisedButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }

                    _formKey.currentState.save();

                    print(_name);
                    print(_fname);
                    print(_dob);
                    print(_voterid);
                    print(_aadhar);

                    if (details[_voterid] == _name &&
                        details2[_voterid] == _aadhar) {
                      //route next page
                      print('go to next page');
                      Navigator.pushReplacementNamed(context, '/fingerprint');
                    } else {
                      print('False Details');
                      _showMyDialog();
                    }

                    //Send to API
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
