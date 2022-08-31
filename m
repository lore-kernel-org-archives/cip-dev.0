Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02AEECAAD4
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 07:36:09 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.22725.1661931368104827723
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 00:36:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=bv7Zsuzk;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225,
 mailfrom: fm-294854-2022083107312483c17e78b2bddfc950-rd3lt9@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 2022083107312483c17e78b2bddfc950
        for <cip-dev@lists.cip-project.org>;
        Wed, 31 Aug 2022 09:36:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=GbszdSrOuvVrIMi0+MYxuwahDUoLUZNTuSCDh7yIsVY=;
 b=bv7ZsuzkEQYLI1MzX8HKiwU5y1cPk2B5tpM0EJj6F4x10va07WW4onNxn5xzuHDtbXxpNL
 o8iiUjjF5oOy4qv8dvzIacGr9xYH7p3gj/vreuZu8cWoKZDadsSk2PrKVlmvEZn1PVjfvFuT
 bWqxuBib5lSrVAGOw2mSniGxlgmtg=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 5/6] swupdate: Drop u-boot-script from EFI Boot
 Guard images
Date: Wed, 31 Aug 2022 09:31:20 +0200
Message-Id: 
 <d552cf4cff74bb9c3b1948c70643797daa18ca4c.1661931081.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1661931081.git.jan.kiszka@siemens.com>
References: <cover.1661931081.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 07:36:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9333

From: Jan Kiszka <jan.kiszka@siemens.com>

This package is used for legacy distro boot via U-Boot, but that is not
needed/used when UEFI is activated. Make sure the package is not
installed, even if a machine config pulled it in.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas/opt/ebg-swu.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
index e0bbe2e..8b3ffec 100644
--- a/kas/opt/ebg-swu.yml
+++ b/kas/opt/ebg-swu.yml
@@ -18,6 +18,7 @@ local_conf_header:
   ebg_swu_bootloader: |
     WKS_FILE ?= "${MACHINE}-efibootguard.wks.in"
     SWUPDATE_BOOTLOADER = "efibootguard"
+    IMAGE_INSTALL_remove = "u-boot-script"
   ebg_swu_image_options: |
     CIP_IMAGE_OPTIONS_append = " efibootguard.inc image-uuid.inc"
   initramfs: |
-- 
2.35.3


