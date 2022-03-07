Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B693C433F5
	for <webhook@archiver.kernel.org>; Mon,  7 Mar 2022 09:34:26 +0000 (UTC)
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by mx.groups.io with SMTP id smtpd.web11.24389.1646645665213870571
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Mar 2022 01:34:25 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.137.180, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400";
   d="scan'208";a="72649448"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa3.mentor.iphmx.com with ESMTP; 07 Mar 2022 01:34:25 -0800
IronPort-SDR: 
 DJ2Y6EHtUOLMupw0/Tp0PojByd9lrtahCNHQAtT8KQeN86LeFWsi6As3TujQPfC9ZHh0ArO0XA
 +B4grBvZ8kv0RkMws4oOzFRHrJS70RZZ9iVfWEd5EKtMcNrcEKSpvh2/tScy38aqohd6Hh7XG0
 utDCeqXfHeTj2DBBgKfZR64/G260wT18wS3wpoveu1BQjkuAcOnVbKYvMMzLl0EEAaFuYn5Dks
 a2hTYV69Cf2W7nAOESLbT4BFdqsHSVWDTC2gw+lZX3VoZydU4lW1eYAMX6qH1Gqg8eqHxFC1wi
 Pls=
From: Srinuvasan A <Srinuvasan_A@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan_a@mentor.com>
Subject: [cip-dev][PATCH] Update to kas 3.0
Date: Mon, 7 Mar 2022 15:04:03 +0530
Message-ID: <20220307093403.282069-1-Srinuvasan_A@mentor.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Mar 2022 09:34:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7661

From: Srinuvasan A <srinuvasan_a@mentor.com>

Update to kas 3.0.

Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
---
 .gitlab-ci.yml | 2 +-
 README.md      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c06c783..f573da6 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,4 +1,4 @@
-image: ghcr.io/siemens/kas/kas-isar:2.6.2
+image: ghcr.io/siemens/kas/kas-isar:3.0
 
 variables:
   GIT_STRATEGY: clone
diff --git a/README.md b/README.md
index f7cb86e..fc4ddbf 100644
--- a/README.md
+++ b/README.md
@@ -12,7 +12,7 @@ from scratch.
 
 Install `kas-container` from the [kas project](https://github.com/siemens/kas):
 
-    wget https://raw.githubusercontent.com/siemens/kas/2.6.2/kas-container
+    wget https://raw.githubusercontent.com/siemens/kas/3.0/kas-container
     chmod a+x kas-container
 
 Furthermore, install docker and make sure you have required permissions to
-- 
2.25.1


