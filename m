Return-Path: <srinuvasan.a@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4CEC3DA60
	for <webhook@archiver.kernel.org>; Thu, 18 Jul 2024 10:57:50 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.12551.1721300261628727276
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jul 2024 03:57:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=srinuvasan.a@siemens.com header.s=fm2 header.b=t35pQ/Rz;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1324425-202407181057388e0e8816fb9931ecb6-934z7t@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202407181057388e0e8816fb9931ecb6
        for <cip-dev@lists.cip-project.org>;
        Thu, 18 Jul 2024 12:57:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=srinuvasan.a@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Pr8TGaj1srp3TFdzze39Lc59jU1bfxgh5eikBIB1X18=;
 b=t35pQ/RzJBxH9S4xQLR2ywjKsr1ss5nhYmBtAwVDRcDyggWrn8CPwyiHc0c/IAKM445yXN
 ruEM8Prsxdbu/9ClPHZ+OEoXUmggDU5fHH4Ocnuxl9D6eHSl6e71c0zD5bXDOLnv/U1GSE6Y
 VAkbDr1425plXB1G8QLBgaidAB9n8=;
From: srinuvasan.a@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core] [PATCH] classes/squashfs: exclude boot dir during squshfs image creation
Date: Thu, 18 Jul 2024 16:27:18 +0530
Message-Id: <20240718105718.11562-1-srinuvasan.a@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1324425:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jul 2024 10:57:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16585

From: Srinuvasan A <srinuvasan.a@siemens.com>

For all the UEFI based bsps we used bootloader as efi bootguard, this
linux.efi contains necessary boot files to boot the system, hence remove
the boot content from squash root filesystem.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 classes/squashfs.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/squashfs.bbclass b/classes/squashfs.bbclass
index b39be0c..f9c7bf4 100644
--- a/classes/squashfs.bbclass
+++ b/classes/squashfs.bbclass
@@ -22,7 +22,7 @@ def get_free_mem():
 
 IMAGER_INSTALL:squashfs += "squashfs-tools"
 
-SQUASHFS_EXCLUDE_DIRS ?= ""
+SQUASHFS_EXCLUDE_DIRS ?= "boot"
 SQUASHFS_CONTENT ?= "${PP_ROOTFS}"
 SQUASHFS_CREATION_ARGS ?= ""
 
-- 
2.34.1


