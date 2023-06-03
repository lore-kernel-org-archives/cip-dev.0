Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE15C77B7A
	for <webhook@archiver.kernel.org>; Sat,  3 Jun 2023 08:10:13 +0000 (UTC)
Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
 by mx.groups.io with SMTP id smtpd.web11.8031.1685779804089862283
 for <cip-dev@lists.cip-project.org>;
 Sat, 03 Jun 2023 01:10:04 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.141.98, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="6.00,215,1681200000"; 
   d="scan'208";a="8403802"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa2.mentor.iphmx.com with ESMTP; 03 Jun 2023 00:10:03 -0800
IronPort-SDR: uJeyzwr095e6T8bb5Wi4pv0h+oaXXpB9kBEBs4l5YqLbvC5fKpSmJUDa4Go5hi1AG7SuIpECQU
 4jXKaimgDHBdjW/cE9DHqI6LM6Q6TEnrsrVWgnNO8FkJdvzmv8+Ew7AG576prlKhpdJaXek5Z3
 ZZ+LDUe2s3h2Szc6P8gboBvWd1tB9jou1WBG3U6sBZOF8u1905vV0EXfm02P/9MkEXnG+hbbcT
 VHuvhFs+U5zK9xgLq3obCyZJxndHvu8UMeKhuo2EouBNJLNiLeqt+ZtT98saWGXyOQPJUdVlgW
 5bI=
From: Srinuvasan Arjunan <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] recipes-kernel/linux: update cip-kernels to latest one
Date: Sat, 3 Jun 2023 13:39:41 +0530
Message-ID: <20230603080941.454533-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-11.mgc.mentorg.com (147.34.90.211) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 03 Jun 2023 08:10:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11750

From: Srinuvasan A <srinuvasan.a@siemens.com>

Update cip-kernels to latest one.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 ...19.277-cip94-rt29.bb => linux-cip-rt_4.19.280-cip95-rt30.bb} | 2 +-
 ...10.175-cip29-rt12.bb => linux-cip-rt_5.10.179-cip32-rt13.bb} | 2 +-
 ...{linux-cip_4.19.282-cip97.bb => linux-cip_4.19.283-cip98.bb} | 2 +-
 ...{linux-cip_5.10.179-cip32.bb => linux-cip_5.10.180-cip34.bb} | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.277-cip94-rt29.bb => linux-cip-rt_4.19.280-cip95-rt30.bb} (72%)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.175-cip29-rt12.bb => linux-cip-rt_5.10.179-cip32-rt13.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_4.19.282-cip97.bb => linux-cip_4.19.283-cip98.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_5.10.179-cip32.bb => linux-cip_5.10.180-cip34.bb} (72%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.277-cip94-rt29.bb b/recipes-kernel/linux/linux-cip-rt_4.19.280-cip95-rt30.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip-rt_4.19.277-cip94-rt29.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.280-cip95-rt30.bb
index 1a26973..d973b94 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.277-cip94-rt29.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.280-cip95-rt30.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "1fa134ac4daa88ffb2c787d05358c1039df1f350b3953b879b6ffb207d3374ea"
+SRC_URI[sha256sum] = "dfe9992d937c47f2f5a79ddd2156fd4ab749c9d82ef04506dfa8da6cfbb594b0"
diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.175-cip29-rt12.bb b/recipes-kernel/linux/linux-cip-rt_5.10.179-cip32-rt13.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip-rt_5.10.175-cip29-rt12.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.179-cip32-rt13.bb
index c58e8b7..83f387e 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.175-cip29-rt12.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.179-cip32-rt13.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "60763c904a70b1596deb5d65a3260de2e8dbe0583b411b55a5b9a90edce16104"
+SRC_URI[sha256sum] = "2106be5c70ee7d0074fb6767265a3613ce593dc4a5a46dcc6bf98697f251ebfd"
diff --git a/recipes-kernel/linux/linux-cip_4.19.282-cip97.bb b/recipes-kernel/linux/linux-cip_4.19.283-cip98.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.19.282-cip97.bb
rename to recipes-kernel/linux/linux-cip_4.19.283-cip98.bb
index 6585a58..b12fb6b 100644
--- a/recipes-kernel/linux/linux-cip_4.19.282-cip97.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.283-cip98.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "823a355cf0d6bf39c5ad96cfd2a6dacf652ac445d61bf61b0dc3754e7a24dc05"
+SRC_URI[sha256sum] = "6d8474aad8621163f1478fcd110f391863ee2ed5180fccb4613c2e3eccc2e4e6"
diff --git a/recipes-kernel/linux/linux-cip_5.10.179-cip32.bb b/recipes-kernel/linux/linux-cip_5.10.180-cip34.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_5.10.179-cip32.bb
rename to recipes-kernel/linux/linux-cip_5.10.180-cip34.bb
index cc06549..9b812b7 100644
--- a/recipes-kernel/linux/linux-cip_5.10.179-cip32.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.180-cip34.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "526ce38dfee520233b9af1ff714ee69ad528c986c7d051aabe6b3726ea53832f"
+SRC_URI[sha256sum] = "6b715945aa287b93fa8e69086988a76b3d0f1e5da82caad47dd653baac3bfd55"
-- 
2.34.1


