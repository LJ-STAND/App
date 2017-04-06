#!/bin/sh
rm -rf ${SRCROOT}/Icons/OverlayIcon.appiconset
unzip ${SRCROOT}/Icons/OverlayIcon.appiconset.zip -d ${SRCROOT}/Icons
rm -rf ${SRCROOT}/Icons/__MACOSX
${SRCROOT}/bin/tag_icons tag ${SRCROOT}/Icons/OverlayIcon.appiconset
