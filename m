Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304F7EB64D9
	for <webhook@archiver.kernel.org>; Mon, 10 Jul 2023 12:28:20 +0000 (UTC)
Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
 by mx.groups.io with SMTP id smtpd.web11.38102.1688992098108927097
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jul 2023 05:28:18 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.141.98, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="6.01,194,1684828800"; 
   d="scan'208";a="12758558"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa2.mentor.iphmx.com with ESMTP; 10 Jul 2023 04:28:17 -0800
IronPort-SDR: p/FzJZADew0sIf1ZZvLPDnCYuf1q0vr8oxfNP5psljSoMTcM0S9a3Wq1tP2eUW97KWq0oyCov2
 a9jn3dna870pI1aIoXknVrliaVc3EFVxIEvKTdSob4GHlZCjfa+h+yt4FpwX7s1yVo9G2DUtPw
 3IDEKIqG43NcvNvWu/X05i+4ngmYpGN8FHAXOjzXzOHZazhF3uDxt44Hzo9l+zyOi2HmAqLf29
 nIP1KpOkDybkCts1vyd0J75qNDCaj9Ku8+zbVvlF+oqj2MyYesTMEptvnKBHEU5aZnywpPxZXF
 tqU=
From: Srinuvasan Arjunan <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] recipes-python/shtab: Update shelltab to latest one
Date: Mon, 10 Jul 2023 17:57:56 +0530
Message-ID: <20230710122756.3741741-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-15.mgc.mentorg.com (147.34.90.215) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jul 2023 12:28:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12294

From: Srinuvasan A <srinuvasan.a@siemens.com>

Update shelltab to latest one.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 ...001-Lower-requirements-on-setuptools.patch | 79 ++++++++++++++-----
 recipes-python/shtab/files/rules              | 21 -----
 recipes-python/shtab/python3-shtab_1.4.2.bb   | 36 ---------
 recipes-python/shtab/python3-shtab_1.5.5-4.bb | 28 +++++++
 4 files changed, 87 insertions(+), 77 deletions(-)
 delete mode 100755 recipes-python/shtab/files/rules
 delete mode 100644 recipes-python/shtab/python3-shtab_1.4.2.bb
 create mode 100644 recipes-python/shtab/python3-shtab_1.5.5-4.bb

diff --git a/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch b/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch
index dccc2dd..5709f20 100644
--- a/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch
+++ b/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch
@@ -1,28 +1,67 @@
-From d347695c4b173c94c4d8a678a67947de3ee5f186 Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Mon, 14 Mar 2022 08:17:00 +0100
+From 11b752a0f3e58f847caa74cf3a00acbe6853239a Mon Sep 17 00:00:00 2001
+From: Srinuvasan A <srinuvasan.a@siemens.com>
+Date: Mon, 10 Jul 2023 16:39:57 +0530
 Subject: [PATCH] Lower requirements on setuptools
 
-Allows to build against Debian buster.
+Allows to build against Debian buster and fix cross build issues.
 
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
 ---
- setup.cfg | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
+ debian/control                                      |  8 +++-----
+ .../0001-Lower-requirements-on-setuptools.diff      | 13 +++++++++++++
+ debian/patches/series                               |  1 +
+ 3 files changed, 17 insertions(+), 5 deletions(-)
+ create mode 100644 debian/patches/0001-Lower-requirements-on-setuptools.diff
+ create mode 100644 debian/patches/series
 
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
+index 523ffee..cdb8181 100644
+--- a/debian/control
++++ b/debian/control
+@@ -3,14 +3,12 @@ Section: python
+ Priority: optional
+ Maintainer: Debian Python Team <team+python@tracker.debian.org>
+ Uploaders: Felix Moessbauer <felix.moessbauer@siemens.com>
+-Build-Depends: debhelper-compat (= 13),
++Build-Depends: debhelper-compat (= 12),
+  dh-python,
+- python3-setuptools (>=42),
+- python3-setuptools-scm:native (>=3.4),
++ python3-setuptools (>=40),
++ python3-setuptools-scm:native (>=3.2),
+  libpython3-all-dev (>=3.2),
+  python3-all-dev:any (>=3.2),
+- python3-wheel:native,
+- python3-toml:native,
+  python3-pytest <!nocheck>,
+  python3-pytest-cov <!nocheck>,
+  python3-pytest-timeout <!nocheck>,
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
 -- 
 2.34.1
 
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
diff --git a/recipes-python/shtab/python3-shtab_1.5.5-4.bb b/recipes-python/shtab/python3-shtab_1.5.5-4.bb
new file mode 100644
index 0000000..1094c1f
--- /dev/null
+++ b/recipes-python/shtab/python3-shtab_1.5.5-4.bb
@@ -0,0 +1,28 @@
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
+ file://0001-Lower-requirements-on-setuptools.patch"
+
+SRCREV ="8db4615b2c3ee0a9332b6030687e1179fcfc8670"
+
+# We don't have pristine-tar in this tree hence use this option
+GBP_EXTRA_OPTIONS = "--git-no-pristine-tar"
+
+DEB_BUILD_PROFILES = "nocheck"
+DEB_BUILD_OPTIONS = "nocheck"
-- 
2.34.1


