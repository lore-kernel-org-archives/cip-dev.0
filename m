Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4AFC433FE
	for <webhook@archiver.kernel.org>; Wed, 26 Oct 2022 08:57:02 +0000 (UTC)
Received: from esa4.mentor.iphmx.com (esa4.mentor.iphmx.com [68.232.137.252])
 by mx.groups.io with SMTP id smtpd.web08.5406.1666774617995112666
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Oct 2022 01:56:58 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.137.252, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="5.95,214,1661846400"; 
   d="scan'208";a="85422393"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa4.mentor.iphmx.com with ESMTP; 26 Oct 2022 00:56:54 -0800
IronPort-SDR: 65IEbAX++pGByfYx3exm40oY86vNFfYVnkVVz09M4AsOm6WUB7AP+An7WCQK6C0/tyu1y4E2ig
 f6uMhXyEWaiMDnVP+KISPNzDW0WdMOTWY2U3YtIevWTtXPibcQZr36j6eu8tYjInyWdf9QlzAk
 tRKnOSRw+g2zAkWTY6yyUoVY1AzdT4bnPolas2eFOPowK3dvfYAPaR0gDwPkBONFYsITGFEeri
 82PCN8LfYPjy8MuNNJFZjdpcvKqp6YkJH5zxTmrQkycDjpVAxy8TJiNfiK83sv6nf0BSP3Yuuv
 Fs4=
From: Srinuvasan A <Srinuvasan_A@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan_a@mentor.com>
Subject: [isar-cip-core][PATCH] shtab: Update shell tab to latest one
Date: Wed, 26 Oct 2022 14:26:33 +0530
Message-ID: <20221026085633.516519-1-Srinuvasan_A@mentor.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-10.mgc.mentorg.com (147.34.90.210) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Oct 2022 08:57:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9846

From: Srinuvasan A <srinuvasan_a@mentor.com>

Bump shell tab tag to 1.5.5, created a patch file to build
against debian buster and added required dependency packages.

Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
---
 ...001-Lower-requirements-on-setuptools.patch | 22 +++++++++----------
 ...-shtab_1.4.2.bb => python3-shtab_1.5.5.bb} | 10 ++++++---
 2 files changed, 18 insertions(+), 14 deletions(-)
 rename recipes-python/shtab/{python3-shtab_1.4.2.bb => python3-shtab_1.5.5.bb} (63%)

diff --git a/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch b/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch
index dccc2dd..ba8c1bd 100644
--- a/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch
+++ b/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch
@@ -1,28 +1,28 @@
-From d347695c4b173c94c4d8a678a67947de3ee5f186 Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Mon, 14 Mar 2022 08:17:00 +0100
+From faf4d157f563ee44636c1cc4ef1be73bd7264382 Mon Sep 17 00:00:00 2001
+From: Srinuvasan A <srinuvasan_a@mentor.com>
+Date: Wed, 26 Oct 2022 12:32:57 +0530
 Subject: [PATCH] Lower requirements on setuptools
 
 Allows to build against Debian buster.
 
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
 ---
  setup.cfg | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/setup.cfg b/setup.cfg
-index 55eecd4..186aad6 100644
+index 6fcff23..5562b88 100644
 --- a/setup.cfg
 +++ b/setup.cfg
-@@ -66,7 +66,7 @@ classifiers=
+@@ -64,7 +64,7 @@ classifiers=
      Topic :: Terminals
      Topic :: Utilities
  [options]
--setup_requires=setuptools>=42; setuptools_scm[toml]>=3.4
-+setup_requires=setuptools>=40; setuptools_scm>=3.2
+-setup_requires=setuptools>=42; wheel; setuptools_scm[toml]>=3.4
++setup_requires=setuptools>=40; wheel; setuptools_scm>=3.2
  install_requires=
-     argparse; python_version < "2.7" or ("3.0" <= python_version and python_version < "3.2")
- python_requires= >=2.7, !=3.0.*, !=3.1.*
+     argparse; "3.0" <= python_version and python_version < "3.2"
+ python_requires=>=3.2
 -- 
-2.34.1
+2.25.1
 
diff --git a/recipes-python/shtab/python3-shtab_1.4.2.bb b/recipes-python/shtab/python3-shtab_1.5.5.bb
similarity index 63%
rename from recipes-python/shtab/python3-shtab_1.4.2.bb
rename to recipes-python/shtab/python3-shtab_1.5.5.bb
index d03e694..625dd6f 100644
--- a/recipes-python/shtab/python3-shtab_1.4.2.bb
+++ b/recipes-python/shtab/python3-shtab_1.5.5.bb
@@ -12,11 +12,13 @@
 inherit dpkg
 
 SRC_URI = " \
-    https://github.com/iterative/shtab/archive/refs/tags/v1.4.2.tar.gz;downloadfilename=${PN}-${PV}.tar.gz \
-    file://0001-Lower-requirements-on-setuptools.patch \
+    https://github.com/iterative/shtab/archive/refs/tags/v1.5.5.tar.gz;downloadfilename=${PN}-${PV}.tar.gz \
     file://rules \
     "
-SRC_URI[sha256sum] = "5e6ef745c223ef1a01a2db491a8ec5c02c8291067328b17695c9a44f5b7d6fe6"
+# modify for debian buster build
+SRC_URI_append_buster = " file://0001-Lower-requirements-on-setuptools.patch"
+
+SRC_URI[sha256sum] = "b8183c7ee95f28d2f9e17bbe040d5e58070e272f8a0db2f8a601917da8cf8e26"
 
 S = "${WORKDIR}/shtab-${PV}"
 
@@ -26,6 +28,8 @@ DEBIAN_BUILD_DEPENDS = " \
     python3-all-dev:any, \
     python3-setuptools, \
     python3-setuptools-scm:native, \
+    python3-wheel:native, \
+    python3-toml:native, \
     "
 
 DEB_BUILD_PROFILES = "nocheck"
-- 
2.25.1


