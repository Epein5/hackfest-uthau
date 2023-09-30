import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/provider/NightMode.dart';
import 'package:provider/provider.dart';

class CostumTextField extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final TextEditingController? controller;

  const CostumTextField({
    super.key,
    required this.icon,
    required this.text,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> _isvisible = ValueNotifier<bool>(false);

    // final visibilityProvider =
    //     Provider.of<PassVisibilityProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ValueListenableBuilder(
        valueListenable: _isvisible,
        builder: (context, value, child) {
          return TextFormField(
            obscureText: !_isvisible.value,
            controller: controller,
            decoration: InputDecoration(
                suffixIcon: InkWell(
                  onTap: () {
                    _isvisible.value = !_isvisible.value;
                  },
                  child: _isvisible.value == false
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
                prefixIcon: Icon(icon),
                hintText: text,
                // filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
          );
        },
      ),
    );
  }
}

class TestFieldNoProvider extends StatelessWidget {
  final String? text;
  final IconData? icon;

  final TextEditingController? controller;
  const TestFieldNoProvider({
    super.key,
    required this.icon,
    required this.text,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            hintText: text,
            filled: true,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
      ),
    );
  }
}

class RoundButton extends StatelessWidget {
  final String? text;
  final VoidCallback? ontap;

  const RoundButton({super.key, required this.text, required this.ontap});

  @override
  Widget build(BuildContext context) {
    final providder = Provider.of<LoadingProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: ontap,
        child: Consumer<LoadingProvider>(
          builder: (context, value, child) {
            return Container(
              height: 60,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(225, 0, 187, 134),
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: providder.isloading == true
                    ? Container(
                        child: const CircularProgressIndicator(
                        color: Colors.white,
                      ))
                    : Text(
                        text!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SmallBox extends StatelessWidget {
  const SmallBox(
      {super.key,
      this.text,
      this.icon,
      required this.height,
      required this.width,
      this.ontap});
  final String? text;
  final IconData? icon;
  final double? height;
  final double? width;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          color: Color.fromARGB(225, 0, 187, 134),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 18,
                ),
                Icon(
                  icon,
                  size: 35,
                  color: Colors.white,
                ),
                Text(
                  text!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    // fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BusInfoBoxes extends StatelessWidget {
  // String
  const BusInfoBoxes({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
            // margin: const EdgeInsets.all(10),
            height: 30,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 129, 232, 203).withOpacity(0.2),
              border: Border.all(color: Colors.black.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Text('Bus no: ', style: TextStyle(fontSize: 20)),
                const Text('2023',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ],
            )
            // const SizedBox(
            //   height: 10,
            // )),
            ));
  }
}
