import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:techbox/src/core/theme/app_colors.dart';

class ExpandableHtmlDescription extends StatefulWidget {
  final String htmlContent;
  final int maxLinesWhenCollapsed;

  const ExpandableHtmlDescription({
    super.key,
    required this.htmlContent,
    this.maxLinesWhenCollapsed = 3,
  });

  @override
  State<ExpandableHtmlDescription> createState() =>
      _ExpandableHtmlDescriptionState();
}

class _ExpandableHtmlDescriptionState
    extends State<ExpandableHtmlDescription> {
  bool _isExpanded = false;

  /// Convert HTML to plain text for collapsed state
  String get plainText {
    final document = html_parser.parse(widget.htmlContent);
    return document.body?.text.trim() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _isExpanded
            ? Html(
                data: widget.htmlContent,
                style: {
                  "body": Style(
                    fontSize: FontSize(16),
                    fontWeight: FontWeight.w400,
                    color: AppColors.darkGray,
                    lineHeight: LineHeight.em(1.5),
                    margin: Margins.zero,
                    padding: HtmlPaddings.zero,
                  ),
                },
              )
            : Text(
                plainText,
                maxLines: widget.maxLinesWhenCollapsed,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.darkGray,
                  height: 1.5,
                ),
              ),
        const SizedBox(height: 4),
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Text(
            _isExpanded ? 'Rút gọn' : 'Đọc thêm',
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
