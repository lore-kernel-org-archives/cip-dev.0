Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D170BC4332F
	for <webhook@archiver.kernel.org>; Thu, 10 Nov 2022 09:21:09 +0000 (UTC)
Received: from esa4.mentor.iphmx.com (esa4.mentor.iphmx.com [68.232.137.252])
 by mx.groups.io with SMTP id smtpd.web11.5405.1668072059160767741
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Nov 2022 01:20:59 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.137.252, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="5.96,153,1665475200"; 
   d="scan'208";a="86548480"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa4.mentor.iphmx.com with ESMTP; 10 Nov 2022 01:20:57 -0800
IronPort-SDR: bcAhegg8YhOymMMsq/VXA4j2pAIQmV2nTkF2hY0lvHkm/fuDQMDqLLBbB/CIZIp7OkmGpdxRV3
 x60cklcyzgpYUeaRsycoiixgXd+EM03HAqm909YGHMkkP+sU3lcxtRYTIvWs2AY+szmYDBLA7Y
 MQzUAcRdfxWMk3LcHGHgB0OZXIeomfFi9JEr1PVUPypEJDskyUFqDPdvyaYqCN7QRoQ7eQrY1U
 Y4E7TAh3uK5HksFwsZFu4sOWPzFue72TkypQgj6gNAUg8PEar2a+YOvn44QZBus3y7o2rCjSMl
 1J8=
From: Srinuvasan A <Srinuvasan_A@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan_a@mentor.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update cip-kernels to latest one
Date: Thu, 10 Nov 2022 14:50:37 +0530
Message-ID: <20221110092037.2342861-1-Srinuvasan_A@mentor.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-14.mgc.mentorg.com (147.34.90.214) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Nov 2022 09:21:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9995

From: Srinuvasan A <srinuvasan_a@mentor.com>

Update cip-kernels to 4.19.264-cip84, 5.10.153-cip19 and 5.10.153-cip19-rt8.

Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
---
 ...10.145-cip17-rt7.bb => linux-cip-rt_5.10.153-cip19-rt8.bb} | 4 ++--
 ...inux-cip_4.19.259-cip82.bb => linux-cip_4.19.264-cip84.bb} | 2 +-
 ...inux-cip_5.10.145-cip17.bb => linux-cip_5.10.153-cip19.bb} | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.145-cip17-rt7.bb => linux-cip-rt_5.10.153-cip19-rt8.bb} (60%)
 rename recipes-kernel/linux/{linux-cip_4.19.259-cip82.bb => linux-cip_4.19.264-cip84.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_5.10.145-cip17.bb => linux-cip_5.10.153-cip19.bb} (72%)

diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.145-cip17-rt7.bb b/recipes-kernel/linux/linux-cip-rt_5.10.153-cip19-rt8.bb
similarity index 60%
rename from recipes-kernel/linux/linux-cip-rt_5.10.145-cip17-rt7.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.153-cip19-rt8.bb
index 0cb2a1d..bee0661 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.145-cip17-rt7.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.153-cip19-rt8.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021
+# Copyright (c) Siemens AG, 2021-2022
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "a5598f7f673b3ef819d6ed24f08d539eecb6febd11673a1d4752a1c05d4ee289"
+SRC_URI[sha256sum] = "075a95f357008133f999a037e0827f0d55fd1264b421b45548d9ab1be30df726"
diff --git a/recipes-kernel/linux/linux-cip_4.19.259-cip82.bb b/recipes-kernel/linux/linux-cip_4.19.264-cip84.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.19.259-cip82.bb
rename to recipes-kernel/linux/linux-cip_4.19.264-cip84.bb
index d728e2b..860fa84 100644
--- a/recipes-kernel/linux/linux-cip_4.19.259-cip82.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.264-cip84.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "b29e7d90959b29c67a0afa4432937fcc51138b519d33f24ff2ce976fbd958ffd"
+SRC_URI[sha256sum] = "2176f15e9126499e9336fdd8ac1b560d41ca2d42f96b2492fbce7e8ccf7ba31f"
diff --git a/recipes-kernel/linux/linux-cip_5.10.145-cip17.bb b/recipes-kernel/linux/linux-cip_5.10.153-cip19.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_5.10.145-cip17.bb
rename to recipes-kernel/linux/linux-cip_5.10.153-cip19.bb
index b4bf6b7..317dfb6 100644
--- a/recipes-kernel/linux/linux-cip_5.10.145-cip17.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.153-cip19.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "4594c147bdc493c7c286688542bbe65e550fb7bd58e0649ec587a2fe893ec0ee"
+SRC_URI[sha256sum] = "95bd235f131a1ab37a58dff85d4498bcc93bb189b04723923febd52d8566687b"
-- 
2.25.1


