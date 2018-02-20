From: gitlab@mg.gitlab.com (Agustin Benito Bethencourt)
Date: Tue, 20 Feb 2018 09:16:57 +0000
Subject: [cip-dev]
 [Git][cip-project/cip-testing/imported-kernel-tests][master] 2 commits: Get
 install correct
Message-ID: <5a8be789c6ace_1adde3fe19f19038c715045b@sidekiq-asap-01.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Agustin Benito Bethencourt pushed to branch master at cip-project / cip-testing / imported-kernel-tests


Commits:
bd25c959 by Robert Marshall at 2017-07-25T14:02:02+01:00
Get install correct

- - - - -
95e5dd3d by Robert Marshall at 2017-07-25T14:38:13+01:00
Initial commit

- - - - -


2 changed files:

- kselftest.yaml
- + selftests/kselftest_install.sh


Changes:

=====================================
kselftest.yaml
=====================================
--- a/kselftest.yaml
+++ b/kselftest.yaml
@@ -28,17 +28,17 @@ params:
 
 # Skip install deps and steps on minimal rootfs from LAVA test
 # Example:
-# "skip_install": "all"
-install:
-    deps:
-        - libpopt-dev
-        - libcap-dev
-        - binutils-dev
-        - perl
-        - wget
-        - tar
-    steps:
-        - './'
+skip_install: all
+# install:
+#     deps:
+#         - libpopt-dev
+#         - libcap-dev
+#         - binutils-dev
+#         - perl
+#         - wget
+#         - tar
+#     steps:
+#         - './'
 
 run:
     steps:


=====================================
selftests/kselftest_install.sh
=====================================
--- /dev/null
+++ b/selftests/kselftest_install.sh
@@ -0,0 +1,37 @@
+#!/bin/bash
+#
+# Kselftest Install
+# Install kselftest tests
+# Author: Shuah Khan <shuahkh@osg.samsung.com>
+# Copyright (C) 2015 Samsung Electronics Co., Ltd.
+
+# This software may be freely redistributed under the terms of the GNU
+# General Public License (GPLv2).
+
+install_loc=`pwd`
+
+main()
+{
+	if [ $(basename $install_loc) !=  "selftests" ]; then
+		echo "$0: Please run it in selftests directory ..."
+		exit 1;
+	fi
+	if [ "$#" -eq 0 ]; then
+		echo "$0: Installing in default location - $install_loc ..."
+	elif [ ! -d "$1" ]; then
+		echo "$0: $1 doesn't exist!!"
+		exit 1;
+	else
+		install_loc=$1
+		echo "$0: Installing in specified location - $install_loc ..."
+	fi
+
+	install_dir=$install_loc/kselftest
+
+# Create install directory
+	mkdir -p $install_dir
+# # Build tests
+# 	INSTALL_PATH=$install_dir make install
+}
+
+main "$@"



View it on GitLab: https://gitlab.com/cip-project/cip-testing/imported-kernel-tests/compare/32d808ad6953234f950fc8ad3c8b8f541eabce7f...95e5dd3db99fa6423661e1db1a09b1a40d660ba4

---
View it on GitLab: https://gitlab.com/cip-project/cip-testing/imported-kernel-tests/compare/32d808ad6953234f950fc8ad3c8b8f541eabce7f...95e5dd3db99fa6423661e1db1a09b1a40d660ba4
You're receiving this email because of your account on gitlab.com.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20180220/11b1ce13/attachment-0001.html>
