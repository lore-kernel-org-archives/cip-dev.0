Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC64C05052
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:20:49 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.15328.1713514840054193210
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:20:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=php0tWnd;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-20240419082037c6cf3ab519e94dbce3-sgduld@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240419082037c6cf3ab519e94dbce3
        for <cip-dev@lists.cip-project.org>;
        Fri, 19 Apr 2024 10:20:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=rxFhcFtQq85P1V5x+iLgs2RBNBYhcghQLzRi1G09nXA=;
 b=php0tWndq54Nz+uEmaSNvzzCeBqQvZfQ0p8IJ+wtzH1XUs6BUCXprl+8P968EojVWNWHk0
 9oX007D6O3msCM4L45K+VR1ZDqrJz3ZwSg7juJDr834S5NLroLiHast7BwOcU56DCLo+PYSD
 oS4Fo/fxHu/Uk6XznAoEt+xF9FiAU=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: johnxw@amazon.com,
	cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 2/7] initramfs: allow empty mountpoint for crypt hooks
Date: Fri, 19 Apr 2024 10:20:12 +0200
Message-ID: <20240419082036.2389583-3-Quirin.Gylstorff@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15643

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


