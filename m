Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75539C25B74
	for <webhook@archiver.kernel.org>; Mon, 27 May 2024 14:32:53 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.29378.1716820371821314403
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 May 2024 07:32:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=EYVS5UY3;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-20240527143248057964f474b7cf4f3f-sgxob3@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240527143248057964f474b7cf4f3f
        for <cip-dev@lists.cip-project.org>;
        Mon, 27 May 2024 16:32:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=24uOlKv44xieGhg4UQRreYKj3pZWoBw7kygEUsx9/xM=;
 b=EYVS5UY3nJ92xgngUntEyE3AJqhfzYd91dSNDNZwFgne/Ch0Dk6VcC1GCiIuiZkfRwlm0Q
 ajNwUMq5zFWefVOszFt5pNeYd6xvqz2+AwffRvXVza1ed9G1QGZh2/g9aHhdE7hGPQiey6Ee
 QzDmFFMaRkHiEQI1oHFsrUzIpb5Us=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	gokhan.cetin@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3] encrypt_partition.clevis: select tpm2_device for encryptition
Date: Mon, 27 May 2024 16:32:26 +0200
Message-ID: <20240527143247.3098210-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 May 2024 14:32:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15958

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This enables the feature to preselect the TPM2 device also for clevis in Debian
bookworm and later.

As clevis is intented to provided TPM2 based disk encryption
for Debian bullseye and earlier the TPM2 device selection was not avaiable
or implemented. Since clevis v19(part of Debian bookworm) the TPM2
device can be selected with the variable TPM2TOOLS_TCTI[1].

Setting the variable as no effect in older versions, so
no version check was implemented.

No interface change as systemd-cryptenroll already allows
selecting the tpm2 device.

[1]: https://github.com/latchset/clevis/commit/c6fc63fc055c18927decc7bcaa07821d5ae37614

Reported-by: Gokhan Cetin  <gokhan.cetin@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
Changes v3:
 - reword commit message that the disable setting was intentional

Changes v2:
 - reword commit message to clarify intent

 .../files/encrypt_partition.clevis.script                 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
index ddb3eab..a7a5009 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
@@ -13,8 +13,8 @@
 open_tpm2_partition() {
 	partition_device="$1"
 	crypt_mount_name="$2"
-	#tpm_device="$3"
-	if ! /usr/bin/clevis luks unlock -n "$crypt_mount_name" \
+	tpm_device="$3"
+	if ! TPM2TOOLS_TCTI=$tpm_device usr/bin/clevis luks unlock -n "$crypt_mount_name" \
 		 -d "$partition_device"; then
 		panic "Can't decrypt '$partition_device' !"
 	fi
@@ -23,11 +23,11 @@ open_tpm2_partition() {
 enroll_tpm2_token() {
 	partition_device="$1"
 	passphrase="$2"
-	#tpm_device="$3"
+	tpm_device="$3"
 	tpm_key_algorithm="$4"
 	pcr_bank_hash_type="$5"
 	if [ -x /usr/bin/clevis ]; then
-		clevis luks bind -d "$partition_device" tpm2 '{"key":"'"$tpm_key_algorithm"'", "pcr_bank":"'"$pcr_bank_hash_type"'","pcr_ids":"7"}' < "$passphrase"
+		TPM2TOOLS_TCTI=$tpm_device clevis luks bind -d "$partition_device" tpm2 '{"key":"'"$tpm_key_algorithm"'", "pcr_bank":"'"$pcr_bank_hash_type"'","pcr_ids":"7"}' < "$passphrase"
 	else
 		panic "clevis not available cannot enroll tpm2 key!"
 	fi
-- 
2.43.0


