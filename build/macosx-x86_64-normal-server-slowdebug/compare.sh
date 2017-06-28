#!/bin/bash
#
# Copyright (c) 2012, 2016, Oracle and/or its affiliates. All rights reserved.
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
#
# This code is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License version 2 only, as
# published by the Free Software Foundation.
#
# This code is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# version 2 for more details (a copy is included in the LICENSE file that
# accompanied this code).
#
# You should have received a copy of the GNU General Public License version
# 2 along with this work; if not, write to the Free Software Foundation,
# Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
#
# Please contact Oracle, 500 Oracle Parkway, Redwood Shores, CA 94065 USA
# or visit www.oracle.com if you need additional information or have any
# questions.
#

# This script is processed by configure before it's usable. It is run from
# the root of the build directory.


##########################################################################################
# Substitutions from autoconf

export LEGACY_BUILD_DIR=macosx-x86_64

export OPENJDK_TARGET_OS="macosx"
export OPENJDK_TARGET_CPU="x86_64"
export DEBUG_LEVEL="slowdebug"

export AWK="awk"
export BASH="/bin/bash"
export CAT="/bin/cat"
export CMP="/usr/bin/cmp"
export CP="/bin/cp"
export CUT="/usr/bin/cut"
export DIFF="/usr/bin/diff"
export DUMPBIN=" "
export EXPR="/bin/expr"
export FILE="/usr/bin/file"
export FIND="/usr/bin/find"
export GREP="/usr/bin/grep"
export GUNZIP="/usr/bin/gunzip"
export LDD="true"
export LN="/bin/ln"
export MKDIR="/bin/mkdir"
export MV="/bin/mv"
export NAWK="/usr/bin/awk"
export NM="/usr/bin/nm"
export OBJDUMP="/usr/bin/objdump"
export OTOOL="/usr/bin/otool"
export PRINTF="/usr/bin/printf"
export READELF=""
export RM="/bin/rm -f"
export SED="/usr/bin/sed"
export SORT="/usr/bin/sort"
export STAT="/usr/bin/stat"
export STRIP="/usr/bin/strip -S"
export TAR="/usr/bin/tar"
export TEE="/usr/bin/tee"
export UNIQ="/usr/bin/uniq"
export UNPACK200=" /Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home/bin/unpack200"
export UNARCHIVE="/usr/bin/unzip -q -o"

export SRC_ROOT="/Users/Chao/openjdk9"
export OUTPUT_ROOT="/Users/Chao/openjdk9/build/macosx-x86_64-normal-server-slowdebug"

if [ "native" != "cross" ]; then
    export JAVAP=" $OUTPUT_ROOT/jdk/bin/javap  -J-XX:+UseSerialGC -J-Xms32M -J-Xmx512M -J-XX:TieredStopAtLevel=1"
    export JIMAGE=" $OUTPUT_ROOT/jdk/bin/jimage"
elif [ "false" = "true" ]; then
    export JAVAP=" $OUTPUT_ROOT/buildjdk/jdk/bin/javap  -J-XX:+UseSerialGC -J-Xms32M -J-Xmx512M -J-XX:TieredStopAtLevel=1"
    export JIMAGE=" $OUTPUT_ROOT/buildjdk/jdk/bin/jimage"
else
    export JAVAP=" $(JDK_OUTPUTDIR)/bin/javap  -J-XX:+UseSerialGC -J-Xms32M -J-Xmx512M -J-XX:TieredStopAtLevel=1"
    export JIMAGE=" $(JDK_OUTPUTDIR)/bin/jimage"
fi

if [ "$OPENJDK_TARGET_OS" = "windows" ]; then
  export PATH=""
fi

# Now locate the main script and run it.
REAL_COMPARE_SCRIPT="$SRC_ROOT/common/bin/compare.sh"
if [ ! -e "$REAL_COMPARE_SCRIPT" ]; then
  echo "Error: Cannot locate compare script, it should have been in $REAL_COMPARE_SCRIPT"
  exit 1
fi

# Rotate logs
$RM $OUTPUT_ROOT/compare.log.old 2> /dev/null
$MV $OUTPUT_ROOT/compare.log $OUTPUT_ROOT/compare.log.old 2> /dev/null

export SCRIPT_DIR="$( cd "$( dirname "$0" )" > /dev/null && pwd )"

$BASH $SRC_ROOT/common/bin/logger.sh $OUTPUT_ROOT/compare.log $BASH "$REAL_COMPARE_SCRIPT" "$@"
