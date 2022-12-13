Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DBBC4332F
	for <webhook@archiver.kernel.org>; Tue, 13 Dec 2022 09:06:46 +0000 (UTC)
Received: from esa1.mentor.iphmx.com (esa1.mentor.iphmx.com [68.232.129.153])
 by mx.groups.io with SMTP id smtpd.web11.69156.1670922400131933678
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Dec 2022 01:06:40 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.129.153, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="5.96,240,1665475200"; 
   d="scan'208";a="92694132"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa1.mentor.iphmx.com with ESMTP; 13 Dec 2022 01:06:39 -0800
IronPort-SDR: EYI3fv7tAPPtoiZ3dOTf8VqGh4kC5NBA8uzKjKJ7MiJOX2sPB2FE+mzUr0/NDd0kBkhXnyOWxC
 ravUeOBbQCF6jMl9qdd6Fzj+fWcwaDeh3JjWndid//hLp0SH1HrXiNYnUNy4s5I4FTgaekCadM
 BnLwb7+v+GoJfFd/Hma5nM44Y2BYKAYiuzPqFSCfuxCHLUyjm/cokvUtMBI5uZpT/WdeaqY5dd
 QOsgvK3FfBbeWtDsTTqs7LoHXA1HvK/SvzKFoyDvABVc6W2VHyWjUESazDRZbye6Dnh0J3Mlb0
 ToM=
From: Srinuvasan A <Srinuvasan_A@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan_a@mentor.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update cip-kernels to latest one
Date: Tue, 13 Dec 2022 14:36:17 +0530
Message-ID: <20221213090617.401794-1-Srinuvasan_A@mentor.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-11.mgc.mentorg.com (147.34.90.211) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Dec 2022 09:06:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10211

From: Srinuvasan A <srinuvasan_a@mentor.com>

Update cip-kernels to latest one.

Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
---
 ....252-cip78-rt26.bb => linux-cip-rt_4.19.265-cip85-rt27.bb} | 4 ++--
 ...4.302-cip70-rt40.bb => linux-cip-rt_4.4.302-cip71-rt41.bb} | 2 +-
 ...10.153-cip19-rt8.bb => linux-cip-rt_5.10.158-cip22-rt9.bb} | 2 +-
 ...inux-cip_4.19.264-cip84.bb => linux-cip_4.19.268-cip87.bb} | 2 +-
 ...{linux-cip_4.4.302-cip70.bb => linux-cip_4.4.302-cip71.bb} | 4 ++--
 ...inux-cip_5.10.153-cip19.bb => linux-cip_5.10.158-cip22.bb} | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.252-cip78-rt26.bb => linux-cip-rt_4.19.265-cip85-rt27.bb} (60%)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip70-rt40.bb => linux-cip-rt_4.4.302-cip71-rt41.bb} (72%)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.153-cip19-rt8.bb => linux-cip-rt_5.10.158-cip22-rt9.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_4.19.264-cip84.bb => linux-cip_4.19.268-cip87.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip70.bb => linux-cip_4.4.302-cip71.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_5.10.153-cip19.bb => linux-cip_5.10.158-cip22.bb} (72%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.252-cip78-rt26.bb b/recipes-kernel/linux/linux-cip-rt_4.19.265-cip85-rt27.bb
similarity index 60%
rename from recipes-kernel/linux/linux-cip-rt_4.19.252-cip78-rt26.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.265-cip85-rt27.bb
index f27be73..3747cf2 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.252-cip78-rt26.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.265-cip85-rt27.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019 - 2021
+# Copyright (c) Siemens AG, 2019 - 2022
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "770db530cb68f0eb022757fde73774b7312d420fcfc3d86d906f37208bdbce2d"
+SRC_URI[sha256sum] = "5d93f08f6a4371e90eced62207a14e58c3751b3acbfdf76f20bbf237f12dd547"
diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip70-rt40.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip71-rt41.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip-rt_4.4.302-cip70-rt40.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip71-rt41.bb
index 9310dda..5635eea 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip70-rt40.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip71-rt41.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
 
-SRC_URI[sha256sum] = "186949d20d7ca0856d666665d66782805c39d6811a6baab1b88af1690c6c73e1"
+SRC_URI[sha256sum] = "324f821e4df5f2b364e318e37266274432f3057334f5bc841d7bf49a9dcc78c1"
diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.153-cip19-rt8.bb b/recipes-kernel/linux/linux-cip-rt_5.10.158-cip22-rt9.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip-rt_5.10.153-cip19-rt8.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.158-cip22-rt9.bb
index bee0661..571e840 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.153-cip19-rt8.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.158-cip22-rt9.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "075a95f357008133f999a037e0827f0d55fd1264b421b45548d9ab1be30df726"
+SRC_URI[sha256sum] = "98a83e5727b64081e6a90b9713b182ac5ef0a3957a76c695a9d71822d6a70d86"
diff --git a/recipes-kernel/linux/linux-cip_4.19.264-cip84.bb b/recipes-kernel/linux/linux-cip_4.19.268-cip87.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.19.264-cip84.bb
rename to recipes-kernel/linux/linux-cip_4.19.268-cip87.bb
index 860fa84..94f9f98 100644
--- a/recipes-kernel/linux/linux-cip_4.19.264-cip84.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.268-cip87.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "2176f15e9126499e9336fdd8ac1b560d41ca2d42f96b2492fbce7e8ccf7ba31f"
+SRC_URI[sha256sum] = "49c0acce195c42b9d987be48ada6e64bb7226e6acd0fe9e257d1b0470dc8279f"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip70.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip71.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip70.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip71.bb
index 2fd314c..8d6ab64 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip70.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip71.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019 - 2021
+# Copyright (c) Siemens AG, 2019 - 2022
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
 
-SRC_URI[sha256sum] = "0c59f3b3859c309a9a74d9709d70a35ea449868ebfa2fc56a0cc9d533f351000"
+SRC_URI[sha256sum] = "864d7e10e123bd0888018279d5f61257eae2c11465fb1ef2d0b10dc42b81d513"
diff --git a/recipes-kernel/linux/linux-cip_5.10.153-cip19.bb b/recipes-kernel/linux/linux-cip_5.10.158-cip22.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_5.10.153-cip19.bb
rename to recipes-kernel/linux/linux-cip_5.10.158-cip22.bb
index 317dfb6..54dd870 100644
--- a/recipes-kernel/linux/linux-cip_5.10.153-cip19.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.158-cip22.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "95bd235f131a1ab37a58dff85d4498bcc93bb189b04723923febd52d8566687b"
+SRC_URI[sha256sum] = "00745cadd0c555f69acd48174ddd484bdf6f9db2cac39429c7b7352134187abd"
-- 
2.25.1


