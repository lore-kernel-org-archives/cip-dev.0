Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BEAC433EF
	for <webhook@archiver.kernel.org>; Wed,  9 Mar 2022 08:19:31 +0000 (UTC)
Received: from esa4.mentor.iphmx.com (esa4.mentor.iphmx.com [68.232.137.252])
 by mx.groups.io with SMTP id smtpd.web08.3358.1646813971205386893
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Mar 2022 00:19:31 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.137.252, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400";
   d="scan'208";a="72895700"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa4.mentor.iphmx.com with ESMTP; 09 Mar 2022 00:19:30 -0800
IronPort-SDR: 
 lmuhc4OMJyJ5cvwefzw20EwX64oEVfVCSyzDcKoCJ6V+E+OlNMVQ706XF2dFRO2OY4VAT6kMTI
 wwhu3wqhE30KfHKzmMWaFh+smzWkiTDva0bUsm7COlcuJlV9IzzsxnDJAKm8m0rdYVnoaicCBx
 wV7Vxew/2jFyiSYSdhW6eMpT8MwyzCwo5CVxL33hqdg6jE7WlkQ2567uMo3C65Zs+68DikMYEU
 c1hZ4iuluYV1T8Y0GmkiyM6R/KeHRHDAcYgaMjtitVwuJxT6NMH2ZQqxfK5+qsHkpa/CkiLfSg
 oEg=
From: Srinuvasan A <Srinuvasan_A@mentor.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: Srinuvasan A <srinuvasan_a@mentor.com>
Subject: [cip-dev][isar-cip-core][PATCH] Update to kas 3.0.2
Date: Wed, 9 Mar 2022 13:49:11 +0530
Message-ID: <20220309081911.958224-1-Srinuvasan_A@mentor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ad2edc75-1d7a-6dcb-ce4f-e920bdc36242@siemens.com>
References: <ad2edc75-1d7a-6dcb-ce4f-e920bdc36242@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SVR-ORW-MBX-09.mgc.mentorg.com (147.34.90.209) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Mar 2022 08:19:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7682

From: Srinuvasan A <srinuvasan_a@mentor.com>

Update to kas 3.0.2.

Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
---
 .gitlab-ci.yml | 2 +-
 README.md      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c06c783..e2ed919 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,4 +1,4 @@
-image: ghcr.io/siemens/kas/kas-isar:2.6.2
+image: ghcr.io/siemens/kas/kas-isar:3.0.2
 
 variables:
   GIT_STRATEGY: clone
diff --git a/README.md b/README.md
index f7cb86e..ff973c5 100644
--- a/README.md
+++ b/README.md
@@ -12,7 +12,7 @@ from scratch.
 
 Install `kas-container` from the [kas project](https://github.com/siemens/kas):
 
-    wget https://raw.githubusercontent.com/siemens/kas/2.6.2/kas-container
+    wget https://raw.githubusercontent.com/siemens/kas/3.0.2/kas-container
     chmod a+x kas-container
 
 Furthermore, install docker and make sure you have required permissions to
-- 
2.25.1


