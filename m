Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAC7C77B76
	for <webhook@archiver.kernel.org>; Fri, 14 Apr 2023 11:46:00 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.4896.1681463652687110731
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Apr 2023 02:14:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=mPmfLZ5u;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-72506-202304140914100f0a33eb56fb53d556-n50edg@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202304140914100f0a33eb56fb53d556
        for <cip-dev@lists.cip-project.org>;
        Fri, 14 Apr 2023 11:14:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=bOapytkBMp25lrFv7QTHOf0SNMKeVpjVeg4JvZeEeYA=;
 b=mPmfLZ5uMU8QmanUPAuRay8+mqmeGB3VSPOxKLjip3+TO1NpkbtarSYgBGwiFhZsQtHieC
 erVNXIJmXkUa+BYtvgQbfkmiSYmj7BivRMQu8WXshBrRGL/EeUXM+4fc+FEV43UqkKUkYT8V
 In62t0OOw/L4a583MPAO2zf7GEaFE=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 3/3] disable compression of squashfs swu artifact
Date: Fri, 14 Apr 2023 17:13:48 +0800
Message-Id: <20230414091348.676809-3-felix.moessbauer@siemens.com>
In-Reply-To: <20230414091348.676809-1-felix.moessbauer@siemens.com>
References: <20230414091348.676809-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Apr 2023 11:46:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11222

The squashfs itself is already compressed in the default configuration.
By that, an additional compression of the artifact put into the .swu
file is not required. By disabling this compression, less temporary
space is required when flashing the image onto the target and also the
overhead of the decompression is avoided.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 kas/opt/swupdate.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index 236b3c4..2899d6c 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -21,6 +21,8 @@ local_conf_header:
   wic-swu: |
     IMAGE_TYPEDEP:wic += "squashfs"
     IMAGE_FSTYPES += "swu"
+    # squashfs is already compressed
+    SWU_COMPRESSION_TYPE = ""
     WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
     INITRAMFS_INSTALL:append = " initramfs-squashfs-hook"
     ABROOTFS_PART_UUID_A ?= "fedcba98-7654-3210-cafe-5e0710000001"
-- 
2.39.2


