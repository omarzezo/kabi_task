import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kabi_task/base/constants/app_constants.dart';

class KTextField extends StatefulWidget {
  final String? hintText,errorText,obscuringCharacter;
  final String? initialText;
  final Color fillColor, borderColor,focusedColor;
  final bool isObscured;
  final double borderRadius;
  final int? maxLength;
  final TextEditingController? controller;
  final int? maxLines;
  final FontWeight? fontWeight;
  final bool? enabled;
  final bool? isDense;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final Color? textColor;
  final InputBorder? focuseInputBorder;
  final InputBorder? enabledInputBorder;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? suffixIcon;
  final GlobalKey<FormState>? formKey;
  final void Function(String? value) feedback;
  final String? Function(String? value) validator;
  const KTextField({
    Key? key, required this.hintText,this.maxLength,this.suffixIcon,this.inputFormatters,this.textInputType=TextInputType.text,this.textColor=AppColors.black,this.focuseInputBorder,this.contentPadding ,this.enabledInputBorder,
    required this.feedback, this.fillColor =AppColors.primary,this.focusedColor =AppColors.black,  this.borderColor = AppColors.black, this.isObscured = false,
    this.errorText,  this.controller ,this.enabled=true,this.obscuringCharacter='*',this.fontWeight=FontWeight.w400,this.isDense=false,required this.validator, this.formKey, this.borderRadius = 8,
    this.maxLines, this.initialText
  }) : super(key: key);

  @override
  State<KTextField> createState() => _PTextFieldState();
}

class _PTextFieldState extends State<KTextField> {
  TextEditingController? controller;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    controller ??= TextEditingController()..text = widget.initialText ?? '';
    super.initState();
  }
  late  bool isObscured = widget.isObscured;
  @override
  Widget build(BuildContext context) {
    return  Form(
      key: widget.formKey,
      child: TextFormField(
          maxLength:widget.maxLength,
          textAlign:TextAlign.left,
          enabled: widget.enabled,
          scrollController: scrollController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller ?? controller ,
          obscureText: isObscured,
          keyboardType:widget.textInputType??TextInputType.text,
          inputFormatters:widget.inputFormatters??[],
          obscuringCharacter: widget.obscuringCharacter ?? '*',
          style:  TextStyle(fontWeight: widget.fontWeight ?? FontWeight.w600,fontSize: 16,color: widget.textColor ??
              AppColors.primary),
          maxLines: !isObscured ? widget.maxLines : 1,
          textInputAction: TextInputAction.done,
          onChanged: (value) {
            widget.feedback(value);
          },
          validator: (value){
            return widget.validator(value);
          },
          decoration: InputDecoration(
            isDense: widget.isDense ?? false,
            contentPadding:widget.contentPadding ?? const EdgeInsets.all(20),
            prefixIcon:widget.suffixIcon!=null? widget.suffixIcon ?? (isObscured ? IconButton(icon:
            const Icon(Icons.remove_red_eye,color:AppColors.secondary,),onPressed: (){setState(() {
              isObscured = !isObscured;
            });}) : IconButton(icon:const Icon(Icons.remove_red_eye_outlined,color:AppColors.secondary,),onPressed: (){setState(() {
              isObscured = !isObscured;
            });})):null,
            filled: true,
            fillColor: widget.fillColor,
            hintStyle: const TextStyle(fontWeight: FontWeight.w500,fontSize: 12,color: AppColors.primary),
            focusedBorder:widget.focuseInputBorder ?? OutlineInputBorder(
              borderSide: BorderSide(color: widget.focusedColor),
              borderRadius:  BorderRadius.all(Radius.circular(widget.borderRadius)),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color:AppColors.secondary),
              borderRadius:  BorderRadius.all(Radius.circular(widget.borderRadius)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.secondary),
              borderRadius:  BorderRadius.all(Radius.circular(widget.borderRadius)),
            ),
            enabledBorder:widget.enabledInputBorder ?? OutlineInputBorder(
              borderSide: BorderSide(color: widget.borderColor,width: 0),
              borderRadius:  BorderRadius.all(Radius.circular(widget.borderRadius)),
            ),
            disabledBorder : const OutlineInputBorder(borderSide: BorderSide(color:AppColors.primary,width: 2.0),),
            border:  OutlineInputBorder(
              borderSide: BorderSide(color: widget.borderColor,width: 0),
              borderRadius:  BorderRadius.all(Radius.circular(widget.borderRadius)),
            ),
            hintText:widget.hintText,

          )),
    );
  }
}