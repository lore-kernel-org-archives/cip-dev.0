Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F4AC61DC2
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 05:42:07 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6255.1787722924900602461
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Aug 2026 22:42:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=TJ8jJnmu;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-202608260542038a93050b090002073d-s8izt8@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202608260542038a93050b090002073d
        for <cip-dev@lists.cip-project.org>;
        Wed, 26 Aug 2026 07:42:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=mJAgUGmhDn2uMzMKHSknyzmqmaTB68QAerD/TqIp6ho=;
 b=TJ8jJnmuW4FL0HHbmkd4VMARh0+FoLgNmwIvqUVMggnA9a26OAiUpQ8lpylrQcIRiUel+h
 NRoCnAle6zgrEA0FJDa53XbTVCFOysUQ8Sn69LVTul3j5l7fnbdhglp//91tAKVm3FUCC2T1
 YRMaUzMZVQGfBTEMSplN7kvT1MLKIoTiIFgt4vOY6vOnpsw/SGR4icBbXcWqEYNl4LYttC65
 pSxprPYNosh96m43o8ClSlnK9p9vAgh3isV6YGAZU/rGL/Jjo0dLRqFOu+33WNZnW6/5rxEb
 eLL6v0ksIFRHUl1HMeW8q5YNYvl/IG4Z1x9kU3yrgF+De8camfTLARSw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH 6/7] u-boot: Drop obsolete config workaround
Date: Wed, 26 Aug 2026 07:41:44 +0200
Message-ID: <2b85d15aef1c7ef7f6d3290f3bb89c2bf2c438e5.1787722904.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1787722904.git.jan.kiszka@siemens.com>
References: <cover.1787722904.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Aug 2026 05:42:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24006

From: Jan Kiszka <jan.kiszka@siemens.com>

We moved to a newer U-Boot version meanwhile which resolved that issue.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-bsp/u-boot/files/secure-boot.cfg | 2 --
 1 file changed, 2 deletions(-)

diff --git a/recipes-bsp/u-boot/files/secure-boot.cfg b/recipes-bsp/u-boot/files/secure-boot.cfg
index 7b09a53e..15a2bdf3 100644
--- a/recipes-bsp/u-boot/files/secure-boot.cfg
+++ b/recipes-bsp/u-boot/files/secure-boot.cfg
@@ -17,5 +17,3 @@ CONFIG_FS_FAT=y
 CONFIG_EFI_SECURE_BOOT=y
 # overruled by CONFIG_EFI_MM_COMM_TEE where available
 CONFIG_EFI_VARIABLES_PRESEED=y
-# workaround for v2025.07
-CONFIG_CMD_DHCP=y
-- 
2.47.3


