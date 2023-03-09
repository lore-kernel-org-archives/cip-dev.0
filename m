Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC03AC74A5B
	for <webhook@archiver.kernel.org>; Thu,  9 Mar 2023 08:53:29 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.8768.1678352005481949969
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Mar 2023 00:53:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=SkVgJ/FW;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-2023030908532226b83bf3245c682e4e-1ez49i@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2023030908532226b83bf3245c682e4e
        for <cip-dev@lists.cip-project.org>;
        Thu, 09 Mar 2023 09:53:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=clSPcyPlUIJmWGwVuBPCbUTGisTdvjJCycm6vLHCACU=;
 b=SkVgJ/FWOZtvF8KOnb6aGw8QQRFkAMeTiXHxhIUinWDh4JPaaP/5L6IDrY3BjNG0gjJZPw
 RTib+NAcJaTf2GtHt/fYt3tdJsmI3Ru2iTuaChh4yHVEhSMlAwDfvbmOMukxx5Moj4z2YSa9
 dUPDP+0tszQlz0aRupBrMM3mjL98k=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	christian.storm@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 1/6] KConfig: add option to encrypt data partitions
Date: Thu,  9 Mar 2023 09:53:16 +0100
Message-Id: <20230309085321.17167-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230309085321.17167-1-Quirin.Gylstorff@siemens.com>
References: <20230309085321.17167-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Mar 2023 08:53:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10958

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Kconfig b/Kconfig
index 7d72094..cafb04c 100644
--- a/Kconfig
+++ b/Kconfig
@@ -193,4 +193,14 @@ config KAS_INCLUDE_SWUPDATE_SECBOOT
 	default "kas/opt/ebg-swu.yml" if IMAGE_SWUPDATE && !IMAGE_SECURE_BOOT
 	default "kas/opt/ebg-secure-boot-snakeoil.yml" if IMAGE_SECURE_BOOT
 
+config IMAGE_DATA_ENCRYPTION
+	bool "Encrypt data partitions on first boot"
+	depends on TARGET_QEMU_AMD64
+	help
+	  This enables LUKS encryption for the partitions /var and /home.
+
+config KAS_INCLUDE_DATA_ENCRYPTION
+	string
+	default "kas/opt/encrypt-partitions.yml" if IMAGE_DATA_ENCRYPTION
+
 endif
-- 
2.39.2


