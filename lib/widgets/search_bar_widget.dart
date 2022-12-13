import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/text_field_cursor.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    Key? key,
    this.textController,
    this.onChanged,
    this.onSubmitted,
    this.inputFormatters,
    this.textFieldEnabled,
    this.cursor,
  }) : super(key: key);

  final TextEditingController? textController;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool? textFieldEnabled;
  final TextFieldCursor? cursor;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      // focusNode: ,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.white10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.white10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.white, width: .5),
        ),
        hintStyle: TextStyle(color: Colors.grey),
        hintText: "Search...",
        contentPadding: EdgeInsets.fromLTRB(12, 8, 8, 8),
        prefixIcon: Icon(Icons.search_rounded, size: 20),
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      textCapitalization: TextCapitalization.none,
      style: GoogleFonts.lato(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.italic,
        fontSize: 14,
      ),
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      textDirection: TextDirection.ltr,
      readOnly: false,
      toolbarOptions: const ToolbarOptions(
        copy: true,
        cut: true,
        paste: true,
        selectAll: true,
      ),
      showCursor: true,
      autofocus: false,
      // Password case
      // obscuringCharacter: "*",
      // obscureText: true,
      autocorrect: true,
      enableSuggestions: true,
      maxLines: 1,
      // minLines: ,
      expands: false, // true for TextArea
      maxLength: 200,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      inputFormatters: inputFormatters,
      enabled: textFieldEnabled,
      cursorWidth: cursor?.cursorWidth ?? 2.0,
      cursorHeight: cursor?.cursorHeight,
      cursorRadius: cursor?.cursorRadius,
      cursorColor: cursor?.cursorColor,

    );
  }
}
