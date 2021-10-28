Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A74C433F5
	for <webhook@archiver.kernel.org>; Thu, 28 Oct 2021 11:16:29 +0000 (UTC)
Received: from esa4.mentor.iphmx.com (esa4.mentor.iphmx.com [68.232.137.252])
 by mx.groups.io with SMTP id smtpd.web12.11411.1635419788125035351
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 Oct 2021 04:16:28 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.137.252, mailfrom: srinuvasan_a@mentor.com)
IronPort-SDR: 
 IwooIemloBfPAijAreHERyVoQGvQoCr1QO7ZgwRz/gQBt9LCFulmp8XGA/XIPDjxp+H3SRUE5a
 G3+nB+8Sm4FqlBrchpnA1rnAbpIHXY1k4cVnuafzV9fZ+43n9zFKtKxp0aEnzGPyaqBeEWfGy5
 GE6q9ZWkQMLf8XV7dME0uYMRg5Rr8lLiXPzwV60Fjxyaf/L+b4Tsz53Z0825/AQqRLTQxXlwyV
 AO8Q39rXGrfCUdJPkvY5pbOQC0vFiuXUPB9W99vxhmwocM8jjfaYI1mTldnU4j+ZRP2dFyR3OP
 MQ59F6904/GayL1HlzgvDly6
X-IronPort-AV: E=Sophos;i="5.87,189,1631606400";
   d="scan'208";a="67739488"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa4.mentor.iphmx.com with ESMTP; 28 Oct 2021 03:16:26 -0800
IronPort-SDR: 
 pEiejkjLATU2zKUnpvJG1OmwsupCZAZmuwwGzGVj/F+LQAXOENs0XD2ynnuTyK/PH4TWrRl4oV
 HWpoo5ck2JeWNE4FGM1OEKWFwyph7SK90020OJ2G5FxwhAZRIsF6iklVVdNzxbKZdZA6StMxTF
 tObtkhGRy0BIDT9nzztDtLKuheoCFjNXT92E49HwH6V46K0abonAuCaOs5hxD+OFIi29ar/k6c
 w/cH2AiFSi/zBozPw22k7gc8sYOjWMdFKxwaQPyB9PGCRt8tyicWtorMWbW3V6SKDzMELw0CEq
 X/s=
From: Srinuvasan A <Srinuvasan_A@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: Srinuvasan A <srinuvasan_a@mentor.com>
Subject: [isar-cip-dev] [PATCH] recipes-core/swupdate: Update the SRC_URI and
 SWUPDATE_BUILD_PROFILES append for buster
Date: Thu, 28 Oct 2021 16:45:44 +0530
Message-ID: <20211028111544.603217-1-Srinuvasan_A@mentor.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Oct 2021 11:16:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6845

From: Srinuvasan A <srinuvasan_a@mentor.com>

When we build the swupdate debian package for buster some build
dependency packages are not available in stable buster, hence we created a
patch in cip-core upstream for buster build, here we hardcoded the distro
for buster build hence it is building fine in cip-core not the
downstream layer, added the "DISTRO" variable to pick the proper distro name.

Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
---
 recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
index a451b55..f8298f0 100644
--- a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
+++ b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
@@ -35,14 +35,14 @@ SWUPDATE_BUILD_PROFILES += "pkg.swupdate.nosigning pkg.swupdate.noencryption"
 # SWUPDATE_BUILD_PROFILES += "pkg.swupdate.embeddedlua"
 
 # modify for debian buster build
-SRC_URI_append_cip-core-buster = " file://0009-debian-prepare-build-for-isar-debian-buster.patch"
+SRC_URI_append_${DISTRO} = " file://0009-debian-prepare-build-for-isar-debian-buster.patch"
 
 # disable documentation due to missing packages in debian buster
 # disable create filesystem due to missing symbols in debian buster
 # disable webserver due to missing symbols in debian buster
-SWUPDATE_BUILD_PROFILES_append_cip-core-buster = " nodoc \
-                                                   pkg.swupdate.nocreatefs \
-                                                   pkg.swupdate.nowebserver "
+SWUPDATE_BUILD_PROFILES_append_${DISTRO} = " nodoc \
+                                             pkg.swupdate.nocreatefs \
+                                             pkg.swupdate.nowebserver "
 # In debian buster the git-compression defaults to gz and does not detect other
 # compression formats.
 GBP_EXTRA_OPTIONS += "--git-compression=xz"
-- 
2.25.1


