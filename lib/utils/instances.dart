//获取全局的currentState
import 'package:flutter/widgets.dart';

NavigatorState? get navigatorState => Instances.navigatorKey.currentState;
//获取全局的上下文
BuildContext? get currentContext => navigatorState?.context;
//获取当前时间
DateTime get currentTime => DateTime.now();

RouteObserver<Route<dynamic>> get routeObserver => Instances.routeObserver;

//实列对象
class Instances {
  const Instances._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static final RouteObserver<Route<dynamic>> routeObserver = RouteObserver();
}
