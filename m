Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A25EC678D4
	for <webhook@archiver.kernel.org>; Mon,  6 Mar 2023 12:39:34 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.32032.1678106370811666623
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Mar 2023 04:39:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Fgp4lRiE;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20230306123928dbff5976aaa773ecba-ak_lxn@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230306123928dbff5976aaa773ecba
        for <cip-dev@lists.cip-project.org>;
        Mon, 06 Mar 2023 13:39:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=3/sCv02pbuv2+shh/oJx1DFlUG8AMxv5s06i3mJ3DuM=;
 b=Fgp4lRiEdRA2N7dqDZAjnmzhr6Okio5U9j00WJkDvDguix2rhJV3YKINVhtsaWx7T/0oLi
 YhHYeEpXxnBlzrQpOLRmdwnIC1FlnvWZrMzt28Xk0p2YxXlETUFnRR+nsdKV2c0I+We6VPwz
 gdFef1TgCmXgoK1dJZ4cmd3kTL/vk=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	christian.storm@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 2/7] KConfig: add tpm option
Date: Mon,  6 Mar 2023 13:39:21 +0100
Message-Id: <20230306123926.243471-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230306123926.243471-1-Quirin.Gylstorff@siemens.com>
References: <20230306123926.243471-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Mar 2023 12:39:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10937

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Kconfig b/Kconfig
index 7d72094..7ce87d0 100644
--- a/Kconfig
+++ b/Kconfig
@@ -193,4 +193,15 @@ config KAS_INCLUDE_SWUPDATE_SECBOOT
 	default "kas/opt/ebg-swu.yml" if IMAGE_SWUPDATE && !IMAGE_SECURE_BOOT
 	default "kas/opt/ebg-secure-boot-snakeoil.yml" if IMAGE_SECURE_BOOT
 
+config IMAGE_TPM2_ENCRYPTION
+	bool "Encrypt partitions on first boot with TPM2 (Demo)"
+	depends on TARGET_QEMU_AMD64
+	help
+	  This enables TPM2 encryption for the partition given in the variable
+	  CRYPT_PARTITIONS from recipes-initramfs/initramfs-crypt-hook.
+
+config KAS_INCLUDE_TPM2_ENCRYPTION
+	string
+	default "kas/opt/tpm.yml" if IMAGE_TPM2_ENCRYPTION
+
 endif
-- 
2.39.2


