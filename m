Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A2FC47081
	for <webhook@archiver.kernel.org>; Wed, 13 Apr 2022 15:48:06 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.3439.1649834201007022100
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 00:16:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=L5zt3V99;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227,
 mailfrom: fm-294854-202204130716381e15ab7788a120bbcb-qnmqlu@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 202204130716381e15ab7788a120bbcb
        for <cip-dev@lists.cip-project.org>;
        Wed, 13 Apr 2022 09:16:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=2lLgbvhssjcBsutXkX5BwwXU5sIgS+xvwGYj+OR3mks=;
 b=L5zt3V99rZjEX7i8JBWSnoUixe9YEoMIEZQO8XK4AIDkk6BdoTmn3PyGznRDBK+DtO1I9x
 K8wG17hUw+CUTRGaDWRVrj2LocLLKkayKyd+xcsdw8MWRUak3TeoDD9zG2djr91QkvkP9fLs
 RUeSo/cMh7GjwS4w46m0lRhXJQW8U=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 05/19] Drop initramfs-abrootfs-secureboot
 references
Date: Wed, 13 Apr 2022 09:16:22 +0200
Message-Id: 
 <6d0bd2b8f9a8f3ba4364934d3de70495df5c07cb.1649834193.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8052

From: Jan Kiszka <jan.kiszka@siemens.com>

As secure boot implies for isar-cip-core dm-verity with read-only
rootfs, we only added initramfs-abrootfs-secureboot to remove it again.
So don't reference it at all. It will be used differently soon,
therefore keep the recipe.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas/opt/ebg-secure-boot-base.yml  | 3 +--
 recipes-core/images/read-only.inc | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/kas/opt/ebg-secure-boot-base.yml b/kas/opt/ebg-secure-boot-base.yml
index 8f769b6..299b663 100644
--- a/kas/opt/ebg-secure-boot-base.yml
+++ b/kas/opt/ebg-secure-boot-base.yml
@@ -15,7 +15,6 @@ header:
    - kas/opt/efibootguard.yml
 
 local_conf_header:
-  initramfs: |
-    IMAGE_INSTALL += "initramfs-abrootfs-secureboot"
+  secure_swu: |
     SWU_DESCRIPTION = "secureboot"
     SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG = "secureboot/swupdate.handler.${SWUPDATE_BOOTLOADER}.ini"
diff --git a/recipes-core/images/read-only.inc b/recipes-core/images/read-only.inc
index 604caa0..c031e39 100644
--- a/recipes-core/images/read-only.inc
+++ b/recipes-core/images/read-only.inc
@@ -14,7 +14,6 @@ SQUASHFS_EXCLUDE_DIRS += "home var"
 IMAGE_INSTALL += "etc-overlay-fs"
 IMAGE_INSTALL += "home-fs"
 IMAGE_INSTALL += "tmp-fs"
-IMAGE_INSTALL_remove += "initramfs-abrootfs-secureboot"
 
 image_configure_fstab() {
     sudo tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
-- 
2.34.1


