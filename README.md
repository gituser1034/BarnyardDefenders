# BarnyardDefenders
Farm themed tower defense mobile game made in a group with Flutter and Dart in Android Studio. For a class project.

To use create an Android Studio Flutter with Dart project, drag the folders with dart files into the correct folder within that project (lib). 

Unzip images, create an assets folder dragging the images and tiles folders into that. 

Drag in pubspec.yaml into the correct place in your project, it should just replace the default pubspec.yaml. 

Where it gets complicated: the build.gradle uploaded here is app level, replace the original with this one, though some parts might be machine specific, can compare that with original to make sure everything is implemented. Some stuff might need to be changed in project level build.gradle. You will need to add correct dependencies relating to sqlite and firebase to your project as well. Can also just comment out firebase code and not worry about that.

Also review the permissions in this android.xml and add those to your machine specific android.xml file.
