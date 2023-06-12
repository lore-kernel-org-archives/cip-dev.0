Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F37CC7EE23
	for <webhook@archiver.kernel.org>; Mon, 12 Jun 2023 10:31:02 +0000 (UTC)
Received: from esa1.mentor.iphmx.com (esa1.mentor.iphmx.com [68.232.129.153])
 by mx.groups.io with SMTP id smtpd.web11.55064.1686565853405910768
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Jun 2023 03:30:53 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.129.153, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="6.00,236,1681200000"; 
   d="scan'208";a="9576936"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa1.mentor.iphmx.com with ESMTP; 12 Jun 2023 02:30:52 -0800
IronPort-SDR: b0Od//73DZltzLJMfcUWfl+p0MjJgsFoDOnllLvglEaNMLautoatMWucW2XlqkfbJW+mTZ0ZrW
 qzCcOX8rb2Jxq+3TShQfcv3RmFdeAQDYG7qS+vKbgoTHfCnpzBID0H6uGHaV3dsF37IhveIbJk
 rUOsXOwAoj3pksqcjKbezODrsKmSL2K5HzRadeYUvBs12pA1LiLKV0wzwSFt8GfwRCTum+U8Sy
 Vly0/QBoY+n13EHKcEGV796qKmnE82dID5YcwDMpZ0shC4FeD+LnOWTekZpcabX8NVT5LNfz5x
 rsA=
From: Srinuvasan Arjunan <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] swupdate: remove BASE_DISTRO_CODENAME override for buster recipe
Date: Mon, 12 Jun 2023 16:00:33 +0530
Message-ID: <20230612103033.2562735-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-15.mgc.mentorg.com (147.34.90.215) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Jun 2023 10:31:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11977

From: Srinuvasan A <srinuvasan.a@siemens.com>

Now we have individual swupdate recipe for buster and bullseye,
swupdate_2021.11-1+debian-gbp recipe dedicated to buster, hence remove
the buster override.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
index 48b5c2d..da1434e 100644
--- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
+++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
@@ -40,14 +40,14 @@ DEB_BUILD_PROFILES += "cross nocheck"
 # DEB_BUILD_PROFILES += "pkg.swupdate.embeddedlua"
 
 # modify for debian buster build
-SRC_URI:append:buster = " file://0006-debian-prepare-build-for-isar-debian-buster.patch"
+SRC_URI:append = " file://0006-debian-prepare-build-for-isar-debian-buster.patch"
 
 # disable create filesystem due to missing symbols in debian buster
 # disable webserver due to missing symbols in debian buster
-DEB_BUILD_PROFILES:append:buster = " \
-                                   pkg.swupdate.bpo \
-                                   pkg.swupdate.nocreatefs \
-                                   pkg.swupdate.nowebserver "
+DEB_BUILD_PROFILES:append = " \
+                            pkg.swupdate.bpo \
+                            pkg.swupdate.nocreatefs \
+                            pkg.swupdate.nowebserver "
 # In debian buster the git-compression defaults to gz and does not detect other
 # compression formats.
 GBP_EXTRA_OPTIONS += "--git-compression=xz"
-- 
2.34.1


