Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7134CC7EE23
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 18:51:12 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.14354.1684819147688439191
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 May 2023 22:19:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=pXBj72tB;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-72506-202305230519056a07c4a7968197ec48-vnjmth@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202305230519056a07c4a7968197ec48
        for <cip-dev@lists.cip-project.org>;
        Tue, 23 May 2023 07:19:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=MSe7Bmqs62U7U/VXRxlvNWQfGhx/BL7cii8eBzZsY3Q=;
 b=pXBj72tBu1a88lH+xXccKjGkK4s1t5p8zpKLxIfO9XHVgarMNEWiTE2l032BW1zjj2sWu2
 bJ8X3SlzFNPXJJl4Rh6Fwk5mPiNcDcJKmrLNnm9injVC5dQKr0anZax/scXo09jO8J2U5SsS
 Fkx+42qg9EJb5Xdku1GtfBb8RVH2A=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	meng.ding@siemens.com,
	chengshu.mou@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 2/3] docs(secureboot): fix logical issues in example
Date: Tue, 23 May 2023 13:18:45 +0800
Message-Id: <20230523051846.1007400-3-felix.moessbauer@siemens.com>
In-Reply-To: <20230523051846.1007400-1-felix.moessbauer@siemens.com>
References: <20230523051846.1007400-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 18:51:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11623

This patch adapts the provided example to recent code changes in
cip-core. Further, it makes the example more precise by using the key
prefixes used in generate_secure_boot_keys.sh.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 doc/README.secureboot.md | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index bc238fb..797e913 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -112,7 +112,7 @@ cp /lib/efitools/x86_64-linux-gnu/KeyTool.efi secureboot-tools
 to the current directory. OVMF_VARS_4M.fd contains no keys can be instrumented for secureboot.
 3. Start QEMU with the script scripts/start-efishell.sh
 ```
-scripts/start-efishell.sh secureboot-tools
+./scripts/start-efishell.sh secureboot-tools
 ```
 4. Start the KeyTool.efi FS0:\KeyTool.efi and execute the the following steps:
 ```
@@ -120,15 +120,15 @@ scripts/start-efishell.sh secureboot-tools
              -> "The Allowed Signatures Database (db)"
                 -> "Add New Key"
                 -> Change/Confirm device
-                -> Select "DB.esl" file
+                -> Select "demoDB.esl" file
              -> "The Key Exchange Key Database (KEK)"
                 -> "Add New Key"
                 -> Change/Confirm device
-                -> Select "KEK.esl" file
+                -> Select "demoKEK.esl" file
              -> "The Platform Key (PK)
                 -> "Replace Key(s)"
                 -> Change/Confirm device
-                -> Select "PK.auth" file
+                -> Select "demoPK.auth" file
 ```
 5. quit QEMU
 
@@ -151,22 +151,26 @@ header:
 local_conf_header:
   secure-boot-image: |
     IMAGE_FSTYPES = "wic"
+    IMAGE_TYPEDEP:wic += "verity"
+    SWU_ROOTFS_TYPE = "verity"
     WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
     INITRAMFS_INSTALL:append = " initramfs-verity-hook"
     # abrootfs cannot be installed together with verity
     INITRAMFS_INSTALL:remove = "initramfs-abrootfs-hook"
 
-local_conf_header:
   secure-boot: |
     IMAGER_BUILD_DEPS += "ebg-secure-boot-signer"
     IMAGER_INSTALL += "ebg-secure-boot-signer"
 
-# Use user-generated keys
+    # Use user-generated keys
     PREFERRED_PROVIDER_secure-boot-secrets = "secure-boot-key"
 
+  secureboot_override: |
+    OVERRIDES .= ":secureboot"
+
   user-keys: |
-    SB_CERT = "demo.crt"
-    SB_KEY = "demo.key"
+    SB_CERT = "demoDB.crt"
+    SB_KEY = "demoDB.key"
 ```
 
 Replace `demo` with the name of the user-generated certificates. The user-generated certificates
-- 
2.39.2


