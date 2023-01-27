Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1BFC54EAA
	for <webhook@archiver.kernel.org>; Fri, 27 Jan 2023 06:24:08 +0000 (UTC)
Received: from esa4.mentor.iphmx.com (esa4.mentor.iphmx.com [68.232.137.252])
 by mx.groups.io with SMTP id smtpd.web10.96667.1674800645638459263
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Jan 2023 22:24:05 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.137.252, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="94914458"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa4.mentor.iphmx.com with ESMTP; 26 Jan 2023 22:24:04 -0800
IronPort-SDR: MYQov5r15GDPky2c6Bpm/bj7/fzhk0Vjx0rFBBFa0x2r6Em0bnK+ZofiRnSJq1r4iZRrPsV9yl
 JzIb6JLHfDWSi9ReNrjZJ1VxgCFof0BnJ18RhPcUzjpQRjeXbn3oVTBLXT4egIcDUzg/OMauTd
 GaA5LISos/xkeRBD8L4fuSiDhGQZ2HcpOqYAyiIZjm+pXCDGi+rikFpn0ONpHu6vWoAZ0YjDP7
 tKnmjgNatx/kVFN7IWKu0JHTZ7jbh7HAHJv/tLbUWUdn9OPdNnxjcZZ/OkLM7gmcosPR3qtH8I
 eLA=
From: Srinuvasan A <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] efibootguard: Update to release 0.13
Date: Fri, 27 Jan 2023 11:53:31 +0530
Message-ID: <20230127062331.250975-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-08.mgc.mentorg.com (147.34.90.208) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Jan 2023 06:24:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10496

From: Srinuvasan A <srinuvasan.a@siemens.com>

Update efibootguard to the latest release.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 .../{efibootguard_0.12.bb => efibootguard_0.13.bb}            | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename recipes-bsp/efibootguard/{efibootguard_0.12.bb => efibootguard_0.13.bb} (91%)

diff --git a/recipes-bsp/efibootguard/efibootguard_0.12.bb b/recipes-bsp/efibootguard/efibootguard_0.13.bb
similarity index 91%
rename from recipes-bsp/efibootguard/efibootguard_0.12.bb
rename to recipes-bsp/efibootguard/efibootguard_0.13.bb
index 721b9dc..79f784b 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.12.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.13.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2020
+# Copyright (c) Siemens AG, 2020-2023
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -20,7 +20,7 @@ SRC_URI = " \
     https://github.com/siemens/efibootguard/archive/refs/tags/v${PV}.tar.gz;downloadfilename=efitbootguard-v${PV}.tar.gz \
     file://debian \
     "
-SRC_URI[sha256sum] = "fd670f7a60a605c68ed411a9ab83ac680fbc9a9b5a8fd7b417c049f6cba5b6dc"
+SRC_URI[sha256sum] = "639a6d8f687cb099b2e9b01eb08ad1494267fe26b5d903b4d405d0737feb989b"
 
 PROVIDES = "${PN}"
 PROVIDES += "${PN}-dev"
-- 
2.34.1


