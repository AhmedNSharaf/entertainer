
flutter clean
if [ -d "build" ]; then
  rm -rf build
fi


flutter pub get
flutter pub upgrade
