Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FEAC25B5C
	for <webhook@archiver.kernel.org>; Thu, 25 Apr 2024 11:51:30 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.14923.1714045883938499897
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Apr 2024 04:51:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=PZJAdE8B;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20240425115121a65276642168481d28-uexynf@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240425115121a65276642168481d28
        for <cip-dev@lists.cip-project.org>;
        Thu, 25 Apr 2024 13:51:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=rxFhcFtQq85P1V5x+iLgs2RBNBYhcghQLzRi1G09nXA=;
 b=PZJAdE8BOxCxuzBwQu3oTwm2dyJPvAAW9xucOl6f6DPd7ZyRnF5wOBDWiMgW/bbg9310bY
 xm+OJgIpwCwOJDqu5OWMiEsLJamLdj+DbBNMb9VoR9hSKuxVyagJMcnzEmDpIwpLWZTrE0XF
 w8xsqNschaLa4HLeeqUtaO2588i+I=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	johnxw@amazon.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 2/9] initramfs: allow empty mountpoint for crypt hooks
Date: Thu, 25 Apr 2024 13:50:30 +0200
Message-ID: <20240425115119.813384-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240425115119.813384-1-Quirin.Gylstorff@siemens.com>
References: <20240425115119.813384-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Apr 2024 11:51:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15754

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows to encrypt partition which have as seperate mount
script like verity and abrootfs

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-crypt-hook/files/mount_crypt_partitions.script  | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/mount_crypt_partitions.script b/recipes-initramfs/initramfs-crypt-hook/files/mount_crypt_partitions.script
index 3411e70..b72323f 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/mount_crypt_partitions.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/mount_crypt_partitions.script
@@ -51,7 +51,9 @@ for partition_set in $partition_sets; do
 	part_device=$(readlink -f "$partition")
 	crypt_mount_name="encrypted_$partition_label"
 	decrypted_part=/dev/mapper/"$crypt_mount_name"
-
+	if [ -z "$partition_mountpoint" ]; then
+		continue
+	fi
 	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
 			| grep -q "luks2"; then
 		mount_partition "$decrypted_part" "${rootmnt}""$partition_mountpoint"
-- 
2.43.0


