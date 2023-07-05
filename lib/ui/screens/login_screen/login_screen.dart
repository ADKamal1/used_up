import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/main_layout.dart';
import '../../../shared/helper/methods.dart';
import '../../components/custom_button.dart';
import 'cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            Navigator.pop(context);
            showSnackBar(context, state.errorMsg);
          } else if (state is LoginSuccessState) {
            Navigator.pop(context);
            navigateToAndFinish(context, MainLayout());
          } else if (state is LoginLoadingState) {
            showCustomProgressIndicator(context);
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                    text: 'Login',
                    press: () {
                      cubit.signInUser();
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
