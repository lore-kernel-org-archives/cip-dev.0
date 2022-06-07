Return-Path: <Vijaikumar_Kanagarajan@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60547C43334
	for <webhook@archiver.kernel.org>; Tue,  7 Jun 2022 13:51:01 +0000 (UTC)
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by mx.groups.io with SMTP id smtpd.web12.12755.1654609849668491510
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jun 2022 06:50:54 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.137.180, mailfrom: vijaikumar_kanagarajan@mentor.com)
X-IronPort-AV: E=Sophos;i="5.91,284,1647331200";
   d="scan'208";a="76783578"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 07 Jun 2022 05:50:53 -0800
IronPort-SDR: 
 R5cVJcjq9nkmRwJzpO+dJMqA+XDF5RPfJlYYZDX9qgy35DmBS/i7Kvh7VkKFqrrQo1L1YefMZh
 XHLDN1jdXzMtQuI0DCMvzrq5LNSZFlXLfGv7YaTROynqg0jd70SFW2ZDjSvJpbqfiTsFja2UJi
 ZmlWee88kjgvH0Cx5lY5v4I0Jnfbfd9Ewg1XEwZ5g87AuWE2AH1GZEv3sSBsTolu7oi7rYmlUv
 fkncG2ac1CpqFAxLZIeKDrp3+LB9TtPnc/ZbDCKSCNa3yCtCFqVsqnQiPmmES2HLsE8mv8+DpL
 AIM=
From: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
To: <jan.kiszka@siemens.com>, <quirin.gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
CC: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
Subject: [isar-cip-core][PATCH 2/3] recipes-core/ltp: refactor ltp recipe
Date: Tue, 7 Jun 2022 19:20:15 +0530
Message-ID: <20220607135016.1856603-3-Vijaikumar_Kanagarajan@mentor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220607135016.1856603-1-Vijaikumar_Kanagarajan@mentor.com>
References: <20220607135016.1856603-1-Vijaikumar_Kanagarajan@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-15.mgc.mentorg.com (147.34.90.215) To
 svr-orw-mbx-12.mgc.mentorg.com (147.34.90.212)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Jun 2022 13:51:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8510

Add ltp.inc file so that downstream users can build their own ltp version
using bits from isar-cip-core.

Signed-off-by: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
---
 recipes-core/ltp/ltp-full_20220527.bb | 17 ++---------------
 recipes-core/ltp/ltp.inc              | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 15 deletions(-)
 create mode 100644 recipes-core/ltp/ltp.inc

diff --git a/recipes-core/ltp/ltp-full_20220527.bb b/recipes-core/ltp/ltp-full_20220527.bb
index 5b40df1..a99f301 100644
--- a/recipes-core/ltp/ltp-full_20220527.bb
+++ b/recipes-core/ltp/ltp-full_20220527.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2020
+# Copyright (c) Siemens AG, 2022
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -9,19 +9,6 @@
 # SPDX-License-Identifier: MIT
 #
 
-inherit dpkg
+require recipes-core/ltp/ltp.inc
 
-DESCRIPTION = "Linux Test project for CIP"
-
-SRC_URI = " \
-   https://github.com/linux-test-project/ltp/releases/download/${PV}/ltp-full-${PV}.tar.xz \
-   file://debian \
-   "
 SRC_URI[sha256sum] = "d635afb5ec7b0de763ab50713baf9fbf65cf089da6e6768f816e4a166cbd17c4"
-
-
-do_prepare_build() {
-        cp -R ${WORKDIR}/debian ${S}
-        deb_create_compat
-        deb_add_changelog
-}
diff --git a/recipes-core/ltp/ltp.inc b/recipes-core/ltp/ltp.inc
new file mode 100644
index 0000000..d3350cb
--- /dev/null
+++ b/recipes-core/ltp/ltp.inc
@@ -0,0 +1,25 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg
+
+DESCRIPTION = "Linux Test project for CIP"
+
+SRC_URI = " \
+   https://github.com/linux-test-project/ltp/releases/download/${PV}/ltp-full-${PV}.tar.xz \
+   file://debian \
+   "
+
+do_prepare_build() {
+        cp -R ${WORKDIR}/debian ${S}
+        deb_create_compat
+        deb_add_changelog
+}
-- 
2.25.1


