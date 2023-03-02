Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BA3C7EE37
	for <webhook@archiver.kernel.org>; Thu,  2 Mar 2023 20:31:01 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.5530.1677789059756469286
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Mar 2023 12:31:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=pHAo9F2M;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-20230302203056905a8b7e9a0b14adc6-2a7oaf@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20230302203056905a8b7e9a0b14adc6
        for <cip-dev@lists.cip-project.org>;
        Thu, 02 Mar 2023 21:30:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=FFFrx1w5YHb1KmUEfb7HFMHi5w/cuGfEF2G52gdiCJg=;
 b=pHAo9F2MX6XKfQK1xY73Xs+PoBqihE7PJRLXs5qd4t6J9H5ybqrGOmbDxgXCeR9W6/832B
 JysyAILvM3Sjn/MSfs8zCDFoh2ojH7ESVRBm71s+BHyyuPbHzm5GYSYfMSnFnUm4BqOdvD8+
 0cnzO4WLoXQQpTZDgh/RqYqBotVs0=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>,
	dinesh.kumar@toshiba-tsip.com,
	kazuhiro3.hayashi@toshiba.co.jp,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 2/5] initramfs-*-hook: Avoid open-coding IMAGE_FULLNAME
Date: Thu,  2 Mar 2023 21:30:51 +0100
Message-Id: <4c5c5cddd691665c3ad06ea0740a7a98371fff2c.1677789054.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1677789054.git.jan.kiszka@siemens.com>
References: <cover.1677789054.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Mar 2023 20:31:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10889

From: Jan Kiszka <jan.kiszka@siemens.com>

We can't pull IMAGE_FULLNAME from the image class as this is a dpkg
class, but we should account for potential global changes to this
variable like done by kas/opt/test.yml. This will ensure that we stay
in sync with the generator in image_uuid.bbclass.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb  | 6 +++++-
 .../initramfs-verity-hook/initramfs-verity-hook_0.1.bb      | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb
index 8b1536f3..17c60da4 100644
--- a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb
@@ -20,7 +20,11 @@ SRC_URI += "file://abrootfs.hook \
 
 ABROOTFS_IMAGE_RECIPE ?= "cip-core-image"
 
-IMAGE_UUID_ENV_FILE = "${DEPLOY_DIR_IMAGE}/${ABROOTFS_IMAGE_RECIPE}-${DISTRO}-${MACHINE}.uuid.env"
+# This is defined in image.bbclass which cannot be used in a package recipe.
+# However, we need to use IMAGE_FULLNAME to pick up any extensions of it.
+IMAGE_FULLNAME ??= "${ABROOTFS_IMAGE_RECIPE}-${DISTRO}-${MACHINE}"
+
+IMAGE_UUID_ENV_FILE = "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.uuid.env"
 
 do_install[depends] += "${ABROOTFS_IMAGE_RECIPE}:do_generate_image_uuid"
 do_install[cleandirs] += " \
diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
index 59989081..3fc63ed2 100644
--- a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
@@ -27,7 +27,11 @@ DEBIAN_CONFLICTS = "initramfs-abrootfs-hook"
 
 VERITY_IMAGE_RECIPE ?= "cip-core-image"
 
-VERITY_ENV_FILE = "${DEPLOY_DIR_IMAGE}/${VERITY_IMAGE_RECIPE}-${DISTRO}-${MACHINE}.verity.env"
+# This is defined in image.bbclass which cannot be used in a package recipe.
+# However, we need to use IMAGE_FULLNAME to pick up any extensions of it.
+IMAGE_FULLNAME ??= "${VERITY_IMAGE_RECIPE}-${DISTRO}-${MACHINE}"
+
+VERITY_ENV_FILE = "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.verity.env"
 
 do_install[depends] += "${VERITY_IMAGE_RECIPE}:do_image_verity"
 do_install[cleandirs] += " \
-- 
2.35.3


