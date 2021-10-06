Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3DAC433F5
	for <webhook@archiver.kernel.org>; Wed,  6 Oct 2021 10:14:51 +0000 (UTC)
Received: from esa1.mentor.iphmx.com (esa1.mentor.iphmx.com [68.232.129.153])
 by mx.groups.io with SMTP id smtpd.web10.9951.1633515290609365409
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Oct 2021 03:14:50 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.129.153, mailfrom: srinuvasan_a@mentor.com)
IronPort-SDR: 
 lGCmMU3nvDyTvNhGsDwCdqWVFqsZJzLwrZgJTg50q9h7Rm4rW4YAatA54xhb/C+2O/9PpSIH7k
 VqHgGmokDsN6Ho0uZoUqi2i+UNvyZqNpRixY6qcr0zsBq9QHPDoC8xFBg2z1/dYhMoEweCtUpR
 0cbmv/k1ejSObCHWCaljEHCKNkwJ2c3cVnoiWnoeUKTVSkJ1AiFHGBQnaaneDFAcvo6an5mGVb
 9pbWN427Dj9i9rvMI0BZYH2VS05/jQcGLq6VE3hfBmRmN1LPo9uWh4HK4WdavgLM6yPqh+k5mA
 7jYiLzz+u+12PnbvjiS28Vsw
X-IronPort-AV: E=Sophos;i="5.85,350,1624348800";
   d="scan'208";a="69276314"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa1.mentor.iphmx.com with ESMTP; 06 Oct 2021 02:14:49 -0800
IronPort-SDR: 
 gCf+CIWB6+br2pHVqQ6YY5JY6RqKUqdPgp7lcKAaZNqZ2XxBsv4qPi2S4JGx6xzEfo5wgJsr5G
 PQVtzayBJKEEtNHpPZKgWJyawQpc/GBe/5C+tFZll8OhodakItain1ti5vmqpSUCfYNRLnFiY3
 C6x9mkiuG6fXWL99IMT3Kqek1hglhysGJAWDbgosAmm/rP/KCHj7+Q/wVOECC2VITM53q3rJwm
 2pdHM2NgTrXTOMKfzdBcJndz4xi5Jz0fnyaEYXlztXDyeTs8rxp2grqz/TZ4UAjYEl1h0yNGki
 i6o=
From: Srinuvasan A <Srinuvasan_A@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: Srinuvasan A <srinuvasan_a@mentor.com>
Subject: [isar-cip-dev] [PATCH] Uprevision the ISAR to latest one
Date: Wed, 6 Oct 2021 15:44:22 +0530
Message-ID: <20211006101422.1976005-1-Srinuvasan_A@mentor.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-08.mgc.mentorg.com (147.34.90.208) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Oct 2021 10:14:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6792

From: Srinuvasan A <srinuvasan_a@mentor.com>

Update to latest ISAR.

When we build the images with efibootguard wic plugin it is expecting
the KERNEL_IMAGE and INITRD_IMAGE variable, but it is removed in
Upstream ISAR due to cleanup the unused variables.

Ref: https://github.com/ilbers/isar/commit/6fa0197ac36a86b2ae5c27f5b7804dd9a46d3c0b

But those variables we used in downstream layer with efibootguard wic
plugin hence added required WIC variables in efibootguard.yml to genereate successful wic images.

Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
---
 kas-cip.yml              | 2 +-
 kas/opt/efibootguard.yml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index 8522957..4eadaa7 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: 03124cca669f50b682336a0bdf4ede5a4238e144
+    refspec: 9b31dae3284127d4aed4b9331af1b1c3c31152f5
     layers:
       meta:
 
diff --git a/kas/opt/efibootguard.yml b/kas/opt/efibootguard.yml
index 705a76d..580c315 100644
--- a/kas/opt/efibootguard.yml
+++ b/kas/opt/efibootguard.yml
@@ -22,7 +22,7 @@ local_conf_header:
 
   efibootguard-wic: |
     WDOG_TIMEOUT ?= "60"
-    WICVARS += "WDOG_TIMEOUT"
+    WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE"
     IMAGE_TYPE ?= "wic-img"
     WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
 
-- 
2.25.1


