Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4FBC7EE2F
	for <webhook@archiver.kernel.org>; Fri, 24 Feb 2023 16:28:41 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.22337.1677256118508473076
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Feb 2023 08:28:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=aNm3AWC1;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-2023022416283694cfb22c2d9bbddb0a-qfi5ak@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2023022416283694cfb22c2d9bbddb0a
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Feb 2023 17:28:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=KBxPo186S6Ar5dBudrj+kGIoXqcT7IgZBIb8xMSHh9Q=;
 b=aNm3AWC10g36eyuvUSTTedVPMFqvVB/sZxXKtERFlCjKFt6dQwJJh1HX9GxWnVM0MzCpSS
 S7wmcZKoRzXSrzNrZPdHRcbNPK2dMb3+IpyyKW0MKpPWHbrnfvpXLWjVjywGj9M3XKh+xF0K
 PZshqgbec373NtPmEgfwT6MDCBdOs=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	christian.storm@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 8/8] Add README for encrypted partitions
Date: Fri, 24 Feb 2023 17:28:32 +0100
Message-Id: <20230224162832.327030-9-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230224162832.327030-1-Quirin.Gylstorff@siemens.com>
References: <20230224162832.327030-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Feb 2023 16:28:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10822

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.tpm2.encryption.md | 39 +++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 doc/README.tpm2.encryption.md

diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
new file mode 100644
index 0000000..4b2f18b
--- /dev/null
+++ b/doc/README.tpm2.encryption.md
@@ -0,0 +1,39 @@
+# Encrypted Partitions
+By adding the recipe `initramfs-crypt-hook` to the initramfs build user defined partitions will be
+encrypted during first boot. The encrypted partition is a LUKS partition and uses a TPM to secure the
+passphrase on the device.
+
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
+
+# initramfs-crypt-hook configuration
+
+The initramfs-crypt-hook recipe has the following variables which can be overwritten during image build:
+- CRYPT_PARTITIONS
+- CRYPT_CREATE_FILE_SYSTEM_CMD
+
+## CRYPT_PARTITIONS
+
+The variable `CRYPT_PARTITIONS` contains the information which partition shall be encrypted where to mount. Each entry uses the schema `<partition-label>:<mountpoint>:<reencrypt or format>`.
+- The `partition-label` is used to identify the partition on the disk
+- The `mountpoint` is used mount the decrypted partition in the root file system
+- `reencrypt` uses `cryptsetup reencrypt` to reencrypt the exiting content of the partition. This reduces the partition by 32MB and the file system by a similar amount
+- `format` creates a empty LUKS partition and creates a file system defined with the shell command given in `CRYPT_CREATE_FILE_SYSTEM_CMD`
+
+## CRYPT_CREATE_FILE_SYSTEM_CMD
+
+The variable `CRYPT_CREATE_FILE_SYSTEM_CMD` contains the command to create a new file system on a newly
+encrypted partition. The Default (`mke2fs -t ext4`) creates an ext4 partition.
+
+# TPM2 protected LUKS passphrase
+
+The recipe `initramfs-crypt-hook` uses `systemd-cryptenroll` to enroll a TPM2 protected LUKS passphrase.
+The procedure for storing a key is described in https://github.com/systemd/systemd/blob/0254e4d66af7aa893b31b2326335ded5dde48b51/src/shared/tpm2-util.c#L1395.
-- 
2.39.1


