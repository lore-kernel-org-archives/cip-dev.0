Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0400D29C41
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 16:25:31 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.38517.1768839929012255477
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jan 2026 08:25:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm1 header.b=AzTdUqGU;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1330684-202601191625274af0ed24090002075e-7gvjsa@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202601191625274af0ed24090002075e
        for <cip-dev@lists.cip-project.org>;
        Mon, 19 Jan 2026 17:25:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=6pe9XR8FlNsW6LHsuhVbFXaVscQiyXbiNeqqXgdZ19s=;
 b=AzTdUqGU2sjD9GxVNqo+XUSurk64kCUepLLLDLunQk54brV4VwWcr9c/dipLcX5c1fuAR1
 7AVatKoF5FYog53TY2jrtNEx7RL/bX+s7cq4JjIL8P27d9w8x0KQ3pv7zE4LaORRO9L+W1Q6
 +J83bpDY27Y5cai9PIaBSogUprZf99E51eUA0vxi5EtGza7O8+FNwIsvqxS7blrswJedToPo
 Ge/UBpyO43tgWIGhUFQ+p/DmAYhe3SR8MgY1N3dJq+o1X7M/io5g3B559DNKg2Gu8lx/unp8
 GlFArc1Il00owNREb4Urk00jof4K3FN4A3d/x4aBvjw0xjllR8lOm3TA==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH 2/2] swupdate: Enforce signing and verification for swupdate by default.
Date: Mon, 19 Jan 2026 17:24:44 +0100
Message-ID: <20260119162444.672037-3-alexander.heinisch@siemens.com>
In-Reply-To: <20260119162444.672037-1-alexander.heinisch@siemens.com>
References: <20260119162444.672037-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Jan 2026 16:25:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21677

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
index 21d881d..ab262f4 100644
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
index 7cd816a..030f95f 100644
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


