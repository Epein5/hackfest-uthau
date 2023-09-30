import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SetupTextField extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final TextEditingController? controller;
  final String? suffixtext;
  const SetupTextField(
      {super.key,
      required this.controller,
      required this.icon,
      required this.text,
      this.suffixtext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            suffix: suffixtext != null
                ? Text(suffixtext.toString())
                : const Text(''),
            prefixIcon: Icon(icon),
            hintText: text),
      ),
    );
  }
}

class AboutYouTextField extends StatelessWidget {
  final String? text;
  final TextEditingController? controller;
  const AboutYouTextField({
    super.key,
    required this.controller,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        maxLines: 5,
        controller: controller,
        decoration:
            InputDecoration(border: const OutlineInputBorder(), hintText: text),
      ),
    );
  }
}

class RoundBtn extends StatelessWidget {
  final String? text;
  final double? height;
  final double? width;
  final VoidCallback? ontap;
  const RoundBtn(
      {super.key,
      required this.height,
      required this.width,
      required this.ontap,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(225, 0, 187, 134),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text!,
                style: GoogleFonts.satisfy(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const Icon(
                Icons.arrow_right_alt_outlined,
                color: Colors.white,
              )
            ],
          )),
    );
  }
}

class EditProfileTextField extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final TextEditingController? controller;
  final String? suffixtext;
  const EditProfileTextField(
      {super.key,
      required this.controller,
      required this.icon,
      required this.text,
      this.suffixtext});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${text!}    '),
          SizedBox(
            width: width * 0.6,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                  suffix: suffixtext != null
                      ? Text(suffixtext.toString())
                      : const Text(''),
                  // prefixIcon: Icon(icon),
                  hintText: text),
            ),
          ),
        ],
      ),
    );
  }
}
