Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0002C678D4
	for <webhook@archiver.kernel.org>; Mon,  6 Mar 2023 11:24:53 +0000 (UTC)
Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
 by mx.groups.io with SMTP id smtpd.web11.30925.1678101887296458821
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Mar 2023 03:24:47 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.141.98, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="100474690"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa2.mentor.iphmx.com with ESMTP; 06 Mar 2023 03:24:46 -0800
IronPort-SDR: 5PJYmQeNU4zGTb968M7pYcz5pwekAG+6xBoeYwxgVJhdsbXQ+KC8UbafXRKnVWcFCZzuupKQFi
 XF+4GdNjlKgjNleVoIdh5ylo38UaFODcbUOt1ne96Nz6y6QZDYJ11f7M5NahrL/PuD0aQj0EkC
 WcukT1+sFNHGn6a6jP9tpjJ7+VGVa4i6p+EalPwqHSUi2fIhG6NgEPEJs6S0jSKvcv/RhEdZl4
 ClbUSQSt5shWo6ryl3eBc3cgW6OQmNCk/pR7dKg/vcGqbtKousCFNlFdH59j9W8lDJ7P2Njrx4
 xHs=
From: Srinuvasan A <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] ebg-secure-boot-snakeoil: drop space in remove override
Date: Mon, 6 Mar 2023 16:54:29 +0530
Message-ID: <20230306112429.3476447-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-11.mgc.mentorg.com (147.34.90.211) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Mar 2023 11:24:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10934

From: Srinuvasan A <srinuvasan.a@siemens.com>

remove does not need leading spaces in front of the package,
hence drop this one.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 doc/README.secureboot.md             | 2 +-
 kas/opt/ebg-secure-boot-snakeoil.yml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 54d67c7..bc238fb 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -154,7 +154,7 @@ local_conf_header:
     WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
     INITRAMFS_INSTALL:append = " initramfs-verity-hook"
     # abrootfs cannot be installed together with verity
-    INITRAMFS_INSTALL:remove = " initramfs-abrootfs-hook"
+    INITRAMFS_INSTALL:remove = "initramfs-abrootfs-hook"
 
 local_conf_header:
   secure-boot: |
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index 3d0e3c9..f787c82 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -22,7 +22,7 @@ local_conf_header:
     WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
     INITRAMFS_INSTALL:append = " initramfs-verity-hook"
     # abrootfs cannot be installed together with verity
-    INITRAMFS_INSTALL:remove = " initramfs-abrootfs-hook"
+    INITRAMFS_INSTALL:remove = "initramfs-abrootfs-hook"
 
   secure-boot: |
     IMAGER_BUILD_DEPS += "ebg-secure-boot-signer"
-- 
2.34.1


