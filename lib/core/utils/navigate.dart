import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


void pushNamed(BuildContext context,String targetPath){
  ///use if did not use go router
  //final currentLocation = ModalRoute.of(context)?.settings.name;
  final currentLocation = GoRouterState.of(context).name;

  if(currentLocation != targetPath){
    context.pushNamed(targetPath);
  }

}