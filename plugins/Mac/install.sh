#!/bin/sh
DSTDIR="../../build/Packager/Assets/Plugins"
rm -rf DerivedData
UNITYAPP="/Applications/Unity201731p4/Unity.app"
version=`/usr/libexec/PlistBuddy -c "Print CFBundleVersion" ${UNITYAPP}/Contents/Info.plist`
if [ `echo $version | sed -e "s/\..*$//"` = "2017" ] ; then
    sed -i "" -e "s@/Applications/Unity/Unity.app/Contents/Frameworks/MonoEmbedRuntime/osx@${UNITYAPP}/Contents/Frameworks/Mono/MonoEmbedRuntime/osx@g" WebView.xcodeproj/project.pbxproj
else
    sed -i "" -e "s@/Applications/Unity/Unity.app/Contents/Frameworks/MonoEmbedRuntime/osx@${UNITYAPP}/Contents/Frameworks/MonoEmbedRuntime/osx@g" WebView.xcodeproj/project.pbxproj
fi
xcodebuild -scheme WebView -configuration Release -arch x86_64 build CONFIGURATION_BUILD_DIR='DerivedData'
mkdir -p $DSTDIR
cp -r DerivedData/WebView.bundle $DSTDIR
rm -rf DerivedData
cp WebView.bundle.meta $DSTDIR
