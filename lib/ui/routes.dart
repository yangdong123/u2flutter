import 'package:flutter/material.dart';
import 'pages/MainPage.dart';
import 'pages/FavoritesPage.dart';
import 'pages/PlayPage.dart';
import 'pages/SettingsPage.dart';
import 'pages/AboutPage.dart';
import 'pages/SharePage.dart';
import 'pages/ChannelPage.dart';
import 'pages/CListVideos.dart';

final Map<String, WidgetBuilder> routes = {
  "/": (c) => MainPage(),
  '/favorites': (c) => FavoritesPage(),
  '/share': (c) => SharePage(),
  '/channel':(c)=>ChannelPage(),
  '/listvideos':(c)=>CListVideos(),
  '/play': (c) => PlayPage(),
  '/about': (c) => AboutPage(),
  '/settings': (c) => SettingsPage(),
};
