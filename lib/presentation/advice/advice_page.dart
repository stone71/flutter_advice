import 'package:flutter/material.dart';
import 'package:flutter_advice/presentation/advice/widgets/advice_field.dart';
import 'package:flutter_advice/presentation/advice/widgets/custom_button.dart';
import 'package:flutter_advice/presentation/advice/widgets/error_message.dart';

class AdvicePage extends StatelessWidget {
  const AdvicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Advice App", style: themeData.textTheme.headline1),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              const Expanded(
                child: Center(
                  //child: ErrorMessage(),
                  child: AdviceField(advice: "Your advice is waiting for you!"),
                  /*
                  Text(
                    "Your advice is waiting for you!",
                    style: themeData.textTheme.headline1,
                  ),
                  */
                ),
              ),
              SizedBox(
                height: 200,
                child: Center(
                  child: CustomButton(
                    onPressed: () {
                      print("button pressed");
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
