Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F38C77B73
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 08:35:31 +0000 (UTC)
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by mx.groups.io with SMTP id smtpd.web11.2628.1685954130578288694
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jun 2023 01:35:30 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.137.180, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="6.00,217,1681200000"; 
   d="scan'208";a="7650927"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa3.mentor.iphmx.com with ESMTP; 05 Jun 2023 00:35:27 -0800
IronPort-SDR: ivCKViXR/FHC33qLzKtBPKTeZ65CnfEJPJz3u9NF7z1Ew7kjh9ORSEYZG0CgQbOWMnzdcsoBxY
 vij+eZI50nMDpbrgrgQ/Zq0yvK5blJlG8J3pME8ErY34FC8lhX9ITWuCJwYh5OR1nOwx9fBNjA
 2iMQ5Ay0ltuzBLRsDdASTqATvg9lCkSLrknrR1TVHdF+whsB9sOMH1wm9PUjEAogNPwsRq5ZOE
 oVyUF0hmNTyiPh6ULLV/+FD5JBm0FolBjE8fyGHgZlsm8OaTW6M1TfO4gRMLB3inFaJ5RCLfZg
 ZUg=
From: Srinuvasan Arjunan <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] linux/cip-kernel-config: Bump cip-kernel-config revision
Date: Mon, 5 Jun 2023 14:05:08 +0530
Message-ID: <20230605083508.1297159-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-12.mgc.mentorg.com (147.34.90.212) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 08:35:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11777

From: Srinuvasan A <srinuvasan.a@siemens.com>

Update cip-kernel-config revision to latest one.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 recipes-kernel/linux/cip-kernel-config.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index 329b9f7..e104200 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -14,4 +14,4 @@ SRC_URI:append = " ${@ \
     if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
     }"
 
-SRCREV_cip-kernel-config ?= "d1efa37258380c7f4f39a8dee1bdb4d85f1c0199"
+SRCREV_cip-kernel-config ?= "a28b7a678418287b12161975fe8b9b04a3cc8c88"
-- 
2.34.1


