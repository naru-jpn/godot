scons platform=ios target=template_debug
scons platform=ios target=template_release
scons platform=ios target=template_debug ios_simulator=yes arch=arm64
scons platform=ios target=template_debug ios_simulator=yes arch=x86_64
scons platform=ios target=template_release ios_simulator=yes arch=arm64
scons platform=ios target=template_release ios_simulator=yes arch=x86_64

cp -r misc/dist/ios_xcode .
cp bin/libgodot.ios.template_debug.arm64.a ios_xcode/libgodot.ios.debug.xcframework/ios-arm64/libgodot.a
cp bin/libgodot.ios.template_release.arm64.a ios_xcode/libgodot.ios.release.xcframework/ios-arm64/libgodot.a
lipo -create bin/libgodot.ios.template_debug.arm64.simulator.a bin/libgodot.ios.template_debug.x86_64.simulator.a -output ios_xcode/libgodot.ios.debug.xcframework/ios-arm64_x86_64-simulator/libgodot.a
lipo -create bin/libgodot.ios.template_release.arm64.simulator.a bin/libgodot.ios.template_release.x86_64.simulator.a -output ios_xcode/libgodot.ios.release.xcframework/ios-arm64_x86_64-simulator/libgodot.a

cp -r ios_xcode_headers/* ./ios_xcode/libgodot.ios.debug.xcframework/ios-arm64/Headers
cp -r ios_xcode_headers/* ./ios_xcode/libgodot.ios.release.xcframework/ios-arm64/Headers
cp -r ios_xcode_headers/* ./ios_xcode/libgodot.ios.debug.xcframework/ios-arm64_x86_64-simulator/Headers
cp -r ios_xcode_headers/* ./ios_xcode/libgodot.ios.release.xcframework/ios-arm64_x86_64-simulator/Headers

(
  cd ios_xcode
  zip -r ios.zip ./*
  mv ./ios.zip ./../ios.zip
)
