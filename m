Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BE5CD1284
	for <webhook@archiver.kernel.org>; Tue,  9 Apr 2024 13:06:50 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.136247.1712668004111352957
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Apr 2024 06:06:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=gnRPMPpU;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-20240409130642c879588d59a498f30e-4y8b0q@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240409130642c879588d59a498f30e
        for <cip-dev@lists.cip-project.org>;
        Tue, 09 Apr 2024 15:06:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=WabpgPSBOaIxOcdMBd0mE4a/lwIxyQCmvKEILAwxOHA=;
 b=gnRPMPpUW7i3erEfvjHr45Bv+NmaudlVOJJqpU8sX7acletmXF2s0tw2m6xhOA0RNUYHff
 148vyRrXO/oxLGMjRV9NSwIMaXo2xvM3tOMx0L9DM6XqzYIN4mTkT+xUDIPDnXg72BPyQt3t
 InIrqC3c6MZKK5au+qOJ9XplmdhHA=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	johnxw@amazon.com
Subject: [cip-dev][isar-cip-core][PATCH v3 14/15] Kconfig: Add option to encrypt the rootfs
Date: Tue,  9 Apr 2024 15:05:31 +0200
Message-ID: <20240409130638.559398-15-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240409130638.559398-1-Quirin.Gylstorff@siemens.com>
References: <20240409130638.559398-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Apr 2024 13:06:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15526

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 Kconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Kconfig b/Kconfig
index 7c19640..8e96865 100644
--- a/Kconfig
+++ b/Kconfig
@@ -212,5 +212,19 @@ config IMAGE_DATA_ENCRYPTION
 config KAS_INCLUDE_DATA_ENCRYPTION
 	string
 	default "kas/opt/encrypt-partitions.yml" if IMAGE_DATA_ENCRYPTION
+endif
+
+if IMAGE_FLASH && !IMAGE_DATA_ENCRYPTION && !IMAGE_SECURE_BOOT && !IMAGE_SWUPDATE
+
+config IMAGE_ROOTFS_ENCRYPTION
+	bool "Encrypt rootfs and data partitions"
+	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || !IMAGE_SWUPDATE || !IMAGE_SECURE_BOOT
+	help
+	  This enables LUKS encryption for all partition. This is currently incompatible
+	  with efibootguard, secure boot and SWUpdate.
+
+config KAS_INCLUDE_ROOTFS_ENCRYPTION
+	string
+	default "kas/opt/encrypt_rootfs.yml" if IMAGE_ROOTFS_ENCRYPTION
 
 endif
-- 
2.43.0


