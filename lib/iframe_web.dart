//ignore: avoid_web_libraries_in_flutter
import 'dart:developer';
import 'dart:html';
import 'dart:ui_web';

import 'package:flutter/material.dart';

class WebviewForWebWidget extends StatefulWidget {
  const WebviewForWebWidget({
    super.key,
  });

  @override
  State<WebviewForWebWidget> createState() => _WebviewForWebWidgetState();
}

class _WebviewForWebWidgetState extends State<WebviewForWebWidget> {
  IFrameElement? _iframeElement;
  bool loading = true;
  String iframeName = '';

  @override
  void initState() {
    super.initState();
    // const src = 'https://www.youtube.com/signin';
    // const src = 'https://www.google.com/';
    // const src = 'https://www.openstreetmap.org/export/embed.html?bbox=-0.004017949104309083%2C51.47612752641776%2C0.00030577182769775396%2C51.478569861898606&layer=mapnik';
    const src = 'http://www.youtube.com/';

    _iframeElement = IFrameElement()
      ..height = '100%'
      ..width = '100%'
      ..style.border = 'none'
      ..src = src;

    iframeName = 'iframeElement';

    platformViewRegistry.registerViewFactory(
      iframeName,
      (viewId) => _iframeElement!,
    );

    Future.delayed(const Duration(seconds: 12), () {
      if (!mounted) return;

      setState(() {
        loading = false;
      });
    });
    // Wait for the iframe to load
    Future.delayed(const Duration(seconds: 2), () {
      final iframe = window.document.querySelector('iframe[name=$iframeName]');

      if (iframe != null) {
        final ownerDocument = iframe.ownerDocument;
        if (ownerDocument != null) {
          final cookies = ownerDocument.cookie;
          log('YouTube Cookies: $cookies');
        }
      }
    });
  }

  @override
  void dispose() {
    _iframeElement?.parent?.remove();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [HtmlElementView(viewType: iframeName)],
        ),
      );
}
