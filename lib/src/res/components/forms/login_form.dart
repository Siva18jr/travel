import 'package:levitate/src/model/provider_state/auth_form_provider.dart';
import 'package:levitate/src/res/colors/color.dart';
import 'package:levitate/src/res/components/auth_components.dart';
import 'package:levitate/src/res/components/forms/form_validation.dart';
import 'package:levitate/src/res/components/loading_button.dart';
import 'package:levitate/src/utils/utils.dart';
import 'package:levitate/src/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {

  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final ValueNotifier<bool> _passwordObserver = ValueNotifier<bool>(true);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void dispose() {

    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();

  }

  @override
  Widget build(BuildContext context) {

    final authViewModel = Provider.of<AuthViewModel>(context);
    OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(
          Radius.circular(20)
      ),
      borderSide: BorderSide(
          width: 0,
          color: AppColors.whiteColor
      ),
    );

    return Consumer<AuthFormProvider>(
        builder: (context, value, _){

          return Padding(
              padding: const EdgeInsets.fromLTRB(10, 26, 10, 10),
              child: Column(
                children: [
                  AuthComponents.fullWidthTextField(
                    label: 'Email',
                    height: 132,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      focusNode: _emailFocus,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.textFieldBgColor,
                          suffixIcon: value.isMobileLoginEmpty == true ?
                          const Icon(
                            Icons.info,
                            color: AppColors.redColor,
                          ) : null,
                          border: outlineInputBorder,
                          enabledBorder: outlineInputBorder,
                          focusedBorder: outlineInputBorder
                      ),
                      onChanged: (val){

                        if(val.isEmpty){

                          value.setIsMobileLoginEmpty(true);

                        }else{

                          value.setIsMobileLoginEmpty(false);

                        }

                      },
                      onFieldSubmitted: (value){

                        Utils.fieldFocusChange(
                            context: context,
                            currentFocus: _emailFocus,
                            nextFocus: _passwordFocus
                        );

                      },
                    ),
                  ),
                  AuthComponents.fullWidthTextField(
                    label: 'Password',
                    child: ValueListenableBuilder(
                        valueListenable: _passwordObserver,
                        builder: (context, valueV, child){

                          return TextFormField(
                            keyboardType: TextInputType.text,
                            controller: _passwordController,
                            obscureText: _passwordObserver.value,
                            focusNode: _passwordFocus,
                            textInputAction: TextInputAction.done,
                            obscuringCharacter: '*',
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.textFieldBgColor,
                                border: outlineInputBorder,
                                enabledBorder: outlineInputBorder,
                                focusedBorder: outlineInputBorder,
                                suffixIcon: InkWell(
                                    onTap: () => _passwordObserver.value = !_passwordObserver.value,
                                    child: _passwordObserver.value == false ?
                                    const Icon(
                                      Icons.visibility_off,
                                    ) :
                                    const Icon(
                                        Icons.visibility
                                    )
                                )
                            ),
                          );

                        }
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          top:18
                      ),
                      child: LoadingButton(
                        loading: authViewModel.loginLoading,
                        btnWidth: 210,
                        btnHeight: 45,
                        title: 'Login',
                        onPressed: () {

                          if(FormValidation.isEmpty(_emailController) || FormValidation.isEmpty(_passwordController)){

                            Utils.flushBarMessage(
                                title: 'Error',
                                message: 'Please fill all the Fields',
                                context: context,
                                bgColor: AppColors.redColor
                            );

                          }else {

                            authViewModel.loginApi(
                                context: context,
                                email: _emailController.text.toString(),
                                password: _passwordController.text.toString()
                            );

                          }

                        },
                      )
                  ),
                ],
              )
          );

        }
    );

  }

}