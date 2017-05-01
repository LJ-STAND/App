git clone https://github.com/LJ-STAND/Apps.git
cd Apps
./bin/bootstrap
xcodebuild -target macOS
rm -rf build/Release/LJ\ STAND.app.dSYM build/Release/LJ_STAND.swiftmodule
cp -R build/Release/* /Applications
cd ..
rm -rf Apps
