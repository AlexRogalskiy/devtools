// Copyright 2022 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:devtools_app/src/primitives/utils.dart';
import 'package:devtools_app/src/screens/performance/panes/raster_stats/raster_stats_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_data/performance_raster_stats.dart';

void main() {
  late RasterStats rasterStats;

  group('$RasterStats model', () {
    test('empty constructor', () {
      rasterStats = RasterStats.empty();
      expect(rasterStats.layerSnapshots, isEmpty);
      expect(rasterStats.selectedSnapshot, isNull);
      expect(rasterStats.originalFrameSize, isNull);
      expect(rasterStats.totalRasterTime, equals(Duration.zero));
    });

    test('parse from service data', () {
      rasterStats = RasterStats.parse(rasterStatsFromServiceJson);
      expect(rasterStats.layerSnapshots.length, equals(2));
      expect(rasterStats.selectedSnapshot, isNotNull);
      expect(rasterStats.selectedSnapshot!.id, equals(12731));
      expect(rasterStats.originalFrameSize, equals(const Size(100.0, 200.0)));
      expect(
        rasterStats.totalRasterTime,
        equals(const Duration(microseconds: 494)),
      );

      // verify each of the [LayerSnapshot]s were parsed correctly
      final first = rasterStats.layerSnapshots[0];
      final second = rasterStats.layerSnapshots[1];
      expect(first.id, equals(12731));
      expect(first.duration.inMicroseconds, equals(389));
      expect(first.totalRenderingDuration!.inMicroseconds, equals(494));
      expect(first.percentRenderingTimeDisplay, equals('78.74%'));
      expect(first.size, equals(const Size(50, 50)));
      expect(first.offset, equals(const Offset(25, 25)));
      expect(second.id, equals(12734));
      expect(second.duration.inMicroseconds, equals(105));
      expect(second.totalRenderingDuration!.inMicroseconds, equals(494));
      expect(second.percentRenderingTimeDisplay, equals('21.26%'));
      expect(second.size, equals(const Size(20, 40)));
      expect(second.offset, equals(const Offset(35, 30)));
    });

    test('parse from devtools data', () {
      rasterStats = RasterStats.parse(rasterStatsFromDevToolsJson);
      expect(rasterStats.layerSnapshots.length, equals(2));
      expect(rasterStats.selectedSnapshot, isNotNull);
      expect(rasterStats.selectedSnapshot!.id, equals(12734));
      expect(rasterStats.originalFrameSize, equals(const Size(100.0, 200.0)));
      expect(
        rasterStats.totalRasterTime,
        equals(const Duration(microseconds: 494)),
      );

      // verify each of the [LayerSnapshot]s were parsed correctly
      final first = rasterStats.layerSnapshots[0];
      final second = rasterStats.layerSnapshots[1];
      expect(first.id, equals(12731));
      expect(first.duration.inMicroseconds, equals(389));
      expect(first.totalRenderingDuration!.inMicroseconds, equals(494));
      expect(first.percentRenderingTimeDisplay, equals('78.74%'));
      expect(first.size, equals(const Size(50, 50)));
      expect(first.offset, equals(const Offset(25, 25)));
      expect(second.id, equals(12734));
      expect(second.duration.inMicroseconds, equals(105));
      expect(second.totalRenderingDuration!.inMicroseconds, equals(494));
      expect(second.percentRenderingTimeDisplay, equals('21.26%'));
      expect(second.size, equals(const Size(20, 40)));
      expect(second.offset, equals(const Offset(35, 30)));
    });

    test('to json', () {
      rasterStats = RasterStats.empty();
      var json = rasterStats.json;
      var expected = <String, Object?>{
        'frame_width': null,
        'frame_height': null,
        'snapshots': [],
        'selectedId': null
      };
      expect(collectionEquals(json, expected), isTrue);

      rasterStats = RasterStats.parse(rasterStatsFromServiceJson);
      json = rasterStats.json;
      expected = Map<String, Object?>.from(rasterStatsFromServiceJson);
      // The expected output should not have the 'type' field that comes from
      // the service protocol and it should have an additional field for the id
      // of the selected snapshot.
      expected.remove('type');
      expected['selectedId'] = 12731;
      expect(collectionEquals(json, expected), isTrue);
    });
  });
}
