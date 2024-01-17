import 'package:levitate/src/model/provider_state/auth_form_provider.dart';
import 'package:levitate/src/res/colors/color.dart';
import 'package:levitate/src/res/components/auth_components.dart';
import 'package:levitate/src/res/components/forms/form_validation.dart';
import 'package:levitate/src/res/components/loading_button.dart';
import 'package:levitate/src/utils/utils.dart';
import 'package:levitate/src/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  final ValueNotifier<bool> _passwordObserver = ValueNotifier<bool>(true);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();

  @override
  void dispose() {

    super.dispose();

    _nameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _nameFocus.dispose();
    _passwordFocus.dispose();
    _emailFocus.dispose();

  }

  @override
  Widget build(BuildContext context) {

    final authViewModel = Provider.of<AuthViewModel>(context);
    OutlineInputBorder outlineBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(
          Radius.circular(20.0)
      ),
      borderSide: BorderSide(
          width: 0,
          color: AppColors.whiteColor
      ),
    );

    return Consumer<AuthFormProvider>(
      builder: (context, providerValue, _){

        return Padding(
            padding: const EdgeInsets.fromLTRB(10, 26, 10, 10),
            child: Column(
              children: [
                AuthComponents.fullWidthTextField(
                  label: 'Full Name',
                  child: TextFormField(
                    textInputAction: TextInputAction.none,
                    focusNode: _nameFocus,
                    keyboardType: TextInputType.name,
                    controller: _nameController,
                    decoration: InputDecoration(
                        filled: true,
                        suffixIcon: providerValue.isNameEmpty == true ?
                        const Icon(
                          Icons.info,
                          color: AppColors.redColor,
                        ) : null,
                        fillColor: AppColors.textFieldBgColor,
                        border: outlineBorder,
                        enabledBorder: outlineBorder,
                        focusedBorder: outlineBorder
                    ),
                    onChanged: (val){

                      if(val.isEmpty){

                        providerValue.setIsNameEmpty(true);

                      }else{

                        providerValue.setIsNameEmpty(false);

                      }

                    },
                    onFieldSubmitted: (value){

                      Utils.fieldFocusChange(
                          context: context,
                          currentFocus: _nameFocus,
                          nextFocus: _passwordFocus
                      );

                      if(value.isEmpty){

                        providerValue.setIsNameEmpty(true);

                      }else{

                        providerValue.setIsNameEmpty(false);

                      }

                    },
                  ),
                ),
                AuthComponents.fullWidthTextField(
                  label: 'Password',
                  child: ValueListenableBuilder(
                      valueListenable: _passwordObserver,
                      builder: (context, valueV, child){

                        return TextFormField(
                          textInputAction: TextInputAction.next,
                          focusNode: _passwordFocus,
                          keyboardType: TextInputType.text,
                          controller: _passwordController,
                          obscureText: _passwordObserver.value,
                          obscuringCharacter: '*',
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.textFieldBgColor,
                              suffixIcon: InkWell(
                                  onTap: () => _passwordObserver.value = !_passwordObserver.value,
                                  child: _passwordObserver.value == false ?
                                  const Icon(
                                    Icons.visibility_off,
                                  ) :
                                  const Icon(
                                      Icons.visibility
                                  )
                              ),
                              border: outlineBorder,
                              enabledBorder: outlineBorder,
                              focusedBorder: outlineBorder
                          ),
                          onFieldSubmitted: (value){

                            Utils.fieldFocusChange(
                                context: context,
                                currentFocus: _passwordFocus,
                                nextFocus: _emailFocus
                            );

                          },
                        );

                      }
                  ),
                ),
                AuthComponents.fullWidthTextField(
                  label: 'Email',
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    focusNode: _emailFocus,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.textFieldBgColor,
                        suffixIcon: providerValue.isEmailEmpty == true ?
                        const Icon(
                          Icons.info,
                          color: AppColors.redColor,
                        ) : null,
                        border: outlineBorder,
                        enabledBorder: outlineBorder,
                        focusedBorder: outlineBorder
                    ),
                    onChanged: (val){

                      if(val.isEmpty){

                        providerValue.setIsEmailEmpty(true);

                      }else{

                        providerValue.setIsEmailEmpty(false);

                      }

                    },
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        top:18
                    ),
                    child: LoadingButton(
                        loading: authViewModel.signupLoading,
                        btnWidth: 210,
                        btnHeight: 45,
                        title: 'Sign Up',
                        onPressed: () {

                          if(FormValidation.isEmpty(_nameController) || FormValidation.isEmpty(_emailController) || FormValidation.isEmpty(_passwordController)){

                            Utils.flushBarMessage(
                                title: 'Error',
                                message: 'Please fill all the Fields',
                                context: context,
                                bgColor: AppColors.redColor
                            );

                          }else {

                            authViewModel.signupApi(
                                context: context,
                              email: _emailController.text.toString(),
                              password: _passwordController.text.toString(),
                              userName: _nameController.text.toString()
                            );

                          }

                        }
                    )
                ),
              ],
            )
        );

      },
    );

  }

}