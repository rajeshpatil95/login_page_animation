import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  bool _autoValidate = false;
  double _size = 300.0;

  FocusNode _focusEmail, _focusPassword;

  final textEditController = TextEditingController();
  bool _emailIsValid(String email) => RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);

  _validateForm() {
    setState(() {
      _autoValidate = true;
    });
    if (_formKey.currentState.validate()) {
      print('form is valid');
    }
  }
  _compressIcon(){
    setState(() {
          _size= 100.0;
        });
  }
  _decompressIcon(){
    setState(() {
          _size = 300.0;
        });
  }
  // Decoration theme
  InputDecoration _fieldDecoration(
          {@required String label, @required IconData icon}) =>
      InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(
                style: BorderStyle.solid,
                color: Theme.of(context).primaryColor)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        filled: true,
        fillColor: Color.fromRGBO(255, 255, 255, 100.0),
        contentPadding: EdgeInsets.only(left: 20.0),
        suffixIcon: Icon(icon, color: Theme.of(context).primaryColor),
        labelText: label,
      );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _focusEmail = FocusNode()
      ..addListener(() {
        print('email field has focus');
        _focusEmail.hasFocus || _focusPassword.hasFocus ? _compressIcon() : _decompressIcon();
      });
    _focusPassword = FocusNode()
      ..addListener(() {
        print('password field has focus');
        _focusEmail.hasFocus || _focusPassword.hasFocus ? _compressIcon() : _decompressIcon();
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _focusEmail.dispose();
    _focusPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          
          AnimatedContainer(padding: EdgeInsets.only(top:12.0),
            width: _size,
            height: _size,
            curve: Curves.bounceOut,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: FittedBox(
                  fit: BoxFit.contain,
                  child: Icon(
                    Icons.account_circle,
                    color: Theme.of(context).primaryColor,
                  )),
            ),
            duration: Duration(milliseconds:  1200),
          ),



          Text(
            'LOGIN',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).textTheme.button.color,
                fontSize: 20.0,
                fontWeight: FontWeight.w300),
          ),

          
          Container(
            padding: EdgeInsets.all(18.0),
            width: 120.0,
            child: Form(
                autovalidate: _autoValidate,
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // all from top
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // email field
                    TextFormField(
                      focusNode: _focusEmail,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Theme.of(context).primaryColor),
                      maxLines: 1,
                      autocorrect: false,
                      enabled: true,
                      decoration:
                          _fieldDecoration(icon: Icons.email, label: 'email'),
                      validator: (value) {
                        value = value.trim();
                        if (!_emailIsValid(value)) {
                          return 'email not valid';
                        }
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                      },
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    // password field
                    TextFormField(
                      focusNode: _focusPassword,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Theme.of(context).primaryColor),
                      maxLines: 1,
                      autocorrect: false,
                      enabled: true,
                      decoration: _fieldDecoration(
                          icon: Icons.security, label: 'password'),
                      validator: (value) {
                        value = value.trim();
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        if (value.length < 6) {
                          return 'password is less than 6 chars';
                        }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                    ),
                    // button for test
                    RaisedButton(
                        elevation: 0.0,
                        padding: EdgeInsets.all(12.0),
                        color: Theme.of(context).primaryColorLight,
                        shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(15.0)),
                        splashColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'LOG IN',
                          style: TextStyle(
                              color: Theme.of(context).textTheme.body1.color,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400),
                        ),
                        onPressed: _validateForm),
                    FlatButton(
                      child: Text('I don\'t have an account yet'),
                      onPressed: () {},
                    ),
                    FlatButton(
                      child: Text('Lost my password'),
                      onPressed: () {},
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
