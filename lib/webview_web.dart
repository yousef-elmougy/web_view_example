// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class WebViewExample extends StatefulWidget {
  const WebViewExample({super.key});

  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  final PlatformWebViewController _controller = PlatformWebViewController(
    const PlatformWebViewControllerCreationParams(),
  )..loadRequest(
          LoadRequestParams(
            uri: Uri.parse('https://flutter.dev'),
          ),
        )
      // ..setPlatformNavigationDelegate(
      //   PlatformNavigationDelegate(
      //     const PlatformNavigationDelegateCreationParams(),
      //   ),
      // )
      ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        getCookies();
      }),
      body: PlatformWebViewWidget(
        PlatformWebViewWidgetCreationParams(controller: _controller),
      ).build(context),
    );
  }

  Future<void> getCookies() async {
    final document = await _controller
        .runJavaScriptReturningResult('document.cookie') as String;
    final cookies = document.split(';');
    cookies.map((cookie) => log('cookie >> $cookie')).toList();

    // final sessionToken = cookies.firstWhere(
    //   (cookie) => cookie.contains('session-token'),
    //   orElse: () => '',
    // );

    // log('cookie session token ==>> $sessionToken');
  }
}
