Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57218C6FD1C
	for <webhook@archiver.kernel.org>; Mon,  6 Mar 2023 12:39:34 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.32031.1678106370750532338
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Mar 2023 04:39:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=BDaCDz8h;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-202303061239305f40acbf8486e08f8a-ipdwfc@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202303061239305f40acbf8486e08f8a
        for <cip-dev@lists.cip-project.org>;
        Mon, 06 Mar 2023 13:39:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=/rRDDkBDYXvnK6t0nBUSNigjm5ySGyiqHzGeJwbmYm8=;
 b=BDaCDz8hW+wAxAAMuhwQmNHNkJ/tsr3VcgFjkFGGUrfO9faZ+w7GR9VB0p2R7qac9tJlqU
 nOkdMaoLbzOyQS8onZD8ohPsty+ZdyRI902aO08BWgMSjmkabJzkz/Cv8llUrxfXqvM4e+Wn
 CHzV3qM+qWBNz89xxEt9Xm+tHC+lk=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	christian.storm@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 7/7] Add README for encrypted partitions
Date: Mon,  6 Mar 2023 13:39:26 +0100
Message-Id: <20230306123926.243471-8-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230306123926.243471-1-Quirin.Gylstorff@siemens.com>
References: <20230306123926.243471-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Mar 2023 12:39:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10941

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.tpm2.encryption.md | 55 +++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 doc/README.tpm2.encryption.md

diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
new file mode 100644
index 0000000..58ebb8a
--- /dev/null
+++ b/doc/README.tpm2.encryption.md
@@ -0,0 +1,55 @@
+# Encrypted Partitions
+
+By adding the recipe `initramfs-crypt-hook` to the initramfs build user defined partitions will be
+encrypted during first boot. The encrypted partition is a LUKS partition and uses a TPM to secure the
+passphrase on the device.
+
+## Requirements
+
+To enroll the keys Debian 12(bookworm) or Debian 11(bullseye) with backports is required. 
+The implementation in Debian 11 is for *demonstration purpose only* as we need backports for
+systemd >= 248. [systemd version 248](https://github.com/systemd/systemd/blob/a41ac8ac407a1a58612059a45229f0d440f58e28/NEWS#L3391) adds the necessary systemd-cryptenroll functionality.
+
+Testing with qemu-amd64 requires the package `swtpm`. Under Debian/Ubuntu this can be installed
+
+``` shell
+apt-get install swtpm
+```
+
+## TPM2 protected LUKS passphrase
+
+The recipe `initramfs-crypt-hook` uses `systemd-cryptenroll` to enroll a TPM2 protected LUKS passphrase.
+The procedure for storing a key is described in [systemd/src/shared/tpm2-util.c](https://github.com/systemd/systemd/blob/0254e4d66af7aa893b31b2326335ded5dde48b51/src/shared/tpm2-util.c#L1395).
+
+## How to build an QEMU image with TPM encryption
+An example for qemu-amd64 can be build with by selecting the option after calling:
+
+```
+./kas-container menu
+```
+or by adding using the following command line build:
+
+```
+./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/tpm.yml
+```
+## initramfs-crypt-hook configuration
+
+The initramfs-crypt-hook recipe has the following variables which can be overwritten during image build:
+- CRYPT_PARTITIONS
+- CRYPT_CREATE_FILE_SYSTEM_CMD
+
+### CRYPT_PARTITIONS
+
+The variable `CRYPT_PARTITIONS` contains the information which partition shall be encrypted where to mount it.
+Each entry uses the schema `<partition-label>:<mountpoint>:<reencrypt or format>`.
+- The `partition-label` is used to identify the partition on the disk
+- The `mountpoint` is used mount the decrypted partition in the root file system
+- `reencrypt` uses `cryptsetup reencrypt` to encrypt the exiting content of the partition. This reduces the partition by 32MB and the file system by a similar amount
+- `format` creates a empty LUKS partition and creates a file system defined with the shell command given in `CRYPT_CREATE_FILE_SYSTEM_CMD`
+
+### CRYPT_CREATE_FILE_SYSTEM_CMD
+
+The variable `CRYPT_CREATE_FILE_SYSTEM_CMD` contains the command to create a new file system on a newly
+encrypted partition. The Default (`mke2fs -t ext4`) creates an ext4 partition.
+
+
-- 
2.39.2


