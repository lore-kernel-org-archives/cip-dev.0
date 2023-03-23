Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3F5C76195
	for <webhook@archiver.kernel.org>; Thu, 23 Mar 2023 13:43:40 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.72502.1679579014357802917
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Mar 2023 06:43:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=Mcu0cC0E;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-202303231343315e307f469c23da30e8-421jve@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202303231343315e307f469c23da30e8
        for <cip-dev@lists.cip-project.org>;
        Thu, 23 Mar 2023 14:43:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=etOOgPGClAA86kRMQMr43fWpkvQHk7dmjeEwVk3/CHc=;
 b=Mcu0cC0ETUEgYpvxp5Woqafr7ANPfXVwC4VLSkxfMP9QMrmfvggUXHPV2PrvqpV17G697d
 6zmRW3q9Xr4AoOCkamow6p778z5I1AQocHe1CZjBkNVNl+ly2qFX1Mk5ktM9Eyz06zItyrxT
 wTsB8dCI8UgJNVFLRlJQkME0RsIhc=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 2/3] kconfig: Allow to select encryption also for qemu-arm and qemu-arm64
Date: Thu, 23 Mar 2023 14:43:29 +0100
Message-Id: <30b4c258af127da4d9fbf3192d64f1ed534d6628.1679579010.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1679579010.git.jan.kiszka@siemens.com>
References: <cover.1679579010.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Mar 2023 13:43:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11100

From: Jan Kiszka <jan.kiszka@siemens.com>

This is now possible with latest kernel configs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index e1e187f9..630cd78d 100644
--- a/Kconfig
+++ b/Kconfig
@@ -195,7 +195,7 @@ config KAS_INCLUDE_SWUPDATE_SECBOOT
 
 config IMAGE_DATA_ENCRYPTION
 	bool "Encrypt data partitions on first boot"
-	depends on TARGET_QEMU_AMD64
+	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM
 	select IMAGE_SECURE_BOOT
 	help
 	  This enables LUKS encryption for the partitions /var and /home.
-- 
2.35.3


