Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C779C071DB
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:20:49 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.15350.1713514840670917953
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:20:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=G30d1tqh;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-202404190820389efd0dc916df8a6be2-26h9h_@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202404190820389efd0dc916df8a6be2
        for <cip-dev@lists.cip-project.org>;
        Fri, 19 Apr 2024 10:20:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=hZWFPVFrzPtYlO46DkdPXQh4aq5cOQir0S+6ZvWTGUA=;
 b=G30d1tqhc/3Fylu4rDJObNpgXwoa6IT1dIjLbSCt8YeJ9TAIAzr1+EzpR5I2c1oPsrcQlT
 WndKODWJIq/Po53lj2341JbrMfDky+z+ADvLNbiKgWpMShCdlAxrp911M7RXT28gA1ENUljh
 OdFaWf3Mluel9mBt3SNg5CaXubBKg=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: johnxw@amazon.com,
	cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 7/7] README: Add rootfs encryption
Date: Fri, 19 Apr 2024 10:20:17 +0200
Message-ID: <20240419082036.2389583-8-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240419082036.2389583-1-Quirin.Gylstorff@siemens.com>
References: <20240419082036.2389583-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:20:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15646

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.tpm2.encryption.md | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
index 69a18dd..a0a78d2 100644
--- a/doc/README.tpm2.encryption.md
+++ b/doc/README.tpm2.encryption.md
@@ -44,6 +44,16 @@ Each entry uses the schema `<partition-label>:<mountpoint>:<reencrypt or format>
 - `reencrypt` uses `cryptsetup reencrypt` to encrypt the exiting content of the partition. This reduces the partition by 32MB and the file system by a similar amount
 - `format` creates a empty LUKS partition and creates a file system defined with the shell command given in `CRYPT_CREATE_FILE_SYSTEM_CMD`
 
+#### Encrypted root file system
+
+To encrypt the root file system the variable `CRYPT_PARTITIONS` needs to be set to:
+```
+CRYPT_PARTITIONS = "systema::reencrypt systemb::reencrypt"
+```
+The mountpoint is empty as the root partition is mounted by another initramfs service.
+Both partitions are encrypted during first boot. The initramfs opens systema and systemb
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


