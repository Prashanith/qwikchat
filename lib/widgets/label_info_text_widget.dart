import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LabelInfoWidget extends StatelessWidget {
  const LabelInfoWidget({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  final Icon icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Row(
      children: [
        Expanded(
          child: TextFormField(
              style: textTheme.bodyMedium,
              readOnly: true,
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      )),
                  disabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: context.theme.colorScheme.primaryContainer,
                      )),
                  enabled: true,
                  enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: context.theme.colorScheme.primaryContainer,
                      )),
                  errorBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: context.theme.colorScheme.primaryContainer,
                      )),
                  focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: context.theme.colorScheme.primaryContainer,
                      )),
                  focusedErrorBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: context.theme.colorScheme.primaryContainer,
                      )),
                  suffixIcon: icon,
                  suffixIconColor: Colors.grey.shade400,
                  label: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      label,
                      style: textTheme.bodySmall,
                    ),
                  ),
                  focusColor: Colors.transparent,
                  labelStyle: textTheme.labelSmall),
              controller: TextEditingController(
                text: value.isNotEmpty ? value : '--',
              )),
        )
      ],
    );
  }
}
