Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AF2ECD6FA
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 13:02:04 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44454.1770901318745913641
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Feb 2026 05:01:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm2 header.b=dyLIktpZ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1330684-2026021213015670f62b21aa00020781-3b8lsq@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2026021213015670f62b21aa00020781
        for <cip-dev@lists.cip-project.org>;
        Thu, 12 Feb 2026 14:01:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=fOklOEkzZqsxWWl/Nh+q+P9bktsz1WqG/jbGZttPeV8=;
 b=dyLIktpZH/NbI01grDG92gGzkbEyhf4xu96dcJdy5lyoRbyTBW4fxLUG4/DPKer1L5IykL
 /dXpCRfPAXqed2mRLkPmIN6Wye+Ehko8Bk6CR6iyfDhZnI8cyO1Ka0Vgq8wKbhdkDsXEidUL
 hNkNxmDeXTeU/YcoVobKB+R0hrMVP4d7ubwvZ93l3igGbQeTPrg6pMKWM3hna+HnN2kiWyHI
 4gkC6hoOetmuEEbRFb90ZKuSAk5pfZ+GncemiIhX1nICRKrVNtONFd1cgqwiqlxgn9DTpO0Z
 tTdBx4TqkgsbUHL0rfdbCIFIGAxFqydEGh1LlxVoT302QaereraXA+Cg==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	jan.kiszka@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v2 1/1] swupdate: Enforce signing and verification for swupdate by default.
Date: Thu, 12 Feb 2026 14:01:41 +0100
Message-ID: <20260212130141.709378-2-alexander.heinisch@siemens.com>
In-Reply-To: <20260212130141.709378-1-alexander.heinisch@siemens.com>
References: <20260212130141.709378-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Feb 2026 13:02:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21863

From: Alexander Heinisch <alexander.heinisch@siemens.com>

Aligned defaults for SWU_SIGNED to enforce signing of swu files
as well as verification in swupdate binary.

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 classes-recipe/swupdate.bbclass    | 2 +-
 recipes-core/images/swupdate.inc   | 2 +-
 recipes-core/swupdate/swupdate.inc | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/classes-recipe/swupdate.bbclass b/classes-recipe/swupdate.bbclass
index 59dab9f..962e526 100644
--- a/classes-recipe/swupdate.bbclass
+++ b/classes-recipe/swupdate.bbclass
@@ -39,7 +39,7 @@ SWU_KERNEL_ARTIFACT_NAME = "${@ '${SWU_DELTA_UPDATE_KERNEL_ARTIFACT}' \
 SWU_IMAGE_FILE ?= "${IMAGE_FULLNAME}"
 SWU_DESCRIPTION_FILE ?= "sw-description"
 SWU_ADDITIONAL_FILES ?= "${SWU_KERNEL_ARTIFACT_NAME} ${SWU_ROOTFS_ARTIFACT_NAME}"
-SWU_SIGNED ??= ""
+SWU_SIGNED ??= "1"
 SWU_SIGNATURE_EXT ?= "sig"
 SWU_SIGNATURE_TYPE ?= "cms"

diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 00e972e..2f06081 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -32,7 +32,7 @@ SWU_COMPRESSION_TYPE = ""
 # is used. This images are stored in separate partitions.
 RO_ROOTFS_EXCLUDE_DIRS = "boot var home"

-SWU_SIGNED ?= "1"
+SWU_SIGNED ??= "1"
 SWU_HW_COMPAT ?= "cip-core-1.0"
 IMAGER_BUILD_DEPS:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 IMAGER_INSTALL:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
index c92b14a..4f953b8 100644
--- a/recipes-core/swupdate/swupdate.inc
+++ b/recipes-core/swupdate/swupdate.inc
@@ -32,6 +32,7 @@ def get_bootloader_dependencies(d):
 DEPENDS += "${@get_bootloader_dependencies(d)}"
 DEPENDS += "${@bb.utils.contains('DEB_BUILD_PROFILES', 'mtd', 'mtd-utils', '', d)}"

+SWU_SIGNED ??= "1"
 DEB_BUILD_PROFILES += "${@'pkg.swupdate.nosigning' if not bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"

 # add cross build and deactivate testing for arm based builds
--
2.47.3


