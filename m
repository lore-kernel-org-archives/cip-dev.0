Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55DFC433EF
	for <webhook@archiver.kernel.org>; Mon, 18 Oct 2021 11:20:08 +0000 (UTC)
Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
 by mx.groups.io with SMTP id smtpd.web08.35309.1634556007615618411
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Oct 2021 04:20:07 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.141.98, mailfrom: srinuvasan_a@mentor.com)
IronPort-SDR: 
 DB/Sh0AXbvH4dfEkEQtmwoFIqmVw65TcKThgm5q8/vv1cKcnt68q3EZcUrRi+CXdmDLvcQVT4C
 uv3IAUDNjOmghg+dhTgdBn0I89XxQskwZ0q55FIg4YfTFPJ2J37m8nT6e+OAaj0g9WZ9in0wtU
 HTUswGIXrXX4m36nPrO9Bf4HUHb449MqBhFRhCeFUOIglFq3GnKdeNbnT+9a3YarDFuI7lHlLG
 5Eu+weUEYQwd7YsiLbwD2vTzKh2wb8eQt/XB8wCs26bSmShVfZgg7P7AKaF8j9wqy9YNEuNoRl
 ta9/39J78sS9LQDPZyOuRFNS
X-IronPort-AV: E=Sophos;i="5.85,381,1624348800";
   d="scan'208";a="67309860"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa2.mentor.iphmx.com with ESMTP; 18 Oct 2021 03:20:06 -0800
IronPort-SDR: 
 Xf1Cz8ju0jgimPlfQ/JYNAQJc1FN92KztJcPODfzTimElN+I3RXmTWBAYviauMhD4cclpudBf8
 7R2GjW24ibJvk1k05a8bQXb89Bs91eYdN1zPCIwNDucpb1gvBvm+i+VxxFP365sjbj+EL4QBEY
 TKUV4AHlshHE1R/2ZQuzDgh3aSyhqjFWBF1hjz4z8POeqUe660aHK3GUYVlUda/aloFLEY7GAj
 zx6o3WYkbvFSzrKedYVG8TJhK+p2KBBja3pTQexcAu7WqwYLz8Cs8eEv4oDLhoR7c93f2m5tm/
 iHM=
From: Srinuvasan A <Srinuvasan_A@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: Srinuvasan A <srinuvasan_a@mentor.com>
Subject: [isar-cip-dev] [PATCH] Update efibootguard to latest release 0.9
Date: Mon, 18 Oct 2021 16:49:46 +0530
Message-ID: <20211018111946.4192167-1-Srinuvasan_A@mentor.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SVR-ORW-MBX-07.mgc.mentorg.com (147.34.90.207) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Oct 2021 11:20:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6829

From: Srinuvasan A <srinuvasan_a@mentor.com>

Uprevision the latest revision and tag.

Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
---
 ...fibootguard_0.8-git+isar.bb => efibootguard_0.9-git+isar.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-bsp/efibootguard/{efibootguard_0.8-git+isar.bb => efibootguard_0.9-git+isar.bb} (95%)

diff --git a/recipes-bsp/efibootguard/efibootguard_0.8-git+isar.bb b/recipes-bsp/efibootguard/efibootguard_0.9-git+isar.bb
similarity index 95%
rename from recipes-bsp/efibootguard/efibootguard_0.8-git+isar.bb
rename to recipes-bsp/efibootguard/efibootguard_0.9-git+isar.bb
index ebd848d..2817e5b 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.8-git+isar.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.9-git+isar.bb
@@ -22,7 +22,7 @@ SRC_URI = "git://github.com/siemens/efibootguard.git;branch=master;protocol=http
 
 S = "${WORKDIR}/git"
 
-SRCREV = "ac1685aea75fb3e3d16c0c0e4f8261a2edb63536"
+SRCREV = "c01324d0da202727eb0744c0f67a78f9c9b65c46"
 
 PROVIDES = "${PN}"
 PROVIDES += "${PN}-dev"
-- 
2.25.1


