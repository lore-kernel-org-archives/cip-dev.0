Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797A9C18E72
	for <webhook@archiver.kernel.org>; Mon, 22 Apr 2024 14:11:33 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.19472.1713795084846138737
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Apr 2024 07:11:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=bBZfZ2XD;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20240422141122ded3887665e9febd28-hj54bw@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240422141122ded3887665e9febd28
        for <cip-dev@lists.cip-project.org>;
        Mon, 22 Apr 2024 16:11:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=92laoSyA7ibBoNhzAQr2FvY4IP6MNIW/tOc+ONdCPmM=;
 b=bBZfZ2XDUocMojJwsu7WHM0KRlwigigjr7VjECzwkVipVLJtZRFo++HUq1cUCcrXjRl3T+
 /R6KYv15da2PLUXbhj9SPPua/Jnr4LnUZCAqNtPHPUNKT73JZ18xcO+P7ZEvhHwd/wY9Tfwu
 Kcc1tW9HWyzlU6xN5gOl8nQ3aK1iI=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	johnxw@amazon.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2 4/7] fix: use luks2 to identify encrypted partition
Date: Mon, 22 Apr 2024 16:09:09 +0200
Message-ID: <20240422141120.577573-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240422141120.577573-1-Quirin.Gylstorff@siemens.com>
References: <20240422141120.577573-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Apr 2024 14:11:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15724

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes an issue with encrypted rootfs during system reboot.
With the token option it can happen that during reboot the no
valid Luks partition is found and the boot up fails in the initrd.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-crypt-hook/files/encrypt_partition.script         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
index 51c81f3..685d882 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
@@ -134,7 +134,7 @@ for partition_set in $partition_sets; do
 	fi
 
 	if /usr/sbin/cryptsetup luksDump --batch-mode "$partition" \
-			| grep -q "token"; then
+			| grep -q "luks2"; then
 		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
 		continue
 	fi
-- 
2.43.0


