import 'package:dw10/src/core/ui/helpers/loader.dart';
import 'package:dw10/src/core/ui/helpers/message.dart';
import 'package:dw10/src/core/ui/style/colors.dart';
import 'package:dw10/src/modules/sign/sign_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask/mask.dart';
import 'package:mobx/mobx.dart';

class SignPage extends StatefulWidget {
  const SignPage({super.key});

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> with Loader, Message {
  final controller = Modular.get<SignController>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final form = GlobalKey<FormState>();
  late ReactionDisposer stateReaction;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unAuthorized();
    });
    controllerState();
    super.initState();
  }

  void unAuthorized() {
    if (Modular.args.queryParams['unauthorized'] == 'true') {
      showMessage('Sessão expirada, faça login novamente',
          type: MessageType.failure);
    }
  }

  void controllerState() {
    stateReaction = reaction((p0) => controller.state, (p0) {
      switch (p0) {
        case SignState.initial:
          break;
        case SignState.loading:
          showLoader();
          break;
        case SignState.success:
          hideLoader();
          Modular.to.navigate('/payment-type');
          break;
        case SignState.error:
          hideLoader();
          showMessage(controller.message, type: MessageType.failure);
          break;
      }
    });
  }

  Future<void> onSubmit() async {
    if (form.currentState!.validate()) {
      await controller.sign(
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    stateReaction();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.black,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset('assets/images/lanche.png'),
          ),
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: form,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(String.fromEnvironment('url')),
                          FractionallySizedBox(
                            widthFactor: .6,
                            child: Image.asset('assets/images/logo.png'),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: emailController,
                            validator: Mask.validations.email,
                            onFieldSubmitted: (v) => onSubmit(),
                            decoration:
                                const InputDecoration(labelText: "Email"),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            onFieldSubmitted: (v) => onSubmit(),
                            validator: (v) =>
                                Mask.validations.generic(v, min: 6),
                            decoration:
                                const InputDecoration(labelText: "Senha"),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: onSubmit,
                              child: const Text('Entrar'),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
