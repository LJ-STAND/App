#!/bin/bash
build=$(<build.conf)
if [ $build = "DEBUG" ] ; then
${SRCROOT}/bin/tag_icons tag ${SRCROOT}/LJSTAND/Resources/Images.xcassets/AppIcon.appiconset
fi
