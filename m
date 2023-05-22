Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949A0C77B73
	for <webhook@archiver.kernel.org>; Mon, 22 May 2023 10:17:58 +0000 (UTC)
Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
 by mx.groups.io with SMTP id smtpd.web10.18638.1684750673820028882
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 May 2023 03:17:53 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.141.98, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="6.00,184,1681200000"; 
   d="scan'208";a="6810269"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa2.mentor.iphmx.com with ESMTP; 22 May 2023 02:17:53 -0800
IronPort-SDR: KzDP9C1tlH16HmTXfv7zjMAPmtTAgxD0VKeMP7ceLL3etCZOsspkkoPVfD4WLr//vT7KUGbXDm
 71cCGBYqz5FCvqLXW+RpzFpATwtjEL4r7Z3MkP23bo3wuToQYf5plkMKW/wsUi/ZnQeIV6zHg/
 xhUSCziTwXppuvDvaDnB9lbWVI74VgpkXDpdRDxpsRnNMoQMxSwr4ccvDX6sdkp3ZmEQGUB2rv
 8vlajCF94HDDwhKn8ua/xSwRz+qp9y99VzI3asTFBHif+lKrLg9XyoMOXSRonCezm2Bki8TZtc
 pEI=
From: Srinuvasan Arjunan <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] classes/swupdate: remove image_do_mounts
Date: Mon, 22 May 2023 15:47:34 +0530
Message-ID: <20230522101734.1700221-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 May 2023 10:17:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11584

From: Srinuvasan A <srinuvasan.a@siemens.com>

When we hookup the IMAGE_CMD:* for image generation,
image_do_mounts is inserted automatically, hence remove the duplication
here.

Ref: https://github.com/ilbers/isar/commit/f792fd0deed1ae1d9deb3ee28b1a1add96ecdf14

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 classes/swupdate.bbclass | 2 --
 1 file changed, 2 deletions(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 9a4d509..9f34760 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -97,8 +97,6 @@ IMAGE_CMD:swu() {
         fi
     done
 
-    image_do_mounts
-
     # Prepare for signing
     export sign='${@'x' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}'
     if [ -n "$sign" ]; then
-- 
2.34.1


