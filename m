Return-Path: <Vijaikumar_Kanagarajan@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205F9C433F5
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 16:49:05 +0000 (UTC)
Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
 by mx.groups.io with SMTP id smtpd.web11.12924.1639673343522200205
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 08:49:03 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.141.98, mailfrom: vijaikumar_kanagarajan@mentor.com)
IronPort-SDR: 
 pUC4hLCth6jbP57/4GQ/oiFcdptmC+iAG790uUg8RUQOL029ufKRLuIflHFh/hTFuo5ZDQgF+x
 3OVHo8vkiVzhxOHVZqR4mLFH627cfFtt+bBrqyvuQd0o2Y9LoaSyqdJlolQNHhhbdqaqzE+6Qg
 W0hi1pLsZx5xOQNPbyYYvGKJb3ey3mu2C5+koBmnAvwGh97x3Zro+JhqOtPI6T5fF66hzzzkCU
 /EEAIWUtWUZfZlEBPA/7EzSBFYWB1AbOjojlvnkL9wcq1KWXVsMgBkjKG7dmAR8FlbZVpRR8aP
 RVzNGD7BVooP681y+i4s5I/h
X-IronPort-AV: E=Sophos;i="5.88,211,1635235200";
   d="scan'208";a="69788477"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa2.mentor.iphmx.com with ESMTP; 16 Dec 2021 08:49:03 -0800
IronPort-SDR: 
 aAx1MESYV0hwcf/1JqJH1RAUoYi6WZLtMJRWgp4vgRBMwDVc+SJgfXLBOiZjPlyuNjDjAXAjxf
 eteBeSMKO+Om1K9A30cZ14c47onOpDOJ8r28IdgiTjoi76xkDFEYgg70YoFONwKDNOoKh7CXoQ
 4fQYo522Dr74iCfF0Qpngo/XH2ijfrjlsJ8QXjyGn3Cw4Wav6MI8T81fwCDE2XMAdc/5IA2e9T
 CM7EesTxhsFtPxCEgEL6EGQpnarL4gnGluUiSeaJJHrUKLFJPJVHXYUenHni9zVKoMdSDXePBU
 oyk=
From: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
Subject: [PATCH v3] swupdate: Add nodoc for buster and bullseye
Date: Thu, 16 Dec 2021 22:18:42 +0530
Message-ID: <20211216164842.3403906-1-Vijaikumar_Kanagarajan@mentor.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-08.mgc.mentorg.com (147.34.90.208) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 16:49:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7165

Including documentation makes the build fail in buster and bullseye.
Remove it.

Signed-off-by: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
---
 recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
index a4d67fe..e25ee4c 100644
--- a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
+++ b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
@@ -44,12 +44,14 @@ SWUPDATE_BUILD_PROFILES += "cross nocheck"
 # modify for debian buster build
 SRC_URI_append_buster = " file://0009-debian-prepare-build-for-isar-debian-buster.patch"
 
-# disable documentation due to missing packages in debian buster
+# disable documentation due to missing packages
+SWUPDATE_BUILD_PROFILES_append = " nodoc "
+
 # disable create filesystem due to missing symbols in debian buster
 # disable webserver due to missing symbols in debian buster
-SWUPDATE_BUILD_PROFILES_append_buster = " nodoc \
-                                          pkg.swupdate.nocreatefs \
-                                          pkg.swupdate.nowebserver "
+SWUPDATE_BUILD_PROFILES_append_buster = " \
+                                   pkg.swupdate.nocreatefs \
+                                   pkg.swupdate.nowebserver "
 # In debian buster the git-compression defaults to gz and does not detect other
 # compression formats.
 GBP_EXTRA_OPTIONS += "--git-compression=xz"
-- 
2.25.1


