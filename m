Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2100EC19F2A
	for <webhook@archiver.kernel.org>; Thu,  4 Aug 2022 12:54:45 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web09.4382.1659617681223446159
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Aug 2022 05:54:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2
 header.b=UPUvQw8W;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225,
 mailfrom: fm-51332-202208041254387aba51bd0949bcf1c8-rqbi1y@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 202208041254387aba51bd0949bcf1c8
        for <cip-dev@lists.cip-project.org>;
        Thu, 04 Aug 2022 14:54:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=HOdtN6LYYgRLD1CUFGrea3Uvi4lCd9kcs4JZU7vfIhQ=;
 b=UPUvQw8WSl7XvEAGltBhsVFfnpbVgx5hb/eMLhoVuAwUoc+k8l7+qVa5iEXmsfNxtHGyln
 lazd1xFgGilCX9HDngGN18vpYtQcIxCqyfdpVlDWSaWEpJR7hXRiyQnaf5J6EqZ9fLay7Wv5
 bKqzqMgYOdeYj0mzA1oj9cCcWQJJc=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] bbb_defconfig: Add missing SDHCI
 Drivers
Date: Thu,  4 Aug 2022 14:54:37 +0200
Message-Id: <20220804125437.715852-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Aug 2022 12:54:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9119

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

To boot from SD/MMC wit kernel 5.10. new config option need to
be enabled.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/files/bbb_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/recipes-kernel/linux/files/bbb_defconfig b/recipes-kernel/linux/files/bbb_defconfig
index 31e15e6..8f8f1aa 100644
--- a/recipes-kernel/linux/files/bbb_defconfig
+++ b/recipes-kernel/linux/files/bbb_defconfig
@@ -374,6 +374,9 @@ CONFIG_USB_CONFIGFS_F_HID=y
 CONFIG_USB_ZERO=m
 CONFIG_USB_G_NOKIA=m
 CONFIG_MMC=y
+CONFIG_PWRSEQ_EMMC=y
+CONFIG_MMC_BLOCK=y
+CONFIG_MMC_BLOCK_MINORS=256
 CONFIG_SDIO_UART=y
 CONFIG_MMC_OMAP=y
 CONFIG_MMC_OMAP_HS=y
@@ -453,3 +456,8 @@ CONFIG_LIBCRC32C=y
 CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
+CONFIG_MMC_SDHCI=m
+CONFIG_MMC_SDHCI_IO_ACCESSORS=y
+CONFIG_MMC_SDHCI_PCI=m
+CONFIG_MMC_SDHCI_OMAP=m
+CONFIG_MMC_SDHCI_PLTFM=m
-- 
2.35.1


