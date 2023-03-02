Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F446C678D4
	for <webhook@archiver.kernel.org>; Thu,  2 Mar 2023 15:31:00 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.18841.1677770863423877111
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Mar 2023 07:27:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=hSjFqxVz;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-72506-202303021527411ed7e5c9a983d5b956-8ordox@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202303021527411ed7e5c9a983d5b956
        for <cip-dev@lists.cip-project.org>;
        Thu, 02 Mar 2023 16:27:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=LmMPfiOEYL382rOy/Flrt2p72Ug5pHJo838aBYFPltw=;
 b=hSjFqxVz5jZnbOWn5c1YuKUyba4B66NAE/PpMlW/OK0jItxFSjrVonvANVWUaZyqbq9CK6
 5dTP4/1sdJMor2+LEyqUNLoIGLEzss+5iuivXzNNb+OwZqXVVp7YGrkSBA7RD4VnVIwzhRXz
 ETc02ueA97Pd2f5Ep+YnvJCy+yDac=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: daniel.bovensiepen@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v3 4/9] wic(ebg): add support for riscv64
Date: Thu,  2 Mar 2023 15:26:54 +0000
Message-Id: <20230302152659.2096307-5-felix.moessbauer@siemens.com>
In-Reply-To: <20230302152659.2096307-1-felix.moessbauer@siemens.com>
References: <20230302152659.2096307-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Mar 2023 15:31:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10879

This patch adds the mapping between the efi architecture and the distro
architecture for riscv64.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 scripts/lib/wic/plugins/source/efibootguard-boot.py | 6 ++++--
 scripts/lib/wic/plugins/source/efibootguard-efi.py  | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index 3d6b2d7..0de28ca 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -185,13 +185,15 @@ class EfibootguardBootPlugin(SourcePlugin):
             "amd64": "x64",
             "arm64": "aa64",
             "armhf": "arm",
-            "i386": "ia32"
+            "i386": "ia32",
+            "riscv64" : "riscv64"
         }
         distro_to_lib_arch = {
             "amd64": "x86_64-linux-gnu",
             "arm64": "aarch64-linux-gnu",
             "armhf": "arm-linux-gnueabihf",
-            "i386": "i386-linux-gnu"
+            "i386": "i386-linux-gnu",
+            "riscv64": "riscv64-linux-gnu",
         }
         rootfs_path = rootfs_dir.get('ROOTFS_DIR')
         distro_arch = get_bitbake_var("DISTRO_ARCH")
diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
index 2d16fe3..d6cdf0f 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
@@ -56,14 +56,16 @@ class EfibootguardEFIPlugin(SourcePlugin):
             "amd64": "x64",
             "arm64": "aa64",
             "armhf": "arm",
-            "i386": "ia32"
+            "i386": "ia32",
+            "riscv64" : "riscv64"
         }
 
         distro_to_lib_arch = {
             "amd64": "x86_64-linux-gnu",
             "arm64": "aarch64-linux-gnu",
             "armhf": "arm-linux-gnueabihf",
-            "i386": "i386-linux-gnu"
+            "i386": "i386-linux-gnu",
+            "riscv64": "riscv64-linux-gnu",
         }
 
         distro_arch = get_bitbake_var("DISTRO_ARCH")
-- 
2.34.1


