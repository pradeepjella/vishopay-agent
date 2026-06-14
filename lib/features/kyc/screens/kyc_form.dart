import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';

class KycForm extends StatefulWidget {
  const KycForm({super.key});

  @override
  State<KycForm> createState() => _KycFormState();
}

class _KycFormState extends State<KycForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController phoneController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController dobController =
      TextEditingController();

  final TextEditingController aadhaarController =
      TextEditingController();

  final TextEditingController panController =
      TextEditingController();

  String gender = "Male";

  bool emailVerified = false;
  bool isValidEmail = false;
  bool emailOtpVerified = false;
  bool isFresher = false;
  bool agreeTerms = false;
  File? aadhaarImage;
File? panImage;
File? profileImage;
String? resumeName;
PlatformFile? resumeFile;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    dobController.dispose();
    aadhaarController.dispose();
    panController.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      dobController.text =
          "${date.day}/${date.month}/${date.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth =
        MediaQuery.of(context).size.width;

    final isMobile = screenWidth < 700;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1000,
              ),

              child: Container(
                padding: const EdgeInsets.all(25),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(25),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(.05),
                      blurRadius: 20,
                    ),
                  ],
                ),

                child: Form(
                  key: _formKey,

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      /// LOGO
                      Center(
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/logo2.png",
                              height: 120,
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            const Text(
                              "KYC Form",
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                              height: 5,
                            ),

                            const Text(
                              "Please fill your details accurately for verification",
                              textAlign:
                                  TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 35,
                      ),

                      /// FULL NAME
                      const Text(
                        "Full Name",
                        style: TextStyle(
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      TextFormField(
                        controller:
                            nameController,

                        textCapitalization:
                            TextCapitalization
                                .words,

                        decoration:
                            InputDecoration(
                          hintText:
                              "Enter Full Name",

                          prefixIcon:
                              const Icon(
                            Icons.person_outline,
                          ),

                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(
                              12,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      /// PHONE + EMAIL
                      isMobile
                          ? Column(
                              children: [
                                buildPhoneField(),
                                const SizedBox(
                                  height: 15,
                                ),
                                buildEmailField(),
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child:
                                      buildPhoneField(),
                                ),

                                const SizedBox(
                                  width: 15,
                                ),

                                Expanded(
                                  child:
                                      buildEmailField(),
                                ),
                              ],
                            ),

                      const SizedBox(
                        height: 20,
                      ),

                      /// DOB + GENDER
                      isMobile
                          ? Column(
                              children: [
                                buildDobField(),
                                const SizedBox(
                                  height: 15,
                                ),
                                buildGenderField(),
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child:
                                      buildDobField(),
                                ),

                                const SizedBox(
                                  width: 15,
                                ),

                                Expanded(
                                  child:
                                      buildGenderField(),
                                ),
                              ],
                            ),

                      const SizedBox(
                        height: 20,
                      ),

                      /// AADHAAR + PAN
                      isMobile
                          ? Column(
                              children: [
                                buildAadhaarField(),
                                const SizedBox(
                                  height: 15,
                                ),
                                buildPanField(),
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child:
                                      buildAadhaarField(),
                                ),

                                const SizedBox(
                                  width: 15,
                                ),

                                Expanded(
                                  child:
                                      buildPanField(),
                                ),
                              ],
                            ),

                      const SizedBox(
                        height: 25,
                      ),

                      /// FRESHER
CheckboxListTile(
  value: isFresher,

  onChanged: (value) {
    setState(() {
      isFresher = value!;
    });
  },
  title: const Text(
    "Fresher",
    style: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ),
),

const SizedBox(height: 15),
if (!isFresher)

Container(
  width: double.infinity,
  padding: const EdgeInsets.all(12),

  decoration: BoxDecoration(
    color: const Color(0xFFFFF8E8),
    borderRadius: BorderRadius.circular(12),
    border: Border.all(
      color: const Color(0xFFE6A100),
    ),
  ),

  child: const Text(
    "Please provide your work experience details.",
  ),
),

const SizedBox(height: 20),
if (!isFresher)
Row(
  children: [

    Expanded(
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: "Experience",

          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(12),
          ),
        ),

        items: const [
          DropdownMenuItem(
            value: "1 Year",
            child: Text("1 Year"),
          ),

          DropdownMenuItem(
            value: "2 Years",
            child: Text("2 Years"),
          ),

          DropdownMenuItem(
            value: "3+ Years",
            child: Text("3+ Years"),
          ),
        ],

        onChanged: (value) {},
      ),
    ),

    const SizedBox(width: 15),

    Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          labelText:
              "Previous Organization",

          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(12),
          ),
        ),
      ),

    ),
  ],
),
const SizedBox(height: 25),

