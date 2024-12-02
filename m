Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD000D78336
	for <webhook@archiver.kernel.org>; Mon,  2 Dec 2024 14:51:39 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.175576.1733151096412742655
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Dec 2024 06:51:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=lmW3i1tK;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-202412021451344511174b5d76b64173-pg0uuk@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202412021451344511174b5d76b64173
        for <cip-dev@lists.cip-project.org>;
        Mon, 02 Dec 2024 15:51:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=OV3SF+j56A32mCpXJjsAfQDPRGrz+lHLQw0v+neQOGs=;
 b=lmW3i1tKRWpYM8ygrVxKcCdeEZftDwO4oVEUQkerx/yOXWQ5Rq7Dslz+bo8isixRHQrIad
 KjI1b8SZ3i1V56U0FTe7kSD4ZUjUTMU/mPv/FWGKXSHzEKOo5ybgLOZQKoyaAP/keOY3eEpV
 BTBmw/ewqajRZqFhiAYyke5Guuz8AZkRAPwUmx/J3mZkrcYoKxu9lnYWHLWenz1KMCqG+tm6
 c5x99P5ohVJIHH2ypGILymgLr94SxKz/Iktdn0kPHP4PDGQFCkt4l1AxwnQj5hcf9pUfZL2a
 mwy56E1AB3kfgMK7gEaSEIk95M7PhJEnn2wYRkktYJS6AsXDBEg8Pbmg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Alexander Heinisch <alexander.heinisch@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 03/10] initramfs-crypt-hook: Convert awk statement into simple variable evaluation
Date: Mon,  2 Dec 2024 15:51:06 +0100
Message-ID: <dd0af28b84c5baf56e9b86237768262f2ef51803.1733151072.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1733151072.git.jan.kiszka@siemens.com>
References: <cover.1733151072.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Dec 2024 14:51:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17313

From: Jan Kiszka <jan.kiszka@siemens.com>

Use suffix removal to convert "/dev/some-device" into "some-device".
It's simpler and avoids sub-processes.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../initramfs-crypt-hook/files/encrypt_partition.script         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
index 2cd6798d..28548502 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
@@ -62,7 +62,7 @@ service_watchdog() {
 }
 
 reencrypt_existing_partition() {
-	part_size_blocks="$(cat /sys/class/block/"$(awk -v dev="$1" 'BEGIN{split(dev,a,"/"); print a[3]}' )"/size)"
+	part_size_blocks="$(cat /sys/class/block/"${1##*/}"/size)"
 	# reduce the filesystem and partition by 32M to fit the LUKS header
 	partition_fstype=$(get_fstype "${1}")
 	reduce_device_size=32768
-- 
2.43.0


