Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D627C4167D
	for <webhook@archiver.kernel.org>; Fri, 12 Nov 2021 11:50:25 +0000 (UTC)
Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web09.14719.1636717820624136660
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Nov 2021 03:50:21 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.40, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 1ACBoIJJ016847
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 12:50:18 +0100
Received: from md2dvrtc.fritz.box ([167.87.35.150])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1ACBoHAh023845;
	Fri, 12 Nov 2021 12:50:18 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Subject: [PATCH] recipes-core/swupdate: Update the SRC_URI and
 SWUPDATE_BUILD_PROFILES append for buster
Date: Fri, 12 Nov 2021 12:50:10 +0100
Message-Id: <20211112115017.401779-3-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211112115017.401779-1-Quirin.Gylstorff@siemens.com>
References: <20211112115017.401779-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 11:50:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6880

From: Srinuvasan A <srinuvasan_a@mentor.com>

When we build the swupdate debian package for buster some build
dependency packages are not available in stable buster repo, hence we created a
patch in cip-core upstream for buster build, here we hardcoded the distro
for buster build hence it is building fine in cip-core not the downstream layer,
added the OVERRIDES for BASE_DISTRO_CODENAME to select the particular base distro.

Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
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
2.30.2


