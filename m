Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA1EC7EE2D
	for <webhook@archiver.kernel.org>; Wed, 17 May 2023 14:31:00 +0000 (UTC)
Received: from esa4.mentor.iphmx.com (esa4.mentor.iphmx.com [68.232.137.252])
 by mx.groups.io with SMTP id smtpd.web10.50967.1684333850906406506
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 May 2023 07:30:51 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.137.252, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="5681640"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa4.mentor.iphmx.com with ESMTP; 17 May 2023 06:30:44 -0800
IronPort-SDR: 9vLp+a0KArkKysvwO8WRHsfTBaqtXzYepotchLaD8ysl+1v3U8cuMG4gIExN8CeokKHbPzyrFg
 06k2OhaMbn/6OS0fxGAN4hJN5Mbuj+OMA31XURMcaum8EQxOe41HNtoCMoTN48VvVJHujbyDqX
 E27QbUPDE8J1329kc+YhvQObGI4wq+m7wWhqp2QCxiRMs+8t83/aYEJ/jdl8NN7M8EYz1YBA7k
 +h7SSQhykQ7eEB36q4oZknLzVuXrClWE4P8J0fD5OONuSi7f27MauhmokgQ+F4+7v0sKCHx3in
 L38=
From: Srinuvasan Arjunan <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH v2] recipes-kernel/linux: Update cip-kernels to latest one
Date: Wed, 17 May 2023 19:51:48 +0530
Message-ID: <20230517142148.1526129-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517134206.1517172-1-srinuvasan_a@mentor.com>
References: <20230517134206.1517172-1-srinuvasan_a@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-12.mgc.mentorg.com (147.34.90.212) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 May 2023 14:31:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11498

From: Srinuvasan A <srinuvasan.a@siemens.com>

Update cip-kernels to latest one.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 ...{linux-cip_4.19.280-cip96.bb => linux-cip_4.19.282-cip97.bb} | 2 +-
 .../{linux-cip_4.4.302-cip74.bb => linux-cip_4.4.302-cip75.bb}  | 2 +-
 ...{linux-cip_5.10.177-cip31.bb => linux-cip_5.10.179-cip32.bb} | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-kernel/linux/{linux-cip_4.19.280-cip96.bb => linux-cip_4.19.282-cip97.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip74.bb => linux-cip_4.4.302-cip75.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_5.10.177-cip31.bb => linux-cip_5.10.179-cip32.bb} (72%)

diff --git a/recipes-kernel/linux/linux-cip_4.19.280-cip96.bb b/recipes-kernel/linux/linux-cip_4.19.282-cip97.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.19.280-cip96.bb
rename to recipes-kernel/linux/linux-cip_4.19.282-cip97.bb
index 0a1af14..6585a58 100644
--- a/recipes-kernel/linux/linux-cip_4.19.280-cip96.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.282-cip97.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "30f092e20799b9797376ee40d14995fd31a68773dff0b4913d4bbe5848cab5f6"
+SRC_URI[sha256sum] = "823a355cf0d6bf39c5ad96cfd2a6dacf652ac445d61bf61b0dc3754e7a24dc05"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip74.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip75.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip74.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip75.bb
index 4b6a548..fae6e12 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip74.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip75.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
 
-SRC_URI[sha256sum] = "0758c47f454d51fa80e3c63aac919d04ab4e6dc1a6ef8c34807e1e180d44d9d4"
+SRC_URI[sha256sum] = "b7616ce99de5f9f29065c8adb4a9465d118b7f4c89276f95b9de755c99cb3f61"
diff --git a/recipes-kernel/linux/linux-cip_5.10.177-cip31.bb b/recipes-kernel/linux/linux-cip_5.10.179-cip32.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_5.10.177-cip31.bb
rename to recipes-kernel/linux/linux-cip_5.10.179-cip32.bb
index 08bc8ad..cc06549 100644
--- a/recipes-kernel/linux/linux-cip_5.10.177-cip31.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.179-cip32.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "7a53197c1bd26c3c2dbcea0d93d287900dc3e0d92199ef13702e5bf78ae97f56"
+SRC_URI[sha256sum] = "526ce38dfee520233b9af1ff714ee69ad528c986c7d051aabe6b3726ea53832f"
-- 
2.34.1


