Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DA8C4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:20:48 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.15347.1713514840272959741
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:20:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=FHA71TD7;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-2024041908203722d05d6d5a7a2c3cf7-opum1j@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2024041908203722d05d6d5a7a2c3cf7
        for <cip-dev@lists.cip-project.org>;
        Fri, 19 Apr 2024 10:20:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=gehmAT1K4Hln8xXUhy00AHYcmX5hWAsoXefSnk1iaLw=;
 b=FHA71TD7X0dM4khUzvpQaQzL7taxzWsKd/RcEdXzhUoXo4qAu7Zbkp25y/hP38H/OYg7lS
 fmQpaWM2fwzEJOg/tEKN6rRbeQupDLk0jxJB3uA5XV/xgPdbK0G6r94myQ1iwoR3rELLeXi4
 QzhTeHmKKDAve1XrPX+P95W4FY3nM=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: johnxw@amazon.com,
	cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 3/7] fix: disk formatting
Date: Fri, 19 Apr 2024 10:20:13 +0200
Message-ID: <20240419082036.2389583-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240419082036.2389583-1-Quirin.Gylstorff@siemens.com>
References: <20240419082036.2389583-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:20:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15642

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes an regression from cfef8103a0385c0d6c4631f23aabcdf65de4efba.
As the format path was not update to the new function arguments.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-crypt-hook/files/encrypt_partition.script         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
index 8763f69..8f6cbf6 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
@@ -147,7 +147,7 @@ for partition_set in $partition_sets; do
 		"format")
 			/usr/sbin/cryptsetup luksFormat --batch-mode \
 				 --type luks2 "$partition" < "$tmp_key"
-			enroll_tpm2_token "$part_device" "$tmp_key"
+			enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_algorithm" "$pcr_bank_hash_type"
 			open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
 			eval "${create_file_system_cmd} ${decrypted_part}"
 		;;
-- 
2.43.0


