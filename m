Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769DAC25B78
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 09:37:11 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.18251.1716889020861966252
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 May 2024 02:37:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=LB38ETpj;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-20240528093657ecbf15c08768f8d074-caft1f@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240528093657ecbf15c08768f8d074
        for <cip-dev@lists.cip-project.org>;
        Tue, 28 May 2024 11:36:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=C+qMoXFtPefsbFXtoqVZ4ylQsieDsQt6sJ3/eYQncRk=;
 b=LB38ETpjmNTifYY78sy37g7qMv6nPfIhYzV/RmFpM2Bqckr77Yu8pbgdAJs1UatG/IDY9S
 iFYW6ou2GbfMNDZCgm8xDnv0DTlGcBnSIhLUNvkScU7tf0B64dnO+nbI2fm32qapxrU10R5n
 ColyvkJfPlzOGJ7BD+rv+Wpy93ez0=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: gokhan.cetin@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v4] encrypt_partition.clevis: select tpm2_device for encryptition
Date: Tue, 28 May 2024 11:36:39 +0200
Message-ID: <20240528093656.21040-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 May 2024 09:37:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15961

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This change allows to preselect the TPM2 device for clevis in Debian
bookworm and later.

As clevis is intented to provided TPM2 based disk encryption
with Debian bullseye and earlier the TPM2 device selection was not avaiable
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
Changes v4:
 - use correct format of TPM2TOOLS_TCTI `<tcti-name>:<tcti-option-config>` according to
 https://github.com/tpm2-software/tpm2-tools/blob/master/man/common/tcti.md#tcti-configuration.

Changes v3:
 - reword commit message that the disable setting was intentional

Changes v2:
 - reword commit message to clarify intent

 .../files/encrypt_partition.clevis.script                 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
index ddb3eab..ceeacd1 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
@@ -13,8 +13,8 @@
 open_tpm2_partition() {
 	partition_device="$1"
 	crypt_mount_name="$2"
-	#tpm_device="$3"
-	if ! /usr/bin/clevis luks unlock -n "$crypt_mount_name" \
+	tpm_device="$3"
+	if ! TPM2TOOLS_TCTI="device:$tpm_device" usr/bin/clevis luks unlock -n "$crypt_mount_name" \
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
+		TPM2TOOLS_TCTI="device:$tpm_device" clevis luks bind -d "$partition_device" tpm2 '{"key":"'"$tpm_key_algorithm"'", "pcr_bank":"'"$pcr_bank_hash_type"'","pcr_ids":"7"}' < "$passphrase"
 	else
 		panic "clevis not available cannot enroll tpm2 key!"
 	fi
-- 
2.43.0


