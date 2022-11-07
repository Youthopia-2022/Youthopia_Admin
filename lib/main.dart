import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
//import 'package:youthopia_2022_app/constants/color_theme.dart';
//import 'package:youthopia_2022_app/screens/loading_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:youthopia_admin/screens/category_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
      url: 'https://bwqibqbxbirzbyjqovco.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ3cWlicWJ4YmlyemJ5anFvdmNvIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjU2NDMxNTcsImV4cCI6MTk4MTIxOTE1N30.7TLUvzsw1-YI-G02oDJbsHHH7U5d1RS25-b-mLiXL6M');

  //await supa.getAboutDetails();
  runApp(
      //! Uncomment to enable Device Preview
/*       DevicePreview(
    enabled: true,
    builder: (context) => const MyApp(), // Wrap your app
  )); */

      const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, deviceType) {
        return MaterialApp(
          theme: ThemeData(
            fontFamily: 'IBM Plex',
            textTheme: const TextTheme(
              subtitle1: TextStyle(color: Colors.white),
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: const CategoryScreen(),
        );
      },
    );
  }
}
