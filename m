Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F53C25B74
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 16:35:20 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.168.1716568514658078377
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 May 2024 09:35:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=WN+ikJ0G;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20240524163510a60544eb74b0979e82-wnfjdh@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240524163510a60544eb74b0979e82
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 May 2024 18:35:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=rmkegkyLQk6ny3ovDAhiPhXzTY8QgIoc5MPFd44zMiQ=;
 b=WN+ikJ0Gidn7vZH9TVDUED34ucxyZOu9YgS2+56OK9Bb+UVt81sAclgvOYAq1JXCKBTXFk
 g/lvmchL30poI5A99ngiiFcc0XJUTlWhAUJjtH3ZdsyaSbbXpIh4lm9/RAgvRCBsrGV+8EHe
 sY8sueE8hAf7D0EpVgOSnLXs418zE=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	gokhan.cetin@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH] encrypt_partition.clevis: clevis > v19 support multiple tpm2 device
Date: Fri, 24 May 2024 18:18:52 +0200
Message-ID: <20240524163509.2372441-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 May 2024 16:35:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15946

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows use to select a tpm2 device which supports
all requirements.

Reported-by: Gokhan Cetin  <gokhan.cetin@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
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


