Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCBBC77B7A
	for <webhook@archiver.kernel.org>; Wed, 17 May 2023 10:23:19 +0000 (UTC)
Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
 by mx.groups.io with SMTP id smtpd.web11.45801.1684318997196007435
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 May 2023 03:23:17 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.141.98, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="6275016"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa2.mentor.iphmx.com with ESMTP; 17 May 2023 02:23:16 -0800
IronPort-SDR: RZgdehWqHWNT04PIiUs7IPe2XPv4ICjknVJEOgfJK3NIElhKUNDU0VZu62areGL0DDrrHp5RT/
 GoF3WBjkRg98bHcvXPgCgfEBxmfe1kTmcCBkD5HAXUHj8TR2e4msi6ajFsIXfs4ie796asCETN
 Y/w2w6gm2J5EtFPJVLwKl7rpbtQhDQQMTD5Lis903GQQ2+nxzuxz0GYnId/qsKmLzDf+qaEF6y
 YW65jK0YRDsNFWtrDywxsGqXyJ2IWHhT3gOCyuILifjUmWBXiSjLLSJSOXbeZvAZwwH3m2r8C4
 PUY=
From: Srinuvasan Arjunan <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] kas/opt/6.1-mainline: use KERNEL_DEFCONFIG from cip-kernel-config
Date: Wed, 17 May 2023 15:52:56 +0530
Message-ID: <20230517102256.1511870-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 May 2023 10:23:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11487

From: Srinuvasan A <srinuvasan.a@siemens.com>

Presently 6.1 mainline kernel uses it's internal configuration, now cip
provides the defconfig for 6.1 LTS, hence use that one, this config
already conatins the CONFIG_SQUASHFS, so remove this one from recipe.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 kas/opt/6.1-mainline.yml                      | 1 -
 recipes-kernel/linux/files/squashfs.cfg       | 1 -
 recipes-kernel/linux/linux-mainline_6.1.15.bb | 3 +--
 3 files changed, 1 insertion(+), 4 deletions(-)
 delete mode 100644 recipes-kernel/linux/files/squashfs.cfg

diff --git a/kas/opt/6.1-mainline.yml b/kas/opt/6.1-mainline.yml
index 84d12b0..0dcf336 100644
--- a/kas/opt/6.1-mainline.yml
+++ b/kas/opt/6.1-mainline.yml
@@ -14,5 +14,4 @@ header:
 
 local_conf_header:
   kernel-version: |
-    KERNEL_DEFCONFIG = ""
     KERNEL_NAME = "mainline"
diff --git a/recipes-kernel/linux/files/squashfs.cfg b/recipes-kernel/linux/files/squashfs.cfg
deleted file mode 100644
index 7a89d00..0000000
--- a/recipes-kernel/linux/files/squashfs.cfg
+++ /dev/null
@@ -1 +0,0 @@
-CONFIG_SQUASHFS=y
diff --git a/recipes-kernel/linux/linux-mainline_6.1.15.bb b/recipes-kernel/linux/linux-mainline_6.1.15.bb
index 690f6dd..9b45f28 100644
--- a/recipes-kernel/linux/linux-mainline_6.1.15.bb
+++ b/recipes-kernel/linux/linux-mainline_6.1.15.bb
@@ -12,8 +12,7 @@ ARCHIVE_VERSION = "${@ d.getVar('PV')[:-2] if d.getVar('PV').endswith('.0') else
 KERNEL_DEFCONFIG_VERSION ?= "6.1.y-cip"
 
 SRC_URI += " \
-    https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-${ARCHIVE_VERSION}.tar.xz \
-    file://squashfs.cfg"
+    https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-${ARCHIVE_VERSION}.tar.xz"
 
 SRC_URI[sha256sum] = "2c16dfe2168a2e64ac0d55a12d625ebfb963818bb48b60c1868c7c460644c4fd"
 
-- 
2.34.1


