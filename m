Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15835C38142
	for <webhook@archiver.kernel.org>; Mon, 23 Jan 2023 07:11:18 +0000 (UTC)
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by mx.groups.io with SMTP id smtpd.web11.37577.1674457867905660906
 for <cip-dev@lists.cip-project.org>;
 Sun, 22 Jan 2023 23:11:08 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.137.180, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="94249903"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 22 Jan 2023 23:11:05 -0800
IronPort-SDR: IRW6dhQmtR3YV7z1AUdbnyi+DcZVXJc77u2MsEEYeyYT+9fsjOUf7jxonnHXiKUrsZXJnEqNJd
 jjh09WoQb5ml92yyFg0Sao5rE3LqoA6MczXBDIX1NTAIEujdqLYhpLTO8qyAUgDrCl+B+y2MRz
 OwBSwZ+fYWs8qmCHWDX3a8qOut/ixtxbszlgGKdhPOncYbotYbTv32R0ME5mFJZxio4GlpHa6y
 oset+Elq4nijMo7zYuZs2c2OzQliRUAPQj+2MMUMJub7jPhjL18LXquxfdI/8hCUG37iKm0zdS
 DMA=
From: Srinuvasan A <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update cip-kernels to latest one
Date: Mon, 23 Jan 2023 12:40:33 +0530
Message-ID: <20230123071033.2859114-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jan 2023 07:11:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10459

From: Srinuvasan A <srinuvasan.a@siemens.com>

Update cip-kernels to latest one.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 ....265-cip85-rt27.bb => linux-cip-rt_4.19.269-cip88-rt28.bb} | 4 ++--
 ...inux-cip_4.19.269-cip88.bb => linux-cip_4.19.270-cip89.bb} | 4 ++--
 ...inux-cip_5.10.161-cip23.bb => linux-cip_5.10.162-cip24.bb} | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.265-cip85-rt27.bb => linux-cip-rt_4.19.269-cip88-rt28.bb} (60%)
 rename recipes-kernel/linux/{linux-cip_4.19.269-cip88.bb => linux-cip_4.19.270-cip89.bb} (60%)
 rename recipes-kernel/linux/{linux-cip_5.10.161-cip23.bb => linux-cip_5.10.162-cip24.bb} (60%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.265-cip85-rt27.bb b/recipes-kernel/linux/linux-cip-rt_4.19.269-cip88-rt28.bb
similarity index 60%
rename from recipes-kernel/linux/linux-cip-rt_4.19.265-cip85-rt27.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.269-cip88-rt28.bb
index 3747cf2..9ea66f5 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.265-cip85-rt27.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.269-cip88-rt28.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019 - 2022
+# Copyright (c) Siemens AG, 2019 - 2023
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "5d93f08f6a4371e90eced62207a14e58c3751b3acbfdf76f20bbf237f12dd547"
+SRC_URI[sha256sum] = "da6d67e1de1bf314d0938ec2f2a87b91128a1df6a12262e649933078b36d7c23"
diff --git a/recipes-kernel/linux/linux-cip_4.19.269-cip88.bb b/recipes-kernel/linux/linux-cip_4.19.270-cip89.bb
similarity index 60%
rename from recipes-kernel/linux/linux-cip_4.19.269-cip88.bb
rename to recipes-kernel/linux/linux-cip_4.19.270-cip89.bb
index 8957c37..ca64a76 100644
--- a/recipes-kernel/linux/linux-cip_4.19.269-cip88.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.270-cip89.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019-2022
+# Copyright (c) Siemens AG, 2019-2023
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "45280ef125d1a4dcd7a94b5ae66e4401d999abedf7f8bf9be9ff8e22ff42b192"
+SRC_URI[sha256sum] = "e91ca34303d01ed9e366f4d0a171f96eef61242623e20bf3e175a8ce10f0a386"
diff --git a/recipes-kernel/linux/linux-cip_5.10.161-cip23.bb b/recipes-kernel/linux/linux-cip_5.10.162-cip24.bb
similarity index 60%
rename from recipes-kernel/linux/linux-cip_5.10.161-cip23.bb
rename to recipes-kernel/linux/linux-cip_5.10.162-cip24.bb
index 81c39da..566caf6 100644
--- a/recipes-kernel/linux/linux-cip_5.10.161-cip23.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.162-cip24.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021-2022
+# Copyright (c) Siemens AG, 2021-2023
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "a622173fa0a2104b1c3aa51012cb32a1c3eede559b7b6026106de287a46003c8"
+SRC_URI[sha256sum] = "fb0edc3c18e47d2b6974cb0880a0afb5c3fa08f50ee87dfdf24349405ea5f8ae"
-- 
2.34.1


