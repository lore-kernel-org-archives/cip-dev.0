Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8CAEEA854
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 21:40:27 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.56985.1770932418227812249
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Feb 2026 13:40:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm2 header.b=DT9GeVk2;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-1330684-20260212214016272cf88f6300020729-r2dvkp@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20260212214016272cf88f6300020729
        for <cip-dev@lists.cip-project.org>;
        Thu, 12 Feb 2026 22:40:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=wcQLlpSOntTh6i9JX785Y5vsi+GXuIK5I/4kWEoqko0=;
 b=DT9GeVk2D8iMxgsLKx5OOdnsLNW9q+mzCBpg/Pv62Oaer2oGIyTge7BQINdlcZ7MrvMGOO
 D0PGAMx6qLay6BH69HD5Z8Npjd6MzO+qALFDo7wOIyudEF4WRUToD/kcuD64aezm6VB5VSm4
 3BjTkBXUpeP+vCGcYjBfKV6nl3SEbRuOffwFwZlpt0PG9KmSBA36wlBcpvlLRUc09mfqJNxe
 IAMiaVgBR++0kftZU/VDhbqTaCeJeACTHFDvNsVcDh18sO2s+7X8GYmZfeeDSkJZTOkC85Mo
 xS3ANESEND2iNOCChoa64PhZG1zehOFfPnQ7CWYA3JffMfk6t5qk+tCA==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	jan.kiszka@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v3 1/1] swupdate: Enforce signing and verification for swupdate by default.
Date: Thu, 12 Feb 2026 22:40:03 +0100
Message-ID: <20260212214003.734787-2-alexander.heinisch@siemens.com>
In-Reply-To: <20260212214003.734787-1-alexander.heinisch@siemens.com>
References: <20260212214003.734787-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Feb 2026 21:40:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21866

From: Alexander Heinisch <alexander.heinisch@siemens.com>

Aligned defaults for SWU_SIGNED to enforce signing of swu files
as well as verification in swupdate binary.

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 classes-recipe/swupdate.bbclass    | 4 ++--
 recipes-core/swupdate/swupdate.inc | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/classes-recipe/swupdate.bbclass b/classes-recipe/swupdate.bbclass
index 59dab9f..d92d55f 100644
--- a/classes-recipe/swupdate.bbclass
+++ b/classes-recipe/swupdate.bbclass
@@ -39,6 +39,8 @@ SWU_KERNEL_ARTIFACT_NAME = "${@ '${SWU_DELTA_UPDATE_KERNEL_ARTIFACT}' \
 SWU_IMAGE_FILE ?= "${IMAGE_FULLNAME}"
 SWU_DESCRIPTION_FILE ?= "sw-description"
 SWU_ADDITIONAL_FILES ?= "${SWU_KERNEL_ARTIFACT_NAME} ${SWU_ROOTFS_ARTIFACT_NAME}"
+
+# Including swupdate.inc in CIP_IMAGE_OPTIONS enables signing by default.
 SWU_SIGNED ??= ""
 SWU_SIGNATURE_EXT ?= "sig"
 SWU_SIGNATURE_TYPE ?= "cms"
@@ -52,8 +54,6 @@ IMAGE_TYPEDEP:swu = "${@ '${SWU_DELTA_UPDATE_ARTIFACT_TYPE}' \
     else '${SWU_UPDATE_ARTIFACT_TYPE}' }"
 
 IMAGER_INSTALL:swu += "cpio coreutils"
-IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
-
 
 IMAGE_SRC_URI:swu = "file://${SWU_DESCRIPTION_FILE}.tmpl"
 IMAGE_SRC_URI:swu += "file://${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
index c92b14a..1f9eda5 100644
--- a/recipes-core/swupdate/swupdate.inc
+++ b/recipes-core/swupdate/swupdate.inc
@@ -32,6 +32,7 @@ def get_bootloader_dependencies(d):
 DEPENDS += "${@get_bootloader_dependencies(d)}"
 DEPENDS += "${@bb.utils.contains('DEB_BUILD_PROFILES', 'mtd', 'mtd-utils', '', d)}"
 
+SWU_SIGNED ?= "1"
 DEB_BUILD_PROFILES += "${@'pkg.swupdate.nosigning' if not bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 
 # add cross build and deactivate testing for arm based builds
-- 
2.47.3