const Text(
  "Document Uploads",
  style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 15),
Container(
  padding: const EdgeInsets.all(15),

  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius:
        BorderRadius.circular(15),

    border: Border.all(
      color: Colors.grey.shade300,
    ),
  ),

  child: Row(
    children: [

      const Icon(
        Icons.badge,
        size: 35,
        color: Color(0xFFE6A100),
      ),

      const SizedBox(width: 15),

      const Expanded(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            Text(
              "Upload Aadhaar Card",
              style: TextStyle(
                fontWeight:
                    FontWeight.bold,
              ),
            ),


            Text(
              "JPG, PNG",
            ),
          ],
        ),
      ),

      ElevatedButton(
      onPressed: () async {
  final image = await pickImage();

  if (image != null) {
    setState(() {
      aadhaarImage = image;
    });
  }
},

        child: const Text(
          "Upload",
        ),
      ),
    ],
  ),
),
if (aadhaarImage != null)
  const Padding(
    padding: EdgeInsets.only(
      top: 10,
      bottom: 20,
    ),
    child: Text(
      "✓ Aadhaar Uploaded Successfully",
      style: TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
Container(
  padding: const EdgeInsets.all(15),

  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius:
        BorderRadius.circular(15),

    border: Border.all(
      color: Colors.grey.shade300,
    ),
  ),

  child: Row(
    children: [

      const Icon(
        Icons.badge,
        size: 35,
        color: Color(0xFFE6A100),
      ),

      const SizedBox(width: 15),

      const Expanded(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            Text(
              "Upload Pan Card",
              style: TextStyle(
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            Text(
              "JPG, PNG",
            ),
          ],
        ),
      ),

      ElevatedButton(
        onPressed: () async {
  final image = await pickImage();

  if (image != null) {
    setState(() {
      panImage = image;
    });
  }
},

        child: const Text(
          "Upload",
        ),
      ),
    ],
  ),
),
if (panImage != null)
  const Padding(
    padding: EdgeInsets.only(
      top: 10,
      bottom: 20,
    ),
    child: Text(
      "✓ PAN Uploaded Successfully",
      style: TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
Container(
  padding: const EdgeInsets.all(15),

  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius:
        BorderRadius.circular(15),

    border: Border.all(
      color: Colors.grey.shade300,
    ),
  ),

  child: Row(
    children: [

      const Icon(
        Icons.badge,
        size: 35,
        color: Color(0xFFE6A100),
      ),

      const SizedBox(width: 15),

      const Expanded(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            Text(
              "Upload Profile Photo",
              style: TextStyle(
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            Text(
              "JPG, PNG",
            ),
          ],
        ),
      ),

      ElevatedButton(
        onPressed: () async {
  final image = await pickImage();

  if (image != null) {
    setState(() {
      profileImage = image;
    });
  }
},

        child: const Text(
          "Upload",
        ),
      ),
    ],
  ),
),
if (profileImage != null)
  Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 15,
    ),
    child: Center(
      child: CircleAvatar(
        radius: 55,
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 40,
        ),
      ),
    ),
  ),
Container(
  padding: const EdgeInsets.all(15),

  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius:
        BorderRadius.circular(15),

    border: Border.all(
      color: Colors.grey.shade300,
    ),
  ),

  child: Row(
    children: [

      const Icon(
        Icons.badge,
        size: 35,
        color: Color(0xFFE6A100),
      ),

      const SizedBox(width: 15),

      const Expanded(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            Text(
              "Upload Resume",
              style: TextStyle(
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            Text(
              "JPG, PNG",
            ),
          ],
        ),
      ),

      ElevatedButton(
        onPressed: () async {

  FilePickerResult? result =
      await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );

  if (result != null) {
    setState(() {
      resumeFile = result.files.first;
      resumeName = result.files.first.name;
    });
  }
},

        child: const Text(
          "Upload",
        ),
      ),
    ],
  ),
),

if (resumeName != null)
  Padding(
    padding: const EdgeInsets.only(
      top: 10,
      bottom: 20,
    ),
    child: Text(
      "Selected: $resumeName",
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),
    ),
  ),

const SizedBox(height: 25),

CheckboxListTile(
  value: agreeTerms,

  onChanged: (value) {
    setState(() {
      agreeTerms = value!;
    });
  },

  title: const Text(
    "I agree to Terms & Conditions",
  ),
),

const SizedBox(height: 20),

