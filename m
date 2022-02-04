Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11686C433F5
	for <webhook@archiver.kernel.org>; Fri,  4 Feb 2022 05:40:42 +0000 (UTC)
Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
 by mx.groups.io with SMTP id smtpd.web11.5838.1643953240640762528
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Feb 2022 21:40:40 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.141.98, mailfrom: srinuvasan_a@mentor.com)
IronPort-SDR: 
 NYrfM+YP7l5Mhdyu64V0OsGhH88YMFTG8EfFkk+76/DWMNIvWxFAvl0lCeS3VkorP8XO3cngBI
 dN5Hr33BHWyRpRCR7F7tptGqq9X2BtqCgO6na24qE6XqprrfTulONRYjZlCq/xP1szVYhuWffz
 c1HgcUuDPmCLMVo8eJLUUK/4dA07aYycOsBEXutCvedAZPFS7b01m1DBsFQQSVagKz7rPfjB1J
 KrWcGXiPYjmBjbQfauZsrUlHFqbRSh8g7MttKIfILKE4v6TKAZaR7si7xWXlqslxL3kTvgpMa/
 yKftiDgACCDxRQFwF9ie/CQF
X-IronPort-AV: E=Sophos;i="5.88,341,1635235200";
   d="scan'208";a="71598162"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa2.mentor.iphmx.com with ESMTP; 03 Feb 2022 21:40:39 -0800
IronPort-SDR: 
 SeKMZwexso+ctG36b5hurHt3IcvNyHk39SRpCr8uyTPr3SYTsTY4wkOH+zp68F1YLWFN8b2LVV
 eRdmMs2/SsljX4OJQZe3ceYrtcZCM4dm2XyxtGu7VfW39luPB/XR5fSaZwa9ApsKtjO6xrKWsf
 yt4Ogelb2r2QfZcLBSh8CCyKbfxr4dC4bSGrKK2lxzdrBkwqFntk1zbifeH1GOWzzunIag2eZp
 N+Qup0hG15Mysums+ST7I+LW/Kbrgb6ddWfLII9SRhJ/tHT2L9r5JaeIWGDkuA/RgdXiJ/89eA
 AuU=
From: Srinuvasan A <Srinuvasan_A@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan_a@mentor.com>
Subject: [isar-cip-dev][PATCH] Uprevision the cip-kernel-config to latest one
Date: Fri, 4 Feb 2022 11:10:18 +0530
Message-ID: <20220204054018.629071-1-Srinuvasan_A@mentor.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-12.mgc.mentorg.com (147.34.90.212) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Feb 2022 05:40:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7572

From: Srinuvasan A <srinuvasan_a@mentor.com>

Uprevision the cip-kernel-config to latest one.

Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
---
 recipes-kernel/linux/linux-cip-common.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index 8fa8988..84515c2 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2022
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -25,6 +25,6 @@ SRC_URI_append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-confi
 
 SRC_URI_append_bbb = "file://${KERNEL_DEFCONFIG}"
 
-SRCREV_cip-kernel-config ?= "4f80764b80a81f9590e927fb202f358465b322a6"
+SRCREV_cip-kernel-config ?= "3f527304fdadd163e20b7a5a9cfabaca7506c716"
 
 S = "${WORKDIR}/linux-cip-v${PV}"
-- 
2.25.1


