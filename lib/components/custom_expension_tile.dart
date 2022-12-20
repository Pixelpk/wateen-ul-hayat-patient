import 'package:flutter_html/flutter_html.dart';
import '../export.dart';

customTile({String? question, String? answer}) => ExpansionTile(
      title: text(question ?? '', isBold: true, maxLines: 3),
      children: [
        Html(
          data: answer,
          onLinkTap: (url, context, attributes, element) {},
        )
      ],
    );