SizedBox(
  width: double.infinity,
  height: 60,

  child: ElevatedButton(
    onPressed: submitKyc,

    style: ElevatedButton.styleFrom(
      backgroundColor:
          const Color(0xFFE6A100),
    ),

    child: const Text(
      "Submit KYC",

      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
                    
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget buildPhoneField() {
  return TextFormField(
    controller: phoneController,
    keyboardType: TextInputType.phone,
    maxLength: 10,
    decoration: InputDecoration(
      counterText: "",
      labelText: "Phone Number",
      prefixIcon: const Icon(Icons.phone),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
Widget buildEmailField() {
  return TextFormField(
    controller: emailController,

    keyboardType: TextInputType.emailAddress,

    onChanged: (value) {
      setState(() {
        isValidEmail =
            value.contains("@") &&
            value.contains(".");
      });
    },

    decoration: InputDecoration(
      labelText: "E-Mail",

      prefixIcon: const Icon(Icons.email),

      suffixIcon: isValidEmail
          ? TextButton(
              onPressed: () {
  showEmailOtpDialog();
},
              child: Text(
                emailVerified
                    ? "Verified"
                    : "Verify",
              ),
            )
          : null,

      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
      ),
    ),
  );
}
  Widget buildDobField() {
    return TextFormField(
      controller: dobController,
      readOnly: true,
      onTap: pickDate,

      decoration: InputDecoration(
        labelText: "Date Of Birth",

        prefixIcon: const Icon(
          Icons.calendar_month,
        ),

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget buildGenderField() {
    return DropdownButtonFormField(
      value: gender,

      decoration: InputDecoration(
        labelText: "Gender",

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),
        ),
      ),

      items: const [
        DropdownMenuItem(
          value: "Male",
          child: Text("Male"),
        ),
        DropdownMenuItem(
          value: "Female",
          child: Text("Female"),
        ),
        DropdownMenuItem(
          value: "Other",
          child: Text("Other"),
        ),
      ],

      onChanged: (value) {
        setState(() {
          gender = value.toString();
        });
      },
    );
  }

  Widget buildAadhaarField() {
  return TextFormField(
    controller: aadhaarController,

    keyboardType: TextInputType.number,

    maxLength: 12,

    inputFormatters: [
      FilteringTextInputFormatter
          .digitsOnly,
    ],

    validator: (value) {
      if (value == null ||
          value.length != 12) {
        return "Enter Valid Aadhaar Number";
      }
      return null;
    },

    decoration: InputDecoration(
      counterText: "",

      labelText:
          "Aadhaar Card Number",

      hintText:
          "Enter Aadharr Number",

      prefixIcon: const Icon(
        Icons.badge,
      ),

      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
      ),
    ),
  );
}

      

  Widget buildPanField() {
  return TextFormField(
    controller: panController,

    maxLength: 10,

    textCapitalization:
        TextCapitalization.characters,

    

    validator: (value) {
      if (value == null ||
          !RegExp(
            r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$',
          ).hasMatch(value)) {
        return "Enter Valid PAN Number";
      }

      return null;
    },

    decoration: InputDecoration(
      counterText: "",

      labelText: "PAN Card Number",

      hintText: "",

      prefixIcon: const Icon(
        Icons.credit_card,
      ),

      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
      ),
    ),
  );
}
Future<File?> pickImage() async {
  final pickedFile =
      await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );

  if (pickedFile == null) {
    return null;
  }

  return File(pickedFile.path);
}
void submitKyc() {

  if (nameController.text.trim().isEmpty) {
    showError("Enter Full Name");
    return;
  }

  if (phoneController.text.length != 10) {
    showError("Enter Valid Phone Number");
    return;
  }

  if (!emailVerified) {
    showError("Verify Email First");
    return;
  }

  if (aadhaarController.text.length != 12) {
    showError("Enter Valid Aadhaar Number");
    return;
  }

  if (panController.text.length != 10) {
    showError("Enter Valid PAN Number");
    return;
  }

  if (aadhaarImage == null) {
    showError("Upload Aadhaar Card");
    return;
  }

  if (panImage == null) {
    showError("Upload PAN Card");
    return;
  }

  if (profileImage == null) {
    showError("Upload Profile Photo");
    return;
  }

  if (!agreeTerms) {
    showError("Accept Terms & Conditions");
    return;
  }

  Navigator.pushReplacementNamed(
  context,
  '/waiting',
);
}
void showError(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ),
  );
}
  void showEmailOtpDialog() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          "Email Verification",
        ),

        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Enter 6 Digit OTP",
            ),

            const SizedBox(height: 20),

            TextField(
              keyboardType:
                  TextInputType.number,

              maxLength: 6,

              decoration:
                  const InputDecoration(
                hintText: "Enter OTP",
                border:
                    OutlineInputBorder(),
              ),
            ),
          ],
        ),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),

          ElevatedButton(
            onPressed: () {
              setState(() {
                emailVerified = true;
              });

              Navigator.pop(context);
            },
            child: const Text(
              "Verify",
            ),
          ),
        ],
      );
    },
  );
}
}