import 'package:chatapp/core/di/di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
final locator = GetIt.instance;

@InjectableInit()
Future<void> initDependencies() async => locator.init();
