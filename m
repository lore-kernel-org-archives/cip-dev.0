Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71717C77B75
	for <webhook@archiver.kernel.org>; Mon, 22 May 2023 09:19:18 +0000 (UTC)
Received: from esa4.mentor.iphmx.com (esa4.mentor.iphmx.com [68.232.137.252])
 by mx.groups.io with SMTP id smtpd.web11.17800.1684747154206887858
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 May 2023 02:19:14 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.137.252, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="6.00,184,1681200000"; 
   d="scan'208";a="6111659"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa4.mentor.iphmx.com with ESMTP; 22 May 2023 01:19:09 -0800
IronPort-SDR: Jpk99p2u1tfVkuG2s+/y+ShVU+Hakp5G62gIF8WI+fm+JV1xu0kQq9yXtzPUGD1t/MOISUsRL0
 ygFD/EojpiX34LWLYt3KiS5RgG5hKSGPl/4KLM0TTNG8cJKz+5Iy3gQCfZ904SD/7up9/JelF4
 25X6E7xYDsC9T9JYTx3mnr7reCYCaWuvXawElVAb7HrT+1EGhr84KjQrzYy4jSHp2nNqmmfuVo
 3txpXsqWmbiXqjNF79PiQ3O4k7klv8XFb+uerb6nK1CbO01zTOuGcGTx5gPJOtGkZ8hm7XYkzO
 auA=
From: Srinuvasan Arjunan <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] image_uuid.bbclass: remove rootfs class
Date: Mon, 22 May 2023 14:48:50 +0530
Message-ID: <20230522091850.1699689-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-14.mgc.mentorg.com (147.34.90.214) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 May 2023 09:19:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11583

From: Srinuvasan A <srinuvasan.a@siemens.com>

image class inheriting the rootfs, hence remove the duplication of
inheritance.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 classes/image_uuid.bbclass | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/classes/image_uuid.bbclass b/classes/image_uuid.bbclass
index 9ffe14d..fa68b2c 100644
--- a/classes/image_uuid.bbclass
+++ b/classes/image_uuid.bbclass
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2020-2022
+# Copyright (c) Siemens AG, 2020-2023
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -10,7 +10,6 @@
 # SPDX-License-Identifier: MIT
 #
 
-inherit rootfs
 inherit image
 
 # Generate the uuid from BB_TASKHASH to ensure a new
-- 
2.34.1


