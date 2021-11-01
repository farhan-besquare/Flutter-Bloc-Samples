import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample/dear_feature/dear_feature_state.dart';
import 'dear_feature/dear_feature_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
            create: (context) => DearFeatureCubit(),
            child: const MyHomePage(
              title: 'Demo',
            )));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _buttonStateText = '-';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<DearFeatureCubit, DearFeatureState>(
                  bloc: context.read<DearFeatureCubit>(),
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        if (state is DearFeatureEnabledState) {
                          context.read<DearFeatureCubit>().deactivateFeature();
                        } else if (state is DearFeatureDisabledState) {
                          context.read<DearFeatureCubit>().activateFeature();
                        }
                      },
                      child: Text(state is DearFeatureEnabledState
                          ? 'deactivate'
                          : 'activate'),
                    );
                  }),
              SizedBox(
                height: 10,
              ),
              BlocConsumer<DearFeatureCubit, DearFeatureState>(
                bloc: BlocProvider.of<DearFeatureCubit>(context),
                listener: (context, state) {
                  if (state is DearFeatureEnabledState) {
                    _buttonStateText = 'On';
                  } else if (state is DearFeatureDisabledState) {
                    _buttonStateText = 'Off';
                  }
                },
                builder: (context, state) {
                  return Text('Feature is $_buttonStateText');
                },
              )
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
