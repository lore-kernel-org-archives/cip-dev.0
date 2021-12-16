Return-Path: <Vijaikumar_Kanagarajan@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70026C433F5
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 13:36:43 +0000 (UTC)
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by mx.groups.io with SMTP id smtpd.web10.10615.1639661796675434522
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 05:36:42 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.137.180, mailfrom: vijaikumar_kanagarajan@mentor.com)
IronPort-SDR: 
 W8pqS0THQtNujQFV1eCGp3VTuYLQ60bCDJZWsES5SGp1PQdYD6jD1kZt4pDyMb1zoPB1cv6jJu
 o5ahyVZI/mclYzyiBiGUz4gsiJo5lLKgIMTPxS9OGDPI6XR7uO3oiSE5QJubWy11yvZ5O7mHzJ
 f/obBFCtWmH5kLNpDVAmxiD38umOEgzu7OhkRUbM5bLPQ01VACfJBaSp2HzrjgKdvW9nnUBcDD
 5OvcprkOZi6d50nTkf/Gxo49pZHGB4cKiIzdzbsq7XSZETA1B1jp0M2SMlx4HKCONAZlqQZQaj
 oQ1AOJIKm73FYZfnlUBY1CBQ
X-IronPort-AV: E=Sophos;i="5.88,211,1635235200";
   d="scan'208";a="69632707"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa3.mentor.iphmx.com with ESMTP; 16 Dec 2021 05:36:41 -0800
IronPort-SDR: 
 b+W1XLhAdHIBDP0AR6a87kt+ivQw4RUSndge5ORmgzNh/Nzoxpm2YHpwUqQasOKqTEAMXYoNAB
 wZxipv5pt1WL9hhwAYdJvKW7LDLP21c99CoZkMqOYwh1QTZ3shF1qzvl+S89Pt2GdGnxmyeqeW
 S3gL+2QK6sw6LNVRAkEBa0I1W+7Qh0mVhz2YLqQJ+Roj5KOHdZ4oxLDokdhkAPbRAz/2xhXHi+
 o+4ypW10XcWhjwcQptkjAVTKtAFRbnVRkI8CnfY3PKKAKSWZELOs4CM9oGaO+VxZ0Ga+e8b0Aj
 RwI=
From: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
Subject: [isar-cip-core][PATCH v2 2/2] swupdate: Drop conditional includes for
 buster
Date: Thu, 16 Dec 2021 19:06:17 +0530
Message-ID: <20211216133617.3403412-3-Vijaikumar_Kanagarajan@mentor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211216133617.3403412-1-Vijaikumar_Kanagarajan@mentor.com>
References: <20211216133617.3403412-1-Vijaikumar_Kanagarajan@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SVR-ORW-MBX-05.mgc.mentorg.com (147.34.90.205) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 13:36:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7157

Stretch in now dropped. The conditional includes for buster is now not
needed. Those includes are applicable to buster as well as bullseye.

Signed-off-by: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
---
 .../swupdate/swupdate_2021.04-1+debian-gbp.bb        | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
index a4d67fe..51aacfe 100644
--- a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
+++ b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
@@ -44,12 +44,12 @@ SWUPDATE_BUILD_PROFILES += "cross nocheck"
 # modify for debian buster build
 SRC_URI_append_buster = " file://0009-debian-prepare-build-for-isar-debian-buster.patch"
 
-# disable documentation due to missing packages in debian buster
-# disable create filesystem due to missing symbols in debian buster
-# disable webserver due to missing symbols in debian buster
-SWUPDATE_BUILD_PROFILES_append_buster = " nodoc \
-                                          pkg.swupdate.nocreatefs \
-                                          pkg.swupdate.nowebserver "
+# disable documentation due to missing packages
+# disable create filesystem due to missing symbols
+# disable webserver due to missing symbols
+SWUPDATE_BUILD_PROFILES_append = " nodoc \
+                                   pkg.swupdate.nocreatefs \
+                                   pkg.swupdate.nowebserver "
 # In debian buster the git-compression defaults to gz and does not detect other
 # compression formats.
 GBP_EXTRA_OPTIONS += "--git-compression=xz"
-- 
2.25.1


