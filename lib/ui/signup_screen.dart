import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:country_picker/country_picker.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String countryCode = "+1";
  late TabController _tabController;
  bool _isObscured = true;
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _dateFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    countryCode = "+91";
    _firstNameFocusNode.addListener(() {
      setState(() {});
    });
    _lastNameFocusNode.addListener(() {
      setState(() {});
    });
    _emailFocusNode.addListener(() {
      setState(() {});
    });
    _phoneFocusNode.addListener(() {
      setState(() {});
    });
    _passwordFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 60),
                      Text(
                        "Get Started Now",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Create an account or log in to explore\nabout our app",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontFamily: "Poppins"),
                      ),
                      SizedBox(height: 15),
                      _buildToggleButtons(),
                      SizedBox(height: 30),
                      _buildNameFields(),
                      SizedBox(height: 25),
                      _buildTextField(
                          "Email", Icons.email, false, _emailFocusNode),
                      SizedBox(height: 25),
                      _buildDatePicker("Birth of Date",
                          FontAwesomeIcons.calendar, _dateFocusNode),
                      SizedBox(height: 25),
                      _buildPhoneField("Phone Number", _phoneFocusNode),
                      SizedBox(height: 25),
                      _buildTextField(
                          "Set Password", Icons.lock, true, _passwordFocusNode),
                      SizedBox(height: 25),
                      _buildTextField("Confirm Password", Icons.lock, true,
                          _confirmPasswordFocusNode),
                      SizedBox(height: 35),
                      _buildSignUpButton(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildToggleButtons() {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: Color(0xff6674d3),
          borderRadius: BorderRadius.circular(25),
        ),
        labelColor: Colors.white,
        labelStyle: TextStyle(
            fontFamily: "Poppins", fontSize: 12.3, fontWeight: FontWeight.w500),
        unselectedLabelColor: Colors.black,
        tabs: [
          Tab(text: "Sign Up"),
          Tab(text: "Log In"),
        ],
        onTap: (index) {
          if (index == 1) {
            _tabController.animateTo(1);
            Future.delayed(Duration(milliseconds: 300), () {
              Navigator.pop(context);
            });
          }
        },
      ),
    );
  }

  Widget _buildNameFields() {
    return Row(
      children: [
        Expanded(
            child: _buildTextField(
                "First Name", Icons.person, false, _firstNameFocusNode)),
        SizedBox(width: 10),
        Expanded(
            child: _buildTextField(
                "Last Name", Icons.person, false, _lastNameFocusNode)),
      ],
    );
  }

  Widget _buildTextField(
      String label, IconData icon, bool isPassword, FocusNode focusNode) {
    bool isFocused = focusNode.hasFocus;
    Color borderColor = isFocused ? const Color(0xff6674d3) : Colors.black54;
    Color iconColor = isFocused ? const Color(0xff6674d3) : Colors.black54;
    return TextField(
      focusNode: focusNode,
      obscureText: isPassword ? _isObscured : false,
      decoration: InputDecoration(
        labelText: label,
        labelStyle:
            TextStyle(color: iconColor, fontFamily: "Poppins", fontSize: 14),
        prefixIcon: Icon(
          icon,
          color: iconColor,
        ),
        suffixIcon: isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
                child: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                  color: iconColor,
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: borderColor, width: 2.0),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      ),
    );
  }

  Widget _buildDatePicker(String label, IconData icon, FocusNode focusNode) {
    bool isFocused = focusNode.hasFocus;
    Color borderColor = isFocused ? const Color(0xff6674d3) : Colors.black54;
    Color iconColor = isFocused ? const Color(0xff6674d3) : Colors.black54;
    return Container(
      height: 45,
      child: TextField(
        controller: _dateController,
        focusNode: focusNode,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          labelStyle:
              TextStyle(color: iconColor, fontFamily: "Poppins", fontSize: 14),
          prefixIcon: Icon(
            icon,
            color: iconColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Color(0xff6674d3), width: 2.0),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (pickedDate != null) {
            _dateController.text = DateFormat("dd/MM/yyyy").format(pickedDate);
          }
        },
      ),
    );
  }

  Widget _buildPhoneField(String label, FocusNode focusNode) {
    bool isFocused = focusNode.hasFocus;
    Color borderColor = isFocused ? const Color(0xff6674d3) : Colors.black54;
    Color iconColor = isFocused ? const Color(0xff6674d3) : Colors.black54;

    return TextField(
      controller: _phoneController,
      focusNode: focusNode,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: label,
        labelStyle:
            TextStyle(color: iconColor, fontFamily: "Poppins", fontSize: 14),
        prefixIcon: GestureDetector(
          onTap: _showCustomCountryPicker,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Text(countryCode,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold)),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Color(0xff6674d3), width: 2.0),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
    );
  }

  void _showCustomCountryPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        TextEditingController searchController = TextEditingController();
        List<Country> allCountries = CountryService().getAll();
        List<Country> filteredCountries = List.from(allCountries);

        return StatefulBuilder(
          builder: (context, setModalState) {
            void filterCountries(String query) {
              setModalState(() {
                filteredCountries = allCountries
                    .where((country) =>
                        country.name
                            .toLowerCase()
                            .contains(query.toLowerCase()) ||
                        country.phoneCode.contains(query))
                    .toList();
              });
            }

            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Center(
                    child: Container(
                      width: 80,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Select Your Country",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: 45,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: searchController,
                      onChanged: filterCountries,
                      decoration: InputDecoration(
                        hintText: "Search country...",
                        prefixIcon:
                            Icon(Icons.search, color: Color(0xff6674d3)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Color(0xff6674d3), width: 2.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredCountries.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final country = filteredCountries[index];
                        return ListTile(
                          dense: true,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          leading: Text(
                            country.flagEmoji,
                            style: TextStyle(fontSize: 25),
                          ),
                          title: Text(
                            country.name,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Poppins",
                                fontSize: 14),
                          ),
                          subtitle: Text(
                            "+${country.phoneCode}",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Poppins",
                                fontSize: 13),
                          ),
                          onTap: () {
                            setState(() {
                              countryCode = "+${country.phoneCode}";
                            });
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff6674d3),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: Text("Sign Up",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins",
                color: Colors.white)),
      ),
    );
  }
}
