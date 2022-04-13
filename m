Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1676C47087
	for <webhook@archiver.kernel.org>; Wed, 13 Apr 2022 15:48:06 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web08.3505.1649834200264054053
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 00:16:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=WsQApROt;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227,
 mailfrom: fm-294854-202204130716411a3e4158f393195e36-_z75p9@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 202204130716411a3e4158f393195e36
        for <cip-dev@lists.cip-project.org>;
        Wed, 13 Apr 2022 09:16:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=XIpjY0U3erg0ZlLX/Cx0Fqh/8h51dE8tsuTThC+Zw1M=;
 b=WsQApROtD3s5Qk43hJbswb7IzWHw1oUgXp9ocMG8ZFYNfe9BE2H/7XsQRCN/WoM2Mjf2Lb
 1eopq7HTi6jIMPYTj1sbTrVEChLmTbvAFsGHAtDGRXXUj10M8CSs0Fy3rSyYH2gSNK75payh
 OX+fh4SqCN8CNVqOTm4GsNOZvh9CY=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 11/19] cip-core-image: Do not include
 swupdate.inc unless it is used
Date: Wed, 13 Apr 2022 09:16:28 +0200
Message-Id: 
 <a7c18fa36c9afc6f4c52d174d3545dfefe51b749.1649834193.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1649834193.git.jan.kiszka@siemens.com>
References: <cover.1649834193.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Apr 2022 15:48:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8059

From: Jan Kiszka <jan.kiszka@siemens.com>

Was harmless to do so for non-swupdate images, but also unneeded.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas/opt/ebg-secure-boot-snakeoil.yml  | 5 +++--
 kas/opt/swupdate.yml                  | 3 +++
 recipes-core/images/cip-core-image.bb | 5 ++---
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index 28b3545..be58b15 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -15,8 +15,9 @@ header:
    - kas/opt/efibootguard.yml
 
 local_conf_header:
-  image-options: |
-    CIP_IMAGE_OPTIONS_append = " read-only.inc"
+  image-options-swupdate-ro: |
+    CIP_IMAGE_OPTIONS_append = " swupdate.inc read-only.inc"
+
   swupdate: |
     IMAGE_INSTALL_append = " swupdate"
     IMAGE_INSTALL_append = " swupdate-handler-roundrobin"
diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index a8b903f..1b2aff4 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -19,6 +19,9 @@ local_conf_header:
     IMAGE_INSTALL_append = " swupdate"
     IMAGE_INSTALL_append = " swupdate-handler-roundrobin"
 
+  image-option-swupdate: |
+    CIP_IMAGE_OPTIONS_append = " swupdate.inc"
+
   wic-swu: |
     IMAGE_FSTYPES = "wic-swu-img"
     WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
index 9bf21ff..ecba06d 100644
--- a/recipes-core/images/cip-core-image.bb
+++ b/recipes-core/images/cip-core-image.bb
@@ -11,12 +11,11 @@
 
 inherit image
 inherit image_uuid
+
 ISAR_RELEASE_CMD = "git -C ${LAYERDIR_cip-core} describe --tags --dirty --always --match 'v[0-9].[0-9]*'"
 DESCRIPTION = "CIP Core image"
 
 IMAGE_INSTALL += "customizations"
 
-# for swupdate
-SWU_DESCRIPTION ??= "swupdate"
-CIP_IMAGE_OPTIONS ?= "${SWU_DESCRIPTION}.inc"
+CIP_IMAGE_OPTIONS ?= ""
 include ${CIP_IMAGE_OPTIONS}
-- 
2.34.1


