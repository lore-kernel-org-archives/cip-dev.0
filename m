Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0C1C4332F
	for <webhook@archiver.kernel.org>; Wed, 16 Feb 2022 13:05:05 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net
 (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web08.11526.1645016703721773797
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Feb 2022 05:05:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1
 header.b=edLmYRbJ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228,
 mailfrom: fm-51332-20220216130319ff75ff59c6764131fc-yyhwj3@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id
 20220216130319ff75ff59c6764131fc
        for <cip-dev@lists.cip-project.org>;
        Wed, 16 Feb 2022 14:05:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=ONjljQQtujKvrHsGlXz9Lgye1KJYaWZPtJySx8QaAZU=;
 b=edLmYRbJ52ibdxioQK76Q3Edf4zWX4N9gpG2mPrM6BXDBk/AMB/l+6iWPXmARTSrBNdHP2
 tGrukfNnrj4BNEkU7tCUOkjfWK/5wSzIChFi1sHsEqaGfbi706tQwrJkWU2icGpjy+IuAv2d
 UdI2uctTqPgm77dgQNmLnMfEkG+RU=;
From: Quirin.Gylstorff@siemens.com
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 2/2] swupdate: Convert to
 DEB_BUILD_PROFILES
Date: Wed, 16 Feb 2022 14:03:17 +0100
Message-Id: <20220216130317.3018990-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20220216130317.3018990-1-Quirin.Gylstorff@siemens.com>
References: <20220216130317.3018990-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Feb 2022 13:05:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7618

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/swupdate/swupdate.inc                   | 12 ++----------
 .../swupdate/swupdate_2021.11-1+debian-gbp.bb        | 11 ++++-------
 2 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
index 7812ae7..f2d478d 100644
--- a/recipes-core/swupdate/swupdate.inc
+++ b/recipes-core/swupdate/swupdate.inc
@@ -23,7 +23,7 @@ def get_bootloader_build_profile(d):
         return "pkg.swupdate.uboot"
     return ""
 
-SWUPDATE_BUILD_PROFILES += "${@get_bootloader_build_profile(d)}"
+DEB_BUILD_PROFILES += "${@get_bootloader_build_profile(d)}"
 
 def get_bootloader_dependencies(d):
     bootloader = d.getVar("SWUPDATE_BOOTLOADER") or ""
@@ -37,15 +37,7 @@ def get_bootloader_dependencies(d):
     return ""
 
 DEPENDS += "${@get_bootloader_dependencies(d)}"
-DEPENDS += "${@bb.utils.contains('SWUPDATE_BUILD_PROFILES', 'mtd', 'mtd-utils', '', d)}"
-
-do_install_builddeps_prepend() {
-    export DEB_BUILD_PROFILES="${SWUPDATE_BUILD_PROFILES}"
-}
-
-dpkg_runbuild_prepend() {
-    export DEB_BUILD_PROFILES="${SWUPDATE_BUILD_PROFILES}"
-}
+DEPENDS += "${@bb.utils.contains('DEB_BUILD_PROFILES', 'mtd', 'mtd-utils', '', d)}"
 
 python do_check_bootloader () {
     bootloader = d.getVar("SWUPDATE_BOOTLOADER") or "None"
diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
index 699dad3..bf060b4 100644
--- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
+++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
@@ -28,25 +28,22 @@ SRC_URI += "file://0001-debian-config-Make-image-encryption-optional.patch \
 # end patching for dm-verity based images
 
 # deactivate signing and encryption for simple a/b rootfs update
-SWUPDATE_BUILD_PROFILES += "pkg.swupdate.nosigning pkg.swupdate.noencryption"
+DEB_BUILD_PROFILES += "pkg.swupdate.nosigning pkg.swupdate.noencryption"
 
 # add cross build and deactivate testing for arm based builds
-SWUPDATE_BUILD_PROFILES += "cross nocheck"
+DEB_BUILD_PROFILES += "cross nocheck"
 # If the luahandler shall be embedded into the swupdate binary
 # include the following lines.
 # DEPENDS += "swupdate-handlers"
 # GBP_DEPENDS += "swupdate-handlers"
-# SWUPDATE_BUILD_PROFILES += "pkg.swupdate.embeddedlua"
+# DEB_BUILD_PROFILES += "pkg.swupdate.embeddedlua"
 
 # modify for debian buster build
 SRC_URI_append_buster = " file://0009-debian-prepare-build-for-isar-debian-buster.patch"
 
-# disable documentation due to missing packages
-SWUPDATE_BUILD_PROFILES_append = " nodoc "
-
 # disable create filesystem due to missing symbols in debian buster
 # disable webserver due to missing symbols in debian buster
-SWUPDATE_BUILD_PROFILES_append_buster = " \
+DEB_BUILD_PROFILES_append_buster = " \
                                    pkg.swupdate.nocreatefs \
                                    pkg.swupdate.nowebserver "
 # In debian buster the git-compression defaults to gz and does not detect other
-- 
2.34.1


