import 'package:bloc_test/cubit/demo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<DemoCubit>(
        create: (_) => DemoCubit()..success(),
      ),
    ], child: const _MyApp());
  }
}

class _MyApp extends StatelessWidget {
  const _MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text("Test that widget"),
        ),
        body: Center(
          child: BlocConsumer<DemoCubit, DemoState>(
            listener: (_, state) {
              if (state is DemoStateSuccess) {
                toast(context: _, text: 'Successful');
              }
              if (state is DemoStateFailed) {
                toast(context: _, text: 'Failed');
              }
            },
            builder: (_, state) {
              if (state is DemoStateFailed) {
                return const Text("Api call no work ooooo!!!!");
              }
              if (state is DemoStateLoading) {
                return const CircularProgressIndicator();
              }
              if (state is DemoStateSuccess) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: ListView.builder(
                        itemBuilder: (_, index) {
                          return Text(state.data[index]);
                        },
                        itemCount: state.data.length,
                        shrinkWrap: true,
                      ),
                    ),
                  ],
                );
              }

              return const SizedBox();
            },
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: context.read<DemoCubit>().failed,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  void toast({required BuildContext context, required String text}) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
