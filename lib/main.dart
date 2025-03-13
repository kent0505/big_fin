import 'dart:async';

import 'package:big_fin/src/core/utils.dart';
import 'package:big_fin/src/features/initialization/data/initialization.dart';

void main([List<String>? args]) =>
    runZonedGuarded<Future<void>>(() async => $initializeAndRunApp(),
        (error, stackTrace) {
      Error.safeToString(error);
      stackTrace.toString();
      logger('Error: error, stackTrace: stackTrace');
    });
