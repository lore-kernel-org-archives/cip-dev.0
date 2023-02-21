Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C74BC61DA3
	for <webhook@archiver.kernel.org>; Tue, 21 Feb 2023 13:51:07 +0000 (UTC)
Received: from esa4.mentor.iphmx.com (esa4.mentor.iphmx.com [68.232.137.252])
 by mx.groups.io with SMTP id smtpd.web10.42243.1676987459224393515
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Feb 2023 05:50:59 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.137.252, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="97709193"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa4.mentor.iphmx.com with ESMTP; 21 Feb 2023 05:50:54 -0800
IronPort-SDR: 5GonjRV6DhABGTU+XmfzO+JXtB+rVv002Vb9Zm7D+K7+66h7g57YlQJINUnqptYyNssY7DYJT4
 hzp7gCPcjtFRPaojqVBKuHIINPzc3ml+tHNV1maWgNNE2YXaCQit65OM1X7A+Atv6HOiluWvc0
 5MNw9hQLbd4JNZrYV2SE+CF2A+R/fyvXP87i/rKtQyUMuaKXAczB7S4GTmWfjyPyYCSMmp3GtY
 Bwx2pTdltKlKUYJA8fh7GOH6uLDGu2UhZ96SjsdwZvurVyc/RU7tZdbttUDpDOY610hWK9gIN5
 HTk=
From: Srinuvasan A <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update cip-kernels to latest one
Date: Tue, 21 Feb 2023 19:20:32 +0530
Message-ID: <20230221135032.1850174-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-15.mgc.mentorg.com (147.34.90.215) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Feb 2023 13:51:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10752

From: Srinuvasan A <srinuvasan.a@siemens.com>

Update cip-kernels to latest one.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 ...4.302-cip71-rt41.bb => linux-cip-rt_4.4.302-cip72-rt42.bb} | 4 ++--
 ...0.158-cip22-rt9.bb => linux-cip-rt_5.10.162-cip24-rt10.bb} | 2 +-
 ...inux-cip_4.19.270-cip89.bb => linux-cip_4.19.272-cip91.bb} | 2 +-
 ...{linux-cip_4.4.302-cip71.bb => linux-cip_4.4.302-cip72.bb} | 2 +-
 ...inux-cip_5.10.162-cip24.bb => linux-cip_5.10.167-cip26.bb} | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip71-rt41.bb => linux-cip-rt_4.4.302-cip72-rt42.bb} (60%)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.158-cip22-rt9.bb => linux-cip-rt_5.10.162-cip24-rt10.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_4.19.270-cip89.bb => linux-cip_4.19.272-cip91.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip71.bb => linux-cip_4.4.302-cip72.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_5.10.162-cip24.bb => linux-cip_5.10.167-cip26.bb} (72%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip71-rt41.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip72-rt42.bb
similarity index 60%
rename from recipes-kernel/linux/linux-cip-rt_4.4.302-cip71-rt41.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip72-rt42.bb
index 5635eea..d6d0a52 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip71-rt41.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip72-rt42.bb
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
 
 KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
 
-SRC_URI[sha256sum] = "324f821e4df5f2b364e318e37266274432f3057334f5bc841d7bf49a9dcc78c1"
+SRC_URI[sha256sum] = "f06c3048ec3a18e3d25268374396a74b64c55cb858d3b4eb98ecc3b87e8d871c"
diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.158-cip22-rt9.bb b/recipes-kernel/linux/linux-cip-rt_5.10.162-cip24-rt10.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip-rt_5.10.158-cip22-rt9.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.162-cip24-rt10.bb
index 571e840..4cb3389 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.158-cip22-rt9.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.162-cip24-rt10.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "98a83e5727b64081e6a90b9713b182ac5ef0a3957a76c695a9d71822d6a70d86"
+SRC_URI[sha256sum] = "b5539243f187e3d478d76d44ae13aab83952c94b885ad889df6fa9997e16a441"
diff --git a/recipes-kernel/linux/linux-cip_4.19.270-cip89.bb b/recipes-kernel/linux/linux-cip_4.19.272-cip91.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.19.270-cip89.bb
rename to recipes-kernel/linux/linux-cip_4.19.272-cip91.bb
index ca64a76..7b321e4 100644
--- a/recipes-kernel/linux/linux-cip_4.19.270-cip89.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.272-cip91.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "e91ca34303d01ed9e366f4d0a171f96eef61242623e20bf3e175a8ce10f0a386"
+SRC_URI[sha256sum] = "680405742299138b53247569855d13c737e07af1fd191aa69ab60ce9e65f51c8"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip71.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip72.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip71.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip72.bb
index 8d6ab64..7f4a386 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip71.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip72.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
 
-SRC_URI[sha256sum] = "864d7e10e123bd0888018279d5f61257eae2c11465fb1ef2d0b10dc42b81d513"
+SRC_URI[sha256sum] = "35ca43e814bb87b0da610b9682fe10494c54436f6de563bf3cd42d20746ca4d7"
diff --git a/recipes-kernel/linux/linux-cip_5.10.162-cip24.bb b/recipes-kernel/linux/linux-cip_5.10.167-cip26.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_5.10.162-cip24.bb
rename to recipes-kernel/linux/linux-cip_5.10.167-cip26.bb
index 566caf6..7b0667e 100644
--- a/recipes-kernel/linux/linux-cip_5.10.162-cip24.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.167-cip26.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "fb0edc3c18e47d2b6974cb0880a0afb5c3fa08f50ee87dfdf24349405ea5f8ae"
+SRC_URI[sha256sum] = "982381137420cdf4ef96b95ebdf6654973bcc1238f497c455fcdbc272981b883"
-- 
2.34.1


