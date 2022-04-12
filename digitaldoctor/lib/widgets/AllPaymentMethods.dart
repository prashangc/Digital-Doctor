import '../model/PaymentMethods.dart';
import 'package:flutter/material.dart';

class AllPaymentMethods extends StatefulWidget {
  final PaymentMethods paymentMethods;

  final onTap;
  final isSelected;
  const AllPaymentMethods(this.paymentMethods, this.onTap, this.isSelected);

  @override
  State<AllPaymentMethods> createState() => _AllPaymentMethodstate();
}

class _AllPaymentMethodstate extends State<AllPaymentMethods> {
  final _color = Colors.green;
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 100,
        width: width / 2,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.isSelected ? _color : Colors.white,
            )
            // boxShadow: [boxShadowBlue],
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                image: DecorationImage(
                    image:
                        AssetImage(widget.paymentMethods.imageUrl.toString())),
              ),
            ),
            // Image.asset(
            //   widget.paymentMethods.imageUrl.toString(),
            //   height: 90,
            //   width: 120,
            // ),
            Icon(
              widget.isSelected ? Icons.check_circle : Icons.circle,
              color: widget.isSelected
                  ? Colors.green
                  : const Color.fromARGB(255, 211, 208, 208),
            ),
          ],
        ),
      ),
    );
  }
}
