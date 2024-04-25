Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3914DC19F53
	for <webhook@archiver.kernel.org>; Thu, 25 Apr 2024 11:51:30 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.14905.1714045884889685086
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Apr 2024 04:51:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=IEBjG/F8;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20240425115122fa52e7d6b35215215a-pctno2@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240425115122fa52e7d6b35215215a
        for <cip-dev@lists.cip-project.org>;
        Thu, 25 Apr 2024 13:51:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=mHui6VZAMmnhKkKkASGmG1rdeLmBIWMCnp6WWsj99y8=;
 b=IEBjG/F8linkpPcEz585ToSVvDU5SxmEdpsayMlyh0X4JojkyM0BMuJMHSQLeEeNt8iT0i
 9qfOvi0LWVjBKfRglJSenaOAXnYedDvlU0vlqpPpDnjw4ccaxzUXBzF14G7LZ7zI/hNb+/3X
 PdG1izaHKoYyuS82vWcg9FurrViTc=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	johnxw@amazon.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 8/9] README: Add rootfs encryption
Date: Thu, 25 Apr 2024 13:50:36 +0200
Message-ID: <20240425115119.813384-9-Quirin.Gylstorff@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15759

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.tpm2.encryption.md | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
index c5ac6c4..fdfa8da 100644
--- a/doc/README.tpm2.encryption.md
+++ b/doc/README.tpm2.encryption.md
@@ -38,12 +38,22 @@ The initramfs-crypt-hook recipe has the following variables which can be overwri
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
@@ -59,7 +69,7 @@ based encryption:
  - jq
 
 ## steps to convert clevis to systemd
-The following script shows how to enroll a systemd-tpm2 token with a existinng clevis based encryption:
+The following script shows how to enroll a systemd-tpm2 token with a existing clevis based encryption:
 ```bash
 export device=/dev/sda6
 export keyslot=$(sudo cryptsetup luksDump "$device" --dump-json-metadata | jq -c '.tokens.[] | select( .type == "clevis") | .keyslots | first' | head -n1)
-- 
2.43.0


