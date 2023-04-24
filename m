Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63282C7618E
	for <webhook@archiver.kernel.org>; Mon, 24 Apr 2023 11:56:21 +0000 (UTC)
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by mx.groups.io with SMTP id smtpd.web11.48650.1682337373564321784
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Apr 2023 04:56:13 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.137.180, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; 
   d="scan'208";a="3328132"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa3.mentor.iphmx.com with ESMTP; 24 Apr 2023 03:56:09 -0800
IronPort-SDR: o9InBut1pPdNUGhF/USebwekfzy1nvyNTJIzCKU9Slt53mIYtdrzqC6FpEcAH2Epdyb+/6ZJp0
 qp5Ka0MWqtLkkdU0fgyIebbH6euFOpTwUx8FCNEca58veI8YoK3mPnSlbcWO/W4t73VYLI+Z4d
 mOk+W2QFbJHUDJ4lihRBCP+xc9tmYJkadqy5byRxlv6JOyTXRWsTrFlriDzoc6oBicEpSDKGib
 aBBGc7OaV/H7H6/fqbusuYZxfSPKHMRsJQS3fcQcIYf+A7A+nxi/TFgBJDyFeoD0fQhDe6QPtF
 rsU=
From: Srinuvasan Arjunan <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [PATCH] recipes-python/shtab: Update shelltab to latest one
Date: Mon, 24 Apr 2023 17:25:51 +0530
Message-ID: <20230424115551.2896898-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-14.mgc.mentorg.com (147.34.90.214) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Apr 2023 11:56:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11333

From: Srinuvasan A <srinuvasan.a@siemens.com>

Update shelltab to latest one.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 recipes-bsp/efibootguard/efibootguard_0.13.bb |  2 +-
 ...001-Lower-requirements-on-setuptools.patch | 28 ------------
 ...ix-cross-build-issue-for-bullseye-im.patch | 33 ++++++++++++++
 ...002-Lower-requirements-on-setuptools.patch | 36 ++++++++++++++++
 ...003-Lower-requirements-on-setuptools.patch | 43 +++++++++++++++++++
 recipes-python/shtab/files/rules              | 21 ---------
 recipes-python/shtab/python3-shtab_1.4.2.bb   | 36 ----------------
 recipes-python/shtab/python3-shtab_1.5.5-3.bb | 31 +++++++++++++
 8 files changed, 144 insertions(+), 86 deletions(-)
 delete mode 100644 recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch
 create mode 100644 recipes-python/shtab/files/0001-debian-control-Fix-cross-build-issue-for-bullseye-im.patch
 create mode 100644 recipes-python/shtab/files/0002-Lower-requirements-on-setuptools.patch
 create mode 100644 recipes-python/shtab/files/0003-Lower-requirements-on-setuptools.patch
 delete mode 100755 recipes-python/shtab/files/rules
 delete mode 100644 recipes-python/shtab/python3-shtab_1.4.2.bb
 create mode 100644 recipes-python/shtab/python3-shtab_1.5.5-3.bb

diff --git a/recipes-bsp/efibootguard/efibootguard_0.13.bb b/recipes-bsp/efibootguard/efibootguard_0.13.bb
index dd76198..313716a 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.13.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.13.bb
@@ -29,7 +29,7 @@ PROVIDES = "${PN}"
 PROVIDES += "${PN}-dev"
 
 DEPENDS = "python3-shtab"
-BUILD_DEB_DEPENDS = "debhelper,autoconf-archive,check,gnu-efi,libpci-dev,pkg-config,python3-shtab,zlib1g-dev"
+BUILD_DEB_DEPENDS = "debhelper,autoconf-archive,check,gnu-efi,libpci-dev,pkg-config,python3-shtab:native,zlib1g-dev"
 BUILD_DEB_DEPENDS:append:amd64 = ",libc6-dev-i386"
 BUILD_DEB_DEPENDS:append:i386 = ",libc6-dev-i386"
 
