import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swift_care/constants/colors.dart';

lent() => Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            height: 20,
            width: 65,
            child: OutlinedButton(
              onPressed: () {},
              child: Text(
                'Shared'.tr,
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(COLOR_russianVoilet)),
            ),
          ),
        ),
      ],
    );
