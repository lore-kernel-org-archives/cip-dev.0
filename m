Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE129C433EF
	for <webhook@archiver.kernel.org>; Tue,  2 Nov 2021 10:41:57 +0000 (UTC)
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by mx.groups.io with SMTP id smtpd.web11.7385.1635849716391486984
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Nov 2021 03:41:56 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.137.180, mailfrom: srinuvasan_a@mentor.com)
IronPort-SDR: 
 d0ngu/gErjBlRa8N6hnIBAt3ch6XUqYkbslx38HHQHKMBvV0llAdRTElA7Y/AY8JYZf1K4rX6T
 Owhd0pO7+vyc5yC+jG9MxUutEkK+C0sA5c5OZ6ogfEPFBT/IFKUN2MoLn9Ud5GIEHT44L4ITSJ
 JnvodPye1M9Qh8Wc1p+6ua8dflMTDYqhDvCusxt9Xrmaj9XZf6/Am7sRfo6U7T2t9ZcoVosd1I
 732cNS8ynYmG+p39I6QldfNWcKrXx2E8GXZPsCYQ85XC7asfuxoq++VkqcLLaCpC0EYzWc1ruU
 s2kqZ5DQhXF9kF73+LpQ/1mH
X-IronPort-AV: E=Sophos;i="5.87,202,1631606400";
   d="scan'208";a="67796010"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa3.mentor.iphmx.com with ESMTP; 02 Nov 2021 02:41:54 -0800
IronPort-SDR: 
 eZq3oHm0YT2Zicsvm+Px8hEVM71mi9bumUFAUM+XIJE7mqmhnWTaGkBzaQPDA+Pk0R0X9ir81b
 epwUSNdKESpTXzJky9fTttZr5mWB4M4dwo4ApA3O5jSiN0mj3C4MFXiKZcF8zYpQvCyjFhbgfm
 SF8niae04ZBCWUxEYKvtCNMdIGvKhfNfDf+fAMZ3pWB3fJYRlYpb2Zew6a356Qj6rM/LLHdR3s
 ZwsK7nfwxQQ701uhBqbMxybkRRTu8j8LztWkfdpFHrYlormJwF+jN8ETIaOTSfeohg21AlyHBp
 0js=
From: Srinuvasan A <Srinuvasan_A@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: Srinuvasan A <srinuvasan_a@mentor.com>
Subject: [isar-cip-dev] [PATCH] recipes-core/swupdate: Update the SRC_URI and
 SWUPDATE_BUILD_PROFILES append for buster
Date: Tue, 2 Nov 2021 16:11:34 +0530
Message-ID: <20211102104134.648307-1-Srinuvasan_A@mentor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <af7d7e65-12b2-2e1a-7ad2-d692a737d0ea@siemens.com>
References: <af7d7e65-12b2-2e1a-7ad2-d692a737d0ea@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Nov 2021 10:41:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6852

From: Srinuvasan A <srinuvasan_a@mentor.com>

When we build the swupdate debian package for buster some build
dependency packages are not available in stable buster repo, hence we created a
patch in cip-core upstream for buster build, here we hardcoded the distro
for buster build hence it is building fine in cip-core not the downstream layer,
added the OVERRIDES for BASE_DISTRO_CODENAME to select the particular base distro.

Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
---
 recipes-core/swupdate/swupdate.inc                     | 2 ++
 recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
index a469587..191aa2b 100644
--- a/recipes-core/swupdate/swupdate.inc
+++ b/recipes-core/swupdate/swupdate.inc
@@ -13,6 +13,8 @@ HOMEPAGE= "https://github.com/sbabic/swupdate"
 LICENSE = "GPL-2.0"
 LIC_FILES_CHKSUM = "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=751419260aa954499f7abaabaa882bbe"
 
+OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"
+
 def get_bootloader_build_profile(d):
     bootloader = d.getVar("SWUPDATE_BOOTLOADER") or ""
     if bootloader == "efibootguard":
diff --git a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
index a451b55..e62230f 100644
--- a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
+++ b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
@@ -35,14 +35,14 @@ SWUPDATE_BUILD_PROFILES += "pkg.swupdate.nosigning pkg.swupdate.noencryption"
 # SWUPDATE_BUILD_PROFILES += "pkg.swupdate.embeddedlua"
 
 # modify for debian buster build
-SRC_URI_append_cip-core-buster = " file://0009-debian-prepare-build-for-isar-debian-buster.patch"
+SRC_URI_append_buster = " file://0009-debian-prepare-build-for-isar-debian-buster.patch"
 
 # disable documentation due to missing packages in debian buster
 # disable create filesystem due to missing symbols in debian buster
 # disable webserver due to missing symbols in debian buster
-SWUPDATE_BUILD_PROFILES_append_cip-core-buster = " nodoc \
-                                                   pkg.swupdate.nocreatefs \
-                                                   pkg.swupdate.nowebserver "
+SWUPDATE_BUILD_PROFILES_append_buster = " nodoc \
+                                          pkg.swupdate.nocreatefs \
+                                          pkg.swupdate.nowebserver "
 # In debian buster the git-compression defaults to gz and does not detect other
 # compression formats.
 GBP_EXTRA_OPTIONS += "--git-compression=xz"
-- 
2.25.1


