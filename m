Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC02EC4167D
	for <webhook@archiver.kernel.org>; Tue, 19 Apr 2022 17:48:47 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.1288.1650384422679254422
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Apr 2022 09:07:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=kexM0+ea;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225,
 mailfrom: fm-294854-202204191606594516229fbcb960f25a-ljk7yu@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 202204191606594516229fbcb960f25a
        for <cip-dev@lists.cip-project.org>;
        Tue, 19 Apr 2022 18:06:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=DVa28e3revwltqWwVqd9NCgHW3AJxtMPoEIE6vlQpS0=;
 b=kexM0+eaVcpuz4jvMvRTYFwwZ6kmqri/de8Mm4mYccjibQLHTW4qLaJWICHN5/lD3UIQrI
 q8v8Y16QfYISFE9iLJp7g5hWn6G6dGkIM31hw6v2sukbscy65C97/rA+BYII8OT6uljLwzsX
 WMeH/0fk8kPuXVvJ30uTaeoAN7SNA=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 2/5] verity-img: Inherit the source image type
 class directly
Date: Tue, 19 Apr 2022 18:06:55 +0200
Message-Id: 
 <6659ac3c63809a0adc2065dbd9593cedc79b1d04.1650384418.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1650384418.git.jan.kiszka@siemens.com>
References: <cover.1650384418.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Apr 2022 17:48:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8106

From: Jan Kiszka <jan.kiszka@siemens.com>

VERITY_IMAGE_TYPE defines where the verity-img class takes its input
from. Ensure that this class is present and hook it up directly in
verity-img. Makes the usage of this class more convenient.

Consequently, code can be dropped from the secure-wic-swu-img class.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 classes/secure-wic-swu-img.bbclass |  9 +--------
 classes/verity-img.bbclass         | 10 +++++++---
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/classes/secure-wic-swu-img.bbclass b/classes/secure-wic-swu-img.bbclass
index c2b2402..85342fe 100644
--- a/classes/secure-wic-swu-img.bbclass
+++ b/classes/secure-wic-swu-img.bbclass
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021
+# Copyright (c) Siemens AG, 2021-2022
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -9,12 +9,6 @@
 # SPDX-License-Identifier: MIT
 #
 
-SECURE_IMAGE_FSTYPE ?= "squashfs"
-
-inherit ${SECURE_IMAGE_FSTYPE}-img
-
-VERITY_IMAGE_TYPE = "${SECURE_IMAGE_FSTYPE}"
-
 INITRAMFS_RECIPE ?= "cip-core-initramfs"
 do_wic_image[depends] += "${INITRAMFS_RECIPE}:do_build"
 INITRD_IMAGE = "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}.initrd.img"
@@ -22,5 +16,4 @@ INITRD_IMAGE = "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}.initrd.img"
 inherit verity-img
 inherit wic-swu-img
 
-addtask do_verity_image after do_${SECURE_IMAGE_FSTYPE}_image
 addtask do_wic_image after do_verity_image
diff --git a/classes/verity-img.bbclass b/classes/verity-img.bbclass
index 3c94643..b7d7f08 100644
--- a/classes/verity-img.bbclass
+++ b/classes/verity-img.bbclass
@@ -1,22 +1,26 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021
+# Copyright (c) Siemens AG, 2021-2022
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
 #
 # SPDX-License-Identifier: MIT
 #
-IMAGER_INSTALL += "cryptsetup"
 
 VERITY_IMAGE_TYPE ?= "squashfs"
+
+inherit ${VERITY_IMAGE_TYPE}-img
+
 VERITY_INPUT_IMAGE ?= "${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.img"
 VERITY_OUTPUT_IMAGE ?= "${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img"
 VERITY_IMAGE_METADATA = "${VERITY_OUTPUT_IMAGE}.metadata"
 VERITY_HASH_BLOCK_SIZE ?= "1024"
 VERITY_DATA_BLOCK_SIZE ?= "1024"
 
+IMAGER_INSTALL += "cryptsetup"
+
 create_verity_env_file() {
 
     local ENV="${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.verity.env"
@@ -70,4 +74,4 @@ python do_verity_image() {
     bb.build.exec_func('verity_setup', d)
     bb.build.exec_func('create_verity_env_file', d)
 }
-addtask verity_image before do_image after do_image_tools
+addtask verity_image before do_image after do_${VERITY_IMAGE_TYPE}_image
-- 
2.34.1


