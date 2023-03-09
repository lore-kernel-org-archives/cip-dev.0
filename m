Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B32C6FD1F
	for <webhook@archiver.kernel.org>; Thu,  9 Mar 2023 10:28:30 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.10025.1678357706144424806
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Mar 2023 02:28:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=VFDufpY4;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20230309102823623f9865d5ec4ef68b-7xx_bt@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230309102823623f9865d5ec4ef68b
        for <cip-dev@lists.cip-project.org>;
        Thu, 09 Mar 2023 11:28:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=clSPcyPlUIJmWGwVuBPCbUTGisTdvjJCycm6vLHCACU=;
 b=VFDufpY4kD0ez1iuFlHwgFCKgiqsB2W+MMf0CP4xVC61RtuQ2F05FlbJ6gQF1xYvy4ik6A
 /Spt0yGHUN9kDd37/9iPe9AbWX7h9Gw7RPPD5Q6b+gMCFYt+1y03jNp6z1ec1etJbRE9G/zy
 hosK/i9RUg/hbCa83fiDks9Gcralo=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	christian.storm@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v6 2/7] KConfig: add option to encrypt data partitions
Date: Thu,  9 Mar 2023 11:28:16 +0100
Message-Id: <20230309102821.307140-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230309102821.307140-1-Quirin.Gylstorff@siemens.com>
References: <20230309102821.307140-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Mar 2023 10:28:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10965

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


