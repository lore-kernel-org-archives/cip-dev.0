Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4572C4332F
	for <webhook@archiver.kernel.org>; Thu, 10 Nov 2022 12:45:10 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.6911.1668084308196319483
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Nov 2022 04:45:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=ZiYiwdQZ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-202211101245053d29490b7c48a7e9f0-ggwyfn@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202211101245053d29490b7c48a7e9f0
        for <cip-dev@lists.cip-project.org>;
        Thu, 10 Nov 2022 13:45:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=b/QYV4UkerO761+B8jJS7feuEFj282lpPZfy/Dx9jAk=;
 b=ZiYiwdQZf4sWgK9XPWu9y9MrUMP7pC972YonwZ9S8wzN22AkS5GOR85kDZ+TtlrE1xKe0s
 wLMipcaThVAK5CPxTJ/DSZWaBNKTkmkmgT+GThQowmxyhhRrvQJojQvv+YzTMQ5XyblzlvcC
 3nexOcww92Y1DkkPZNmtwliaqdGew=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	christian.storm@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 1/5] core/images/swupdate.inc: Move image_uuid to swupdate.inc
Date: Thu, 10 Nov 2022 13:44:59 +0100
Message-Id: <20221110124503.274124-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20221110124503.274124-1-Quirin.Gylstorff@siemens.com>
References: <20221110124503.274124-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Nov 2022 12:45:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9997

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Prerequisite for the changes to check the uuid.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/ebg-swu.yml                |  2 +-
 recipes-core/images/image-uuid.inc | 12 ------------
 recipes-core/images/swupdate.inc   |  1 +
 3 files changed, 2 insertions(+), 13 deletions(-)
 delete mode 100644 recipes-core/images/image-uuid.inc

diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
index ce37c36..6aa411b 100644
--- a/kas/opt/ebg-swu.yml
+++ b/kas/opt/ebg-swu.yml
@@ -20,7 +20,7 @@ local_conf_header:
     SWUPDATE_BOOTLOADER = "efibootguard"
     IMAGE_INSTALL_remove = "u-boot-script"
   ebg_swu_image_options: |
-    CIP_IMAGE_OPTIONS_append = " efibootguard.inc image-uuid.inc"
+    CIP_IMAGE_OPTIONS_append = " efibootguard.inc"
   initramfs: |
     INITRAMFS_INSTALL_append = " initramfs-abrootfs-hook"
   firmware-binaries: |
diff --git a/recipes-core/images/image-uuid.inc b/recipes-core/images/image-uuid.inc
deleted file mode 100644
index 5e5a727..0000000
--- a/recipes-core/images/image-uuid.inc
+++ /dev/null
@@ -1,12 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2022
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-inherit image_uuid
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index edc41a0..6cf9bb1 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -9,6 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
+inherit image_uuid
 inherit swupdate
 inherit read-only-rootfs
 
-- 
2.35.1


