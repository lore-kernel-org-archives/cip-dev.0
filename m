Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F905C636D3
	for <webhook@archiver.kernel.org>; Fri, 10 Feb 2023 12:07:45 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.6149.1676001968550009308
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Feb 2023 20:06:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=HTmJeIJC;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-72506-20230210040606329a04828fecd64f17-9fo1so@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230210040606329a04828fecd64f17
        for <cip-dev@lists.cip-project.org>;
        Fri, 10 Feb 2023 05:06:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=b/PI5KraOKL/V/kVevtMIU0uGf7oSI2Y0Uqp1L8cek0=;
 b=HTmJeIJCvDYlcxiq4q+wj/sc0bS0ump3RRRoAYJ72oC0KhpHcUUjIVkcqhoAQSsQ7IvR9O
 kML7D7UQzc+dUDPOIFmPlm4xtiHOkkli7m3oB+nYzqZ2qGRCFfK5hPLrMzcmbcRnoC+OBJc5
 y4Cn/6ecHODz+lrGHC02h/SUPxO1g=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: adriaan.schmidt@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 5/5] refactor verity image creation
Date: Fri, 10 Feb 2023 04:05:32 +0000
Message-Id: <20230210040532.239406-6-felix.moessbauer@siemens.com>
In-Reply-To: <20230210040532.239406-1-felix.moessbauer@siemens.com>
References: <20230210040532.239406-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Feb 2023 12:07:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10655

This patch simplifies the integration of verity with swupdate.
We now directly copy the generated verity image into the swu file,
instead of going via wic. This solves the issue with leading partitions,
shifting the partition layout and resulting in a wrong partition in the
swu file. Further, we cleanup some duplicated variables.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 classes/verity.bbclass               | 7 +------
 kas/opt/ebg-secure-boot-snakeoil.yml | 1 -
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/classes/verity.bbclass b/classes/verity.bbclass
index 154b9e1..747a7ae 100644
--- a/classes/verity.bbclass
+++ b/classes/verity.bbclass
@@ -9,21 +9,16 @@
 # SPDX-License-Identifier: MIT
 #
 
-VERITY_IMAGE_TYPE ?= "squashfs"
-
-inherit ${VERITY_IMAGE_TYPE}
-
 IMAGE_TYPEDEP:verity = "${VERITY_IMAGE_TYPE}"
 IMAGER_INSTALL:verity += "cryptsetup"
 
+VERITY_IMAGE_TYPE ?= "squashfs"
 VERITY_INPUT_IMAGE ?= "${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}"
 VERITY_OUTPUT_IMAGE ?= "${IMAGE_FULLNAME}.verity"
 VERITY_IMAGE_METADATA = "${VERITY_OUTPUT_IMAGE}.metadata"
 VERITY_HASH_BLOCK_SIZE ?= "1024"
 VERITY_DATA_BLOCK_SIZE ?= "1024"
 
-IMAGER_INSTALL += "cryptsetup"
-
 create_verity_env_file() {
 
     local ENV="${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.verity.env"
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index 8f2b7bb..3d0e3c9 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -16,7 +16,6 @@ header:
 
 local_conf_header:
   secure-boot-image: |
-    IMAGE_CLASSES += "verity"
     IMAGE_FSTYPES = "wic"
     IMAGE_TYPEDEP:wic += "verity"
     SWU_ROOTFS_TYPE = "verity"
-- 
2.34.1


