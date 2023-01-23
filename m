Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F887C38142
	for <webhook@archiver.kernel.org>; Mon, 23 Jan 2023 07:36:38 +0000 (UTC)
Received: from esa1.mentor.iphmx.com (esa1.mentor.iphmx.com [68.232.129.153])
 by mx.groups.io with SMTP id smtpd.web10.37353.1674459387856421112
 for <cip-dev@lists.cip-project.org>;
 Sun, 22 Jan 2023 23:36:27 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.129.153, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="98016392"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa1.mentor.iphmx.com with ESMTP; 22 Jan 2023 23:36:27 -0800
IronPort-SDR: V8pSg5wHBwtEJQynxd6acnCx9SNO3chqQql8JnRHPrcXYsQBIB5kJc3QcXPNcU8/7ugeUXgiXt
 Bf48/VWZ+J2JfJ0NAOfTP+CVX/DHKcPRl3PrmN9za4aw3/BzesSKnbIFCLe5pYDS+LikY/ENNm
 kzI3kzWVh6uHcFZJxPxG++vJwk1zU9+xRaebg80d2KmPqg8RlKG0ODUR/WVG2GeRKF/reebXYn
 2n9xTeg9k3GspvneBxnm23DW9BP3vmKfU2shLxlaNg3EpoDu8TVi4z+YMb29MgXRy24+DHGniY
 1b8=
From: Srinuvasan A <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] Update to kas 3.2
Date: Mon, 23 Jan 2023 13:05:52 +0530
Message-ID: <20230123073552.2859402-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jan 2023 07:36:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10461

From: Srinuvasan A <srinuvasan.a@siemens.com>

Update to kas 3.2.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 .gitlab-ci.yml | 2 +-
 README.md      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index f7c8c88..80a3c4b 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,4 +1,4 @@
-image: ghcr.io/siemens/kas/kas-isar:3.1
+image: ghcr.io/siemens/kas/kas-isar:3.2
 
 variables:
   GIT_STRATEGY: clone
diff --git a/README.md b/README.md
index e30ff3a..47c94be 100644
--- a/README.md
+++ b/README.md
@@ -12,7 +12,7 @@ from scratch.
 
 Install `kas-container` from the [kas project](https://github.com/siemens/kas):
 
-    wget https://raw.githubusercontent.com/siemens/kas/3.1/kas-container
+    wget https://raw.githubusercontent.com/siemens/kas/3.2/kas-container
     chmod a+x kas-container
 
 Furthermore, install docker and make sure you have required permissions to
-- 
2.34.1


