Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E33C04FFF
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:20:49 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.15346.1713514840209752022
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:20:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Zqy+U918;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20240419082038b3f3c750e6b0516f91-oqg4yc@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240419082038b3f3c750e6b0516f91
        for <cip-dev@lists.cip-project.org>;
        Fri, 19 Apr 2024 10:20:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Xt0kRzMp/Bu6p7cgfPV7sdtGa5HLB+fsZZpCOgKmX5M=;
 b=Zqy+U918WEOWijd/5czGvL6cSpoyYJp7TWmUifK99jjB0pVKIVZ5RKB86emGMfv0d72UBZ
 Sc0QiJg9OoeAsLL+HtdstRHA+FSdoeqpBznTJA0wu+oDa2KgnzuKiwjmLWBFABT7hia0k8Ax
 s85UHUZfVxHzTj1avB9jFHz3/wdMg=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: johnxw@amazon.com,
	cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 5/7] use luks2 to identify encrypted partition
Date: Fri, 19 Apr 2024 10:20:15 +0200
Message-ID: <20240419082036.2389583-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240419082036.2389583-1-Quirin.Gylstorff@siemens.com>
References: <20240419082036.2389583-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:20:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15647

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes an issue with encrypted rootfs during system reboot.

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


