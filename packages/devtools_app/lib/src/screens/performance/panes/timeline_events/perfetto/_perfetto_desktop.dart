// Copyright 2022 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '_perfetto_controller_desktop.dart';

class Perfetto extends StatelessWidget {
  const Perfetto({
    Key? key,
    required this.perfettoController,
  }) : super(key: key);

  final PerfettoController perfettoController;

  @override
  Widget build(BuildContext context) {
    // TODO(kenz): consider showing the legacy trace viewer for desktop
    // platforms, or build a desktop only impl of embedding Perfetto if web view
    // support for desktop is ever added.
    return const Center(
      child: Text(
        'Cannot display the Perfetto trace viewer. IFrames are not supported on'
        ' desktop platforms.',
      ),
    );
  }
}
