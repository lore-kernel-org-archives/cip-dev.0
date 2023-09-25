Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D342CE7AA8
	for <webhook@archiver.kernel.org>; Mon, 25 Sep 2023 16:58:44 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.66332.1695661119691122037
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 Sep 2023 09:58:39 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 38PGwbxi4033810; Tue, 26 Sep 2023 01:58:37 +0900
X-Iguazu-Qid: 2rWgDRdQ1jgX6Hc16g
X-Iguazu-QSIG: v=2; s=0; t=1695661116; q=2rWgDRdQ1jgX6Hc16g; m=tffQq5bZEEmNVRsZy4kkWEfx6tLb1YnSWM/mw3Dyk4s=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 38PGwZs73964790
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 26 Sep 2023 01:58:36 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 2/2] images: Add dosfstools as DEPENDENCY to all images
Date: Mon, 25 Sep 2023 22:28:33 +0530
X-TSB-HOP2: ON
Message-Id: <20230925165833.2696-3-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <51a07da1-b0a1-4a3b-b463-739e3ea208f2@siemens.com>
References: <51a07da1-b0a1-4a3b-b463-739e3ea208f2@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 25 Sep 2023 16:58:32.0607 (UTC) FILETIME=[84020AF0:01D9EFD1]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Sep 2023 16:58:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13221

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 recipes-core/images/cip-core-image-kernelci.bb |  1 +
 recipes-core/images/cip-core-image-security.bb |  1 +
 recipes-core/images/cip-core-image.bb          |  1 +
 recipes-core/images/common-image.inc           | 13 +++++++++++++
 4 files changed, 16 insertions(+)
 create mode 100644 recipes-core/images/common-image.inc

diff --git a/recipes-core/images/cip-core-image-kernelci.bb b/recipes-core/images/cip-core-image-kernelci.bb
index 479c14c..8a58e7b 100644
--- a/recipes-core/images/cip-core-image-kernelci.bb
+++ b/recipes-core/images/cip-core-image-kernelci.bb
@@ -10,6 +10,7 @@
 #
 
 inherit image
+require common-image.inc
 
 DESCRIPTION = "CIP Core image for KernelCI"
 
diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
index 3421ce5..f114974 100644
--- a/recipes-core/images/cip-core-image-security.bb
+++ b/recipes-core/images/cip-core-image-security.bb
@@ -10,6 +10,7 @@
 #
 
 inherit image
+require common-image.inc
 
 DESCRIPTION = "CIP Core image including security packages"
 
diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
index 0ec7220..711d3d3 100644
--- a/recipes-core/images/cip-core-image.bb
+++ b/recipes-core/images/cip-core-image.bb
@@ -10,6 +10,7 @@
 #
 
 inherit image
+require common-image.inc
 
 ISAR_RELEASE_CMD = "git -C ${LAYERDIR_cip-core} describe --tags --dirty --always --match 'v[0-9].[0-9]*'"
 DESCRIPTION = "CIP Core image"
diff --git a/recipes-core/images/common-image.inc b/recipes-core/images/common-image.inc
new file mode 100644
index 0000000..863f817
--- /dev/null
+++ b/recipes-core/images/common-image.inc
@@ -0,0 +1,13 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Toshiba Corporation 2023
+#
+# Authors:
+#  Venkata Pyla <venkata.pyla@toshiba-tsip.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+# Install in build system for creating reproducible DOS filesystems
+DEPENDS += "dosfstools"
-- 
2.20.1



