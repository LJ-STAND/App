#!/bin/bash
build=$(<build.conf)
if [ $build = "DEBUG" ] ; then
${SRCROOT}/bin/tag_icons cleanup LJSTAND/Resources/Images.xcassets/AppIcon.appiconset
fi