diff --git a/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch b/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch
deleted file mode 100644
index dccc2dd..0000000
--- a/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch
+++ /dev/null
@@ -1,28 +0,0 @@
-From d347695c4b173c94c4d8a678a67947de3ee5f186 Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Mon, 14 Mar 2022 08:17:00 +0100
-Subject: [PATCH] Lower requirements on setuptools
-
-Allows to build against Debian buster.
-
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
----
- setup.cfg | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/setup.cfg b/setup.cfg
-index 55eecd4..186aad6 100644
---- a/setup.cfg
-+++ b/setup.cfg
-@@ -66,7 +66,7 @@ classifiers=
-     Topic :: Terminals
-     Topic :: Utilities
- [options]
--setup_requires=setuptools>=42; setuptools_scm[toml]>=3.4
-+setup_requires=setuptools>=40; setuptools_scm>=3.2
- install_requires=
-     argparse; python_version < "2.7" or ("3.0" <= python_version and python_version < "3.2")
- python_requires= >=2.7, !=3.0.*, !=3.1.*
--- 
-2.34.1
-
diff --git a/recipes-python/shtab/files/0001-debian-control-Fix-cross-build-issue-for-bullseye-im.patch b/recipes-python/shtab/files/0001-debian-control-Fix-cross-build-issue-for-bullseye-im.patch
new file mode 100644
index 0000000..9fb17de
--- /dev/null
+++ b/recipes-python/shtab/files/0001-debian-control-Fix-cross-build-issue-for-bullseye-im.patch
@@ -0,0 +1,33 @@
+From 661472b5fb651a140cd9852fef4b797b8535fedf Mon Sep 17 00:00:00 2001
+From: Srinuvasan A <srinuvasan.a@siemens.com>
+Date: Mon, 16 Jan 2023 13:55:23 +0530
+Subject: [PATCH] debian/control: Fix cross build issue for bullseye images
+
+Fix cross build issues for bullseye images.
+
+Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
+---
+ debian/control | 8 +++++---
+ 1 file changed, 5 insertions(+), 3 deletions(-)
+
+diff --git a/debian/control b/debian/control
+index b30beb1..a63e366 100644
+--- a/debian/control
++++ b/debian/control
+@@ -6,9 +6,11 @@ Uploaders: Felix Moessbauer <felix.moessbauer@siemens.com>
+ Build-Depends: debhelper-compat (= 13),
+  dh-python,
+  python3-setuptools (>=42),
+- python3-setuptools-scm (>=3.4),
+- python3-all (>=3.2),
+- python3-wheel,
++ python3-setuptools-scm:native (>=3.4),
++ libpython3-all-dev (>=3.2),
++ python3-all-dev:any (>=3.2),
++ python3-wheel:native,
++ python3-toml:native,
+  python3-pytest <!nocheck>,
+  python3-pytest-cov <!nocheck>,
+  python3-pytest-timeout <!nocheck>,
+-- 
+2.34.1
diff --git a/recipes-python/shtab/files/0002-Lower-requirements-on-setuptools.patch b/recipes-python/shtab/files/0002-Lower-requirements-on-setuptools.patch
new file mode 100644
index 0000000..1db4fa8
--- /dev/null
+++ b/recipes-python/shtab/files/0002-Lower-requirements-on-setuptools.patch
@@ -0,0 +1,36 @@
+From 1d2e28a3da03815d16e0fb6dc11428509f4ed366 Mon Sep 17 00:00:00 2001
+From: Srinuvasan A <srinuvasan.a@siemens.com>
+Date: Tue, 17 Jan 2023 18:54:33 +0530
+Subject: [PATCH] Lower requirements on setuptools
+
+Allows to build against Debian buster and fix cross build issues.
+
+Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
+---
+ debian/control | 10 +++++-----
+ 1 file changed, 5 insertions(+), 5 deletions(-)
+
+diff --git a/debian/control b/debian/control
+index b30beb1..380b934 100644
+--- a/debian/control
++++ b/debian/control
+@@ -3,12 +3,12 @@ Section: python
+ Priority: optional
+ Maintainer: Debian Python Team <team+python@tracker.debian.org>
+ Uploaders: Felix Moessbauer <felix.moessbauer@siemens.com>
+-Build-Depends: debhelper-compat (= 13),
++Build-Depends: debhelper-compat (= 12),
+  dh-python,
+- python3-setuptools (>=42),
+- python3-setuptools-scm (>=3.4),
+- python3-all (>=3.2),
+- python3-wheel,
++ python3-setuptools (>=40),
++ python3-setuptools-scm:native (>=3.2),
++ libpython3-all-dev (>=3.2),
++ python3-all-dev:any (>=3.2),
+  python3-pytest <!nocheck>,
+  python3-pytest-cov <!nocheck>,
+  python3-pytest-timeout <!nocheck>,
+-- 
+2.34.1
diff --git a/recipes-python/shtab/files/0003-Lower-requirements-on-setuptools.patch b/recipes-python/shtab/files/0003-Lower-requirements-on-setuptools.patch
new file mode 100644
index 0000000..9687222
--- /dev/null
+++ b/recipes-python/shtab/files/0003-Lower-requirements-on-setuptools.patch
@@ -0,0 +1,43 @@
+From a4d6204b7fe5af89f7edfb9a6d8e58455ee73e46 Mon Sep 17 00:00:00 2001
+From: Srinuvasan A <srinuvasan.a@siemens.com>
+Date: Tue, 17 Jan 2023 19:06:50 +0530
+Subject: [PATCH] Lower requirements on setuptools
+
+Allows to build against Debian buster.
+
+Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
+---
+ .../0001-Lower-requirements-on-setuptools.diff      | 13 +++++++++++++
+ debian/patches/series                               |  1 +
+ 2 files changed, 14 insertions(+)
+ create mode 100644 debian/patches/0001-Lower-requirements-on-setuptools.diff
+ create mode 100644 debian/patches/series
+
+diff --git a/debian/patches/0001-Lower-requirements-on-setuptools.diff b/debian/patches/0001-Lower-requirements-on-setuptools.diff
+new file mode 100644
+index 0000000..257c054
+--- /dev/null
++++ b/debian/patches/0001-Lower-requirements-on-setuptools.diff
+@@ -0,0 +1,13 @@
++diff --git a/setup.cfg b/setup.cfg
++index 77976c4..8857d32 100644
++--- a/setup.cfg
+++++ b/setup.cfg
++@@ -65,7 +65,7 @@ classifiers =
++ 	Topic :: Utilities
++ 
++ [options]
++-setup_requires = setuptools>=42; wheel; setuptools_scm[toml]>=3.4
+++setup_requires = setuptools>=40; setuptools_scm>=3.2
++ install_requires = 
++ 	argparse; "3.0" <= python_version and python_version < "3.2"
++ python_requires = >=3.2
+diff --git a/debian/patches/series b/debian/patches/series
+new file mode 100644
+index 0000000..804951a
+--- /dev/null
++++ b/debian/patches/series
+@@ -0,0 +1 @@
++0001-Lower-requirements-on-setuptools.diff
+-- 
+2.34.1
diff --git a/recipes-python/shtab/files/rules b/recipes-python/shtab/files/rules
deleted file mode 100755
index 2dd07b2..0000000
--- a/recipes-python/shtab/files/rules
+++ /dev/null
@@ -1,21 +0,0 @@
-#!/usr/bin/make -f
-#
-# Copyright (c) Siemens AG, 2022
-#
-# Authors:
-#  Felix Moessbauer <felix.moessbauer@siemens.com>
-#
-# This file is subject to the terms and conditions of the MIT License.
-# See COPYING.MIT file in the top-level directory.
-#
-
-export DH_VERBOSE=1
-export PYBUILD_VERBOSE=1
-export PYBUILD_NAME=shtab
-
-ifneq ($(filter nocheck,$(DEB_BUILD_PROFILES)),)
-export PYBUILD_DISABLE=test
-endif
-
-%:
-	dh $@ --with python3 --buildsystem=pybuild
diff --git a/recipes-python/shtab/python3-shtab_1.4.2.bb b/recipes-python/shtab/python3-shtab_1.4.2.bb
deleted file mode 100644
index d03e694..0000000
--- a/recipes-python/shtab/python3-shtab_1.4.2.bb
+++ /dev/null
@@ -1,36 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2022
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-inherit dpkg
-
-SRC_URI = " \
-    https://github.com/iterative/shtab/archive/refs/tags/v1.4.2.tar.gz;downloadfilename=${PN}-${PV}.tar.gz \
-    file://0001-Lower-requirements-on-setuptools.patch \
-    file://rules \
-    "
-SRC_URI[sha256sum] = "5e6ef745c223ef1a01a2db491a8ec5c02c8291067328b17695c9a44f5b7d6fe6"
-
-S = "${WORKDIR}/shtab-${PV}"
-
-DEBIAN_BUILD_DEPENDS = " \
-    dh-python, \
-    libpython3-all-dev, \
-    python3-all-dev:any, \
-    python3-setuptools, \
-    python3-setuptools-scm:native, \
-    "
-
-DEB_BUILD_PROFILES = "nocheck"
-
-do_prepare_build[cleandirs] += "${S}/debian"
-do_prepare_build() {
-    deb_debianize
-}
diff --git a/recipes-python/shtab/python3-shtab_1.5.5-3.bb b/recipes-python/shtab/python3-shtab_1.5.5-3.bb
new file mode 100644
index 0000000..9d2b1f2
--- /dev/null
+++ b/recipes-python/shtab/python3-shtab_1.5.5-3.bb
@@ -0,0 +1,31 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022-2023
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg-gbp
+
+SRC_URI += " \
+    git://salsa.debian.org/python-team/packages/python-shtab.git;protocol=https;branch=main \
+    "
+# modify for debian bullseye build
+SRC_URI:append:bullseye = " file://0001-debian-control-Fix-cross-build-issue-for-bullseye-im.patch"
+
+# modify for debian buster build
+SRC_URI:append:buster = " \
+                        file://0002-Lower-requirements-on-setuptools.patch \
+                        file://0003-Lower-requirements-on-setuptools.patch"
+
+SRCREV ="5650535ae4a1d34a21b55dc61e3e891d87a9712f"
+
+# We don't have pristine-tar in this tree hence use this option
+GBP_EXTRA_OPTIONS = "--git-no-pristine-tar"
+
+DEB_BUILD_PROFILES = "nocheck"
+DEB_BUILD_OPTIONS = "nocheck"
-- 
2.34.1


