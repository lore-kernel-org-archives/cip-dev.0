Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4C3C25B7B
	for <webhook@archiver.kernel.org>; Mon,  6 May 2024 14:18:45 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.21518.1715005117987240303
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 May 2024 07:18:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=AdFOjqHl;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-202405061418355aca18504bb03e9292-iteddp@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202405061418355aca18504bb03e9292
        for <cip-dev@lists.cip-project.org>;
        Mon, 06 May 2024 16:18:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=3ZQDRvSZd7HchHLcccGLaaWbNMZOKMNJPS76k/d+4tI=;
 b=AdFOjqHlJxMGwbhvGLMktYycW1L7HLzJFHenT34Hb5SY4ip5fQmgoY4h6OHZZ9UsaJlMne
 fyqKdu/yx4Ytcl/YFuXJYqpxTl1Iei/NcM2B7T+OEyEh3uRrckenRKJqoQx9CKd0rGPlYzIv
 5ddBvS2StyZBR5V9Ph+qogCR1OKrs=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	johnxw@amazon.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 02/11] initramfs: allow empty mountpoint for crypt hooks
Date: Mon,  6 May 2024 16:17:23 +0200
Message-ID: <20240506141833.3622989-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240506141833.3622989-1-Quirin.Gylstorff@siemens.com>
References: <20240506141833.3622989-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 May 2024 14:18:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15830

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows to encrypt partitions, which have a seperate mount
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


