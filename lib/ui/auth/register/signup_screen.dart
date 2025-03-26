import 'package:ExpensifyX_App/data/local/db_helper.dart';
import 'package:ExpensifyX_App/ui/auth/register/bloc/register_bloc.dart';
import 'package:ExpensifyX_App/ui/auth/register/bloc/register_event.dart';
import 'package:ExpensifyX_App/ui/auth/register/bloc/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:country_picker/country_picker.dart';
import 'package:intl/intl.dart';
import '../../../data/model/user_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool isLoading = false;
  String countryCode = "+1";
  late TabController _tabController;
  String? _dobError;
  bool _isObscured = true;
  final _formKey = GlobalKey<FormState>();
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
    context.read<RegisterBloc>().add(ResetRegisterState());
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
    _dateFocusNode.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _dateController = MaskedTextController(mask: '00/00/0000');
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
                  child: Form(
                    key: _formKey,
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
                            "Email",
                            _emailController,
                            Icons.email,
                            false,
                            _emailFocusNode,
                            (value) => EmailChangedEvent(value: value),
                            (state) =>
                                state.errors[DbHelper.USER_COLUMN_EMAIL]),
                        SizedBox(height: 25),
                        _buildDatePicker("Birth of Date",
                            FontAwesomeIcons.calendar, _dateFocusNode),
                        SizedBox(height: 10),
                        _buildPhoneField(
                          "Phone Number",
                          _phoneFocusNode,
                        ),
                        SizedBox(height: 25),
                        _buildTextField(
                            "Set Password",
                            _passwordController,
                            Icons.lock,
                            true,
                            _passwordFocusNode,
                            (value) => PasswordChangedEvent(value: value),
                            (state) =>
                                state.errors[DbHelper.USER_COLUMN_PASSWORD]),
                        SizedBox(height: 25),
                        _buildTextField(
                            "Confirm Password",
                            _confirmPasswordController,
                            Icons.lock,
                            true,
                            _confirmPasswordFocusNode,
                            (value) =>
                                ConfirmPasswordChangedEvent(value: value),
                            (state) => state.errors["confirmPasswordError"]),
                        SizedBox(height: 35),
                        _buildSignUpButton(),
                      ],
                    ),
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
                "First Name",
                _firstNameController,
                Icons.person,
                false,
                _firstNameFocusNode,
                (value) => FirstNameChangedEvent(value: value),
                (state) => state.errors[DbHelper.USER_COLUMN_FIRST_NAME])),
        SizedBox(width: 10),
        Expanded(
            child: _buildTextField(
                "Last Name",
                _lastNameController,
                Icons.person,
                false,
                _lastNameFocusNode,
                (value) => LastNameChangedEvent(value: value),
                (state) => state.errors[DbHelper.USER_COLUMN_LAST_NAME])),
      ],
    );
  }

  Widget _buildTextField(
      String label,
      TextEditingController? controller,
      IconData icon,
      bool isPassword,
      FocusNode focusNode,
      Function(String) event,
      String? Function(RegisterValidationState state) errorTextSelector) {
    bool isFocused = focusNode.hasFocus;
    Color borderColor = isFocused ? const Color(0xff6674d3) : Colors.black54;
    Color iconColor = isFocused ? const Color(0xff6674d3) : Colors.black54;
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      String? errorText;
      if (state is RegisterValidationState) { 
        errorText = errorTextSelector(state);
      } else {
        errorText = null;
      }
      return TextField(
        controller: controller,
        focusNode: focusNode,
        obscureText: isPassword ? _isObscured : false,
        onChanged: (value) {
          context.read<RegisterBloc>().add(event(value));
        },
        decoration: InputDecoration(
          labelText: label,
          errorText: errorText,
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
    });
  }

  Widget _buildDatePicker(String label, IconData icon, FocusNode focusNode) {
    bool isFocused = focusNode.hasFocus;
    Color borderColor = isFocused ? const Color(0xff6674d3) : Colors.black54;
    Color iconColor = isFocused ? const Color(0xff6674d3) : Colors.black54;

    return SizedBox(
      height: 65,
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          String? errorText;
          if (state is RegisterValidationState) {
            errorText = state.errors[DbHelper.USER_COLUMN_BIRTH_DATE];
          } else {
            errorText = null;
          }

          return TextField(
            controller: _dateController,
            focusNode: focusNode,
            keyboardType:
                TextInputType.datetime, // User manually enter bhi kar sake
            decoration: InputDecoration(
              labelText: label,
              errorText: errorText,
              labelStyle: TextStyle(
                  color: iconColor, fontFamily: "Poppins", fontSize: 14),
              prefixIcon: Icon(icon, color: iconColor),
              suffixIcon: _dateController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear, color: Colors.red),
                      onPressed: () {
                        _dateController.clear();
                        _dobError = null;
                        context
                            .read<RegisterBloc>()
                            .add(DateofBirthChangedEvent(value: ""));
                      },
                    )
                  : null, // Agar field empty ho to button na dikhaye
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
                String formattedDate =
                    DateFormat("dd/MM/yyyy").format(pickedDate);
                _dateController.text = formattedDate;
                _dobError = null;
                print("Selected Date: $formattedDate");

                context
                    .read<RegisterBloc>()
                    .add(DateofBirthChangedEvent(value: _dateController.text));
              }
            },
            onChanged: (value) {
              if (value.length == 10) {
                // Validate only when full date is entered
                if (!_isValidDate(value)) {
                  _dobError =
                      "Invalid Date Format! Use dd/MM/yyyy."; // Show error
                } else {
                  _dobError = null; // Clear error if valid
                  context
                      .read<RegisterBloc>()
                      .add(DateofBirthChangedEvent(value: value));
                }
              }
            },
          );
        },
      ),
    );
  }

  bool _isValidDate(String input) {
    try {
      if (input.length != 10) return false; // Must be "dd/MM/yyyy"

      final date = DateFormat("dd/MM/yyyy").parseStrict(input);
      if (date.isAfter(DateTime.now())) {
        _dobError = "Future dates are not allowed!"; // Prevent future date
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Widget _buildPhoneField(String label, FocusNode focusNode) {
    bool isFocused = focusNode.hasFocus;
    Color borderColor = isFocused ? const Color(0xff6674d3) : Colors.black54;
    Color iconColor = isFocused ? const Color(0xff6674d3) : Colors.black54;

    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      String? errorText;
      if (state is RegisterValidationState) {
        errorText = state.errors[DbHelper.USER_COLUMN_PHONE];
      } else {
        errorText = null;
      }
      return TextField(
        controller: _phoneController,
        focusNode: focusNode,
        keyboardType: TextInputType.phone,
        onChanged: (value) {
          context.read<RegisterBloc>().add(PhoneChangedEvent(value: value));
        },
        decoration: InputDecoration(
          labelText: label,
          errorText: errorText,
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
    });
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
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterFailureState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorMsg)));
            }
            if (state is RegisterSuccessState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Registered Successfully!!")),
              );
            }
          },
          child: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              bool isLoading = state
                  is RegisterLoadingState; // ✅ BlocBuilder se handle kar rahe

              return ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                        final user = UserModel(
                          firstName: _firstNameController.text.trim(),
                          lastName: _lastNameController.text.trim(),
                          email: _emailController.text.trim(),
                          birthDate: _dateController.text.trim(),
                          phone: _phoneController.text.trim(),
                          password: _passwordController.text.trim(),
                        );
                        context
                            .read<RegisterBloc>()
                            .add(RegisterUserEvent(newUser: user));
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff6674d3),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                child: isLoading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Registering...",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins",
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          color: Colors.white,
                        ),
                      ),
              );
            },
          ),
        ),
    );
  }
}
