Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0388CC77B7D
	for <webhook@archiver.kernel.org>; Mon, 15 May 2023 11:24:42 +0000 (UTC)
Received: from esa1.mentor.iphmx.com (esa1.mentor.iphmx.com [68.232.129.153])
 by mx.groups.io with SMTP id smtpd.web10.86150.1684149875764840263
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 May 2023 04:24:35 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.129.153, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="6036674"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa1.mentor.iphmx.com with ESMTP; 15 May 2023 03:24:35 -0800
IronPort-SDR: 62ghkXsdlrKy56SGhI85uYTWdnQwSV60tBIv2hwkvnRKNr79JPidNQgnA61YUcvOicF3lG5d03
 uxQ0O5LS2mLWXn4MaWUOc7mEiB3rwMiBgDK8vL/5O2l62JTgVZTEgEM52nPUCrzjFwamu3qmei
 qXtLGcvmIIsGbzuduiny+BiLn0qIl4zc109B5C8ib1Ow1ayGclXUUKhF4i9F6s6dTxWMI+w8RA
 QMuz5LXx7XlSJK+vlMtWZDGn49bCrJN8HgsO3KICLd+cSEH8QIRzp0GY+mt2ETWmHtaVqFQoEF
 00w=
From: Srinuvasan Arjunan <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH v2] recipes-python/shtab: Update shelltab to latest one
Date: Mon, 15 May 2023 16:54:16 +0530
Message-ID: <20230515112416.754793-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d931f5de-fc4c-c26f-5ada-fdee1607c5ca@siemens.com>
References: <d931f5de-fc4c-c26f-5ada-fdee1607c5ca@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-14.mgc.mentorg.com (147.34.90.214) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 May 2023 11:24:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11451

From: Srinuvasan A <srinuvasan.a@siemens.com>

Update shelltab to latest one.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 ...001-Lower-requirements-on-setuptools.patch | 46 +++++++++++--------
 ...002-Lower-requirements-on-setuptools.patch | 44 ++++++++++++++++++
 recipes-python/shtab/files/rules              | 21 ---------
 recipes-python/shtab/python3-shtab_1.4.2.bb   | 36 ---------------
 recipes-python/shtab/python3-shtab_1.5.5-3.bb | 29 ++++++++++++
 5 files changed, 99 insertions(+), 77 deletions(-)
 create mode 100644 recipes-python/shtab/files/0002-Lower-requirements-on-setuptools.patch
 delete mode 100755 recipes-python/shtab/files/rules
 delete mode 100644 recipes-python/shtab/python3-shtab_1.4.2.bb
 create mode 100644 recipes-python/shtab/python3-shtab_1.5.5-3.bb

diff --git a/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch b/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch
index dccc2dd..07c83c5 100644
--- a/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch
+++ b/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch
@@ -1,28 +1,34 @@
-From d347695c4b173c94c4d8a678a67947de3ee5f186 Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Mon, 14 Mar 2022 08:17:00 +0100
+From 0fdef77abad09ad4e1ee35abd390dacdcabf9efc Mon Sep 17 00:00:00 2001
+From: Srinuvasan A <srinuvasan.a@siemens.com>
+Date: Mon, 15 May 2023 16:35:43 +0530
 Subject: [PATCH] Lower requirements on setuptools
 
-Allows to build against Debian buster.
+Allows to build against Debian buster and fix cross build issues.
 
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
 ---
- setup.cfg | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
+ debian/control | 6 ++----
+ 1 file changed, 2 insertions(+), 4 deletions(-)
 
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
+diff --git a/debian/control b/debian/control
+index a63e366..3d24b41 100644
+--- a/debian/control
++++ b/debian/control
+@@ -5,12 +5,10 @@ Maintainer: Debian Python Team <team+python@tracker.debian.org>
+ Uploaders: Felix Moessbauer <felix.moessbauer@siemens.com>
+ Build-Depends: debhelper-compat (= 13),
+  dh-python,
+- python3-setuptools (>=42),
+- python3-setuptools-scm:native (>=3.4),
+  libpython3-all-dev (>=3.2),
++ python3-setuptools (>=40),
++ python3-setuptools-scm:native (>=3.2),
+  python3-all-dev:any (>=3.2),
+- python3-wheel:native,
+- python3-toml:native,
+  python3-pytest <!nocheck>,
+  python3-pytest-cov <!nocheck>,
+  python3-pytest-timeout <!nocheck>,
 -- 
 2.34.1
 
diff --git a/recipes-python/shtab/files/0002-Lower-requirements-on-setuptools.patch b/recipes-python/shtab/files/0002-Lower-requirements-on-setuptools.patch
new file mode 100644
index 0000000..5f048e0
--- /dev/null
+++ b/recipes-python/shtab/files/0002-Lower-requirements-on-setuptools.patch
@@ -0,0 +1,44 @@
+From 62c6019bb5bf724cc92f9f1c1fee378e325d3162 Mon Sep 17 00:00:00 2001
+From: Srinuvasan A <srinuvasan.a@siemens.com>
+Date: Mon, 15 May 2023 16:29:00 +0530
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
+
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
index 0000000..d3e958c
--- /dev/null
+++ b/recipes-python/shtab/python3-shtab_1.5.5-3.bb
@@ -0,0 +1,29 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022-2023
+#
+# Authors:
+# Jan Kiszka <jan.kiszka@...>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg-gbp
+
+SRC_URI += " \
+ git://salsa.debian.org/python-team/packages/python-shtab.git;protocol=https;branch=main \
+ "
+
+# modify for debian buster build
+SRC_URI:append:buster = " \
+ file://0001-Lower-requirements-on-setuptools.patch \
+ file://0002-Lower-requirements-on-setuptools.patch"
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


