import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sibcode/features/presentaion/widgets/app_text.dart';
import '../../../locator_service.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_const.dart';
import '../../../utils/app_icons.dart';
import '../widgets/app_appbar.dart';

class AuthOrInfoPerson extends StatefulWidget {
  const AuthOrInfoPerson({super.key});

  @override
  State<AuthOrInfoPerson> createState() => _AuthOrInfoPersonState();
}

class _AuthOrInfoPersonState extends State<AuthOrInfoPerson> {
  final TextEditingController controller = TextEditingController();
  late String? number;

  final FocusNode focusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  final OutlineInputBorder borderCustom = const OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.grey241,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(0),
    ),
  );

  @override
  void initState() {
    number = sl<SharedPreferences>().getString(AppConst.numberPhone);
    if (number != null) {
      controller.text = number!;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AuthOrInfoPerson oldWidget) {
    number = sl<SharedPreferences>().getString(AppConst.numberPhone);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: sl<SharedPreferences>().getString(AppConst.numberPhone) != null
            ? AppAppBar(
                icon: AppIcons.backLeftIcon,
                color: Colors.transparent,
                onTap: () => context.go('/home'),
              )
            : null,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (number == null) ...[
                  const AppText(
                    text: 'Авторизироваться',
                    size: 18,
                  ),
                  const SizedBox(
                    height: 47,
                  ),
                ],
                const AppText(
                  text: 'Номер телефона',
                  size: 18,
                ),
                const SizedBox(
                  height: 9,
                ),
                TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  enabled: number == null,
                  keyboardType: TextInputType.phone,
                  validator: (text) => phoneValidator(text),
                  onFieldSubmitted: (value) {
                    focusNode.unfocus();
                  },
                  style: GoogleFonts.exo2(
                    color: number == null ? Colors.black : AppColors.grey153,
                  ),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.grey241,
                    focusedBorder: borderCustom,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () => number == null ? onSubmit(context) : onExit(context),
                  child: Container(
                    width: 152,
                    height: 31,
                    color: AppColors.grey202,
                    child: Center(
                      child: AppText(
                        text: number == null ? 'Вход' : 'Выход',
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? phoneValidator(String? text) {
    if (text == null || text.isEmpty || text == '911') {
      return 'Ошибка';
    }
    return null;
  }

  void onSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      sl<SharedPreferences>().setString(
        AppConst.numberPhone,
        controller.text,
      );
      context.go('/home');
    }
  }

  void onExit(BuildContext context) {
    sl<SharedPreferences>().remove(
      AppConst.numberPhone,
    );
    controller.clear();
    context.go('/');
  }
}
