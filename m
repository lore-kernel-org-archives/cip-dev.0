Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D16ECAAD8
	for <webhook@archiver.kernel.org>; Wed, 14 Sep 2022 13:13:14 +0000 (UTC)
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by mx.groups.io with SMTP id smtpd.web12.6179.1663161190085032272
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Sep 2022 06:13:10 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.137.180, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="5.93,315,1654588800";
   d="scan'208";a="82849785"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 14 Sep 2022 05:13:08 -0800
IronPort-SDR: 
 jxlzQyCb5I38XioP3TseCrJzCG/siOS1sJrxmvPZu46vjc86OaPC6kjFtPtenplay1DcC051c5
 Ia/bBAyPvUEbvjG1xBKPb21LjIytzIqzPEhjqXXpqHYck5Yc8XIDTSYlz3D9+E8jWe1m+cfJvP
 ce5yUZY9MzB0u5geZs65OOijWt/tWyxWlp7KMLR5t3z7BjYLpITvI9LCZkWFzgXuFmn7r8lT3G
 75g8BTbO4G79DriD3eoFQpy4dHz0vIsaK0moG3l3D5ClBLmTrysHc6cp3DfpbWcjFgg5FOwY+o
 RPI=
From: Srinuvasan A <Srinuvasan_A@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan_a@mentor.com>
Subject: [isar-cip-core][PATCH] Update to kas 3.1
Date: Wed, 14 Sep 2022 18:42:47 +0530
Message-ID: <20220914131247.527986-1-Srinuvasan_A@mentor.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-14.mgc.mentorg.com (147.34.90.214) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Sep 2022 13:13:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9494

From: Srinuvasan A <srinuvasan_a@mentor.com>

Update to kas 3.1.

Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
---
 .gitlab-ci.yml | 2 +-
 README.md      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 81301e5..ce40b5d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,4 +1,4 @@
-image: ghcr.io/siemens/kas/kas-isar:3.0.2
+image: ghcr.io/siemens/kas/kas-isar:3.1
 
 variables:
   GIT_STRATEGY: clone
diff --git a/README.md b/README.md
index ff973c5..e30ff3a 100644
--- a/README.md
+++ b/README.md
@@ -12,7 +12,7 @@ from scratch.
 
 Install `kas-container` from the [kas project](https://github.com/siemens/kas):
 
-    wget https://raw.githubusercontent.com/siemens/kas/3.0.2/kas-container
+    wget https://raw.githubusercontent.com/siemens/kas/3.1/kas-container
     chmod a+x kas-container
 
 Furthermore, install docker and make sure you have required permissions to
-- 
2.25.1


