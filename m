Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBAEC27C75
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 09:48:51 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.4387.1718272129239732357
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jun 2024 02:48:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=YnOTJVeY;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-202406130948453bf38837ebb7c5db25-qlw6yb@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202406130948453bf38837ebb7c5db25
        for <cip-dev@lists.cip-project.org>;
        Thu, 13 Jun 2024 11:48:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=xwvNIizRqm1etC3R7YUjLuAQQA85VqvhFuX6ytMrbE8=;
 b=YnOTJVeY4tyq2YrDP11o9vxtsr3y9XGj7NhOqCkngXLEzBIo8Fs5+Vsn/5N19S7LjD3/Bv
 hhRu9L1uN2F7e21eZBgoXeR2E0CFKX8jZumt0mFT9e2V48IzN2cJ8If+FW95DN9HD63LuoCJ
 o/9ra9FK+DDFAEShifjDw2x+bh4kA=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] encrypt partition: Add support for swap partition
Date: Thu, 13 Jun 2024 11:47:53 +0200
Message-ID: <20240613094845.1167459-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jun 2024 09:48:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16200

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This changes allows to encrypt a swap partitions.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-crypt-hook/files/encrypt_partition.script         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
index d48db94..8fccb4c 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
@@ -77,7 +77,7 @@ reencrypt_existing_partition() {
 			panic "reencryption of filesystem $1 cannot continue!"
 		fi
 		;;
-	squashfs|"")
+	squashfs|swap|"")
 		[ "$debug" = "y" ] && echo "skip disk resize as it is not supported or unnecessary for fstype: '$partition_fstype'"
 		;;
 	*)
-- 
2.43.0


