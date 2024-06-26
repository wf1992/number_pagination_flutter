import 'package:flutter_test/flutter_test.dart';
import 'package:number_pagination_flutter/number_pagination_flutter.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNumberPaginationFlutterPlatform
    with MockPlatformInterfaceMixin {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {

}
