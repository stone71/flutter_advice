import 'package:flutter_advice/application/advice/advice_bloc.dart';
import 'package:flutter_advice/presentation/advice/widgets/advice_field.dart';
import 'package:flutter_advice/presentation/advice/widgets/custom_button.dart';
import 'package:flutter_advice/presentation/advice/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdvicerPage extends StatelessWidget {
  const AdvicerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Advicer", style: themeData.textTheme.headline1),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: BlocBuilder<AdviceBloc, AdviceState>(
                      bloc: BlocProvider.of<AdviceBloc>(context),
                      //bloc: BlocProvider.of<AdvicerBloc>(context)..add(AdviceRequestedEvent()),
                      // INFO Verwendung nur ein state und values,
                      // dann nur Ausführung wenn etwas bestimmtes geändert wurde
                      // buildWhen: (p, c) { return p != c; },
                      builder: (context, adviceState) {
                        if (adviceState is AdviceInitial) {
                          return Text(
                            "Your advice is waiting for you!",
                            style: themeData.textTheme.headline1,
                          );
                        } else if (adviceState is AdviceStateLoading) {
                          return CircularProgressIndicator(
                            color: themeData.colorScheme.secondary,
                          );
                        } else if (adviceState is AdviceStateLoaded) {
                          return AdviceField(
                            advice: adviceState.advice,
                          );
                        } else if (adviceState is AdviceStateError) {
                          return ErrorMessage(
                            message: adviceState.message,
                          );
                        }
                        return const Placeholder();
                      }),
                ),
              ),
              const SizedBox(
                height: 200,
                child: Center(
                  child: CustomButton(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
