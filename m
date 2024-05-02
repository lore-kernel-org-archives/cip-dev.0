Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA78C25B78
	for <webhook@archiver.kernel.org>; Thu,  2 May 2024 09:32:55 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.9362.1714642365647951203
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 May 2024 02:32:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=U3ZOd1l2;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20240502093243fc18a377471848525b-dxy1mx@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240502093243fc18a377471848525b
        for <cip-dev@lists.cip-project.org>;
        Thu, 02 May 2024 11:32:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=EeCB0hwFvOY3aLh0gV3XxJa9ZpnFjr0BRbGX+EjFW3k=;
 b=U3ZOd1l2Na4RdANQrFl9lYfi++XP661krO2aU59HxgGn40PmLOco7IVuMARWFIRm2t0Jw0
 AtXvtUC1Qi+a/Xrz6TgT5P0bNVNMcYwfjo0RHVnsLEJQDLy8glc8El9b96FN3v6cATJV5eQy
 parywhp8NUvAkkzNy7Yqhl8Qnpi30=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	johnxw@amazon.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 8/9] README: Add rootfs encryption
Date: Thu,  2 May 2024 11:31:53 +0200
Message-ID: <20240502093240.364093-9-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240502093240.364093-1-Quirin.Gylstorff@siemens.com>
References: <20240502093240.364093-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 May 2024 09:32:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15796

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.tpm2.encryption.md | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
index c5ac6c4..889c3ca 100644
--- a/doc/README.tpm2.encryption.md
+++ b/doc/README.tpm2.encryption.md
@@ -4,6 +4,10 @@ By adding the recipe `initramfs-crypt-hook` to the initramfs build user defined
 encrypted during first boot. The encrypted partition is a LUKS partition and uses a TPM to secure the
 passphrase on the device.
 
+> :exclamation:**IMPORTANT**
+> All selected partition are encrypted on first boot. In order to avoid the leakage of secrets
+> the disk encryption should occur in a secure environment.
+
 ## Requirements
 
 Testing with qemu-amd64 requires the package `swtpm`. Under Debian/Ubuntu this can be installed
@@ -38,12 +42,22 @@ The initramfs-crypt-hook recipe has the following variables which can be overwri
 ### CRYPT_PARTITIONS
 
 The variable `CRYPT_PARTITIONS` contains the information which partition shall be encrypted where to mount it.
-Each entry uses the schema `<partition-label>:<mountpoint>:<reencrypt or format>`.
-- The `partition-label` is used to identify the partition on the disk
+Each entry uses the schema `<partition-identifier>:<mountpoint>:<reencrypt or format>`.
+- The `partition-idenitifer` is used to identify the partition on the disk, it can contain a partition label, partition UUID or absolute path to the partition device, e.g. `/dev/sda`.
 - The `mountpoint` is used mount the decrypted partition in the root file system
 - `reencrypt` uses `cryptsetup reencrypt` to encrypt the exiting content of the partition. This reduces the partition by 32MB and the file system by a similar amount
 - `format` creates a empty LUKS partition and creates a file system defined with the shell command given in `CRYPT_CREATE_FILE_SYSTEM_CMD`
 
+#### Encrypted root file system
+
+To encrypt the root file system the variable `CRYPT_PARTITIONS` needs to be set to:
+```
+CRYPT_PARTITIONS = "${ABROOTFS_PART_UUID_A}::reencrypt ${ABROOTFS_PART_UUID_B}::reencrypt"
+```
+The mountpoint is empty as the root partition is mounted by another initramfs service.
+Both partitions are encrypted during first boot. The initramfs opens `${ABROOTFS_PART_UUID_A}` and `${ABROOTFS_PART_UUID_B}`
+during boot.
+
 ### CRYPT_CREATE_FILE_SYSTEM_CMD
 
 The variable `CRYPT_CREATE_FILE_SYSTEM_CMD` contains the command to create a new file system on a newly
@@ -59,7 +73,7 @@ based encryption:
  - jq
 
 ## steps to convert clevis to systemd
-The following script shows how to enroll a systemd-tpm2 token with a existinng clevis based encryption:
+The following script shows how to enroll a systemd-tpm2 token with a existing clevis based encryption:
 ```bash
 export device=/dev/sda6
 export keyslot=$(sudo cryptsetup luksDump "$device" --dump-json-metadata | jq -c '.tokens.[] | select( .type == "clevis") | .keyslots | first' | head -n1)
-- 
2.43.0


