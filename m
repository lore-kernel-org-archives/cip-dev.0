Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B41C61DD2
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 05:42:07 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6177.1787722924430478247
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Aug 2026 22:42:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=D27a6ZKT;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-294854-2026082605420166b1277c6400020769-vua2zs@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2026082605420166b1277c6400020769
        for <cip-dev@lists.cip-project.org>;
        Wed, 26 Aug 2026 07:42:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=uZZe6NBGaqq4TKsqdndLle1zk7X5pTqg9PKOVHiGMlY=;
 b=D27a6ZKTnjtLXTVRenEuD1SVQGIFMGY1zRSeXxyV3JNqVKyfWBWj+q6w1HE1GcCBoh0Hg7
 uTepMbpbJVgqOVej1Wv5iqI2VeaeAES7P1hJmrxttS9byN+CZKU9a4IOxfolBt/EEiLTGBS7
 81J1BVSI4XoX9/jFqLN5ML817p0GVPxcDgoh6r2fn9Zu3ayQ3LxJseVJvHuVIxppXsUpRpJo
 n495nLUlB/mNktVKz6DphfXjMVcIwX+jrva3am331xJ1IMhP+mWfv9PcUO1g7JTpkNDmdTLK
 Fmn9UBXcl7Epf1jq0Euvyf40dSU6rc0y2zhvXf+JG8XTCKMVtqkXKSlA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH 2/7] cip-initramfs-functions: Add secure_boot_enabled helper
Date: Wed, 26 Aug 2026 07:41:40 +0200
Message-ID: <d55b05021ce583596d62e15daa1beddd6a32a242.1787722904.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1787722904.git.jan.kiszka@siemens.com>
References: <cover.1787722904.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Aug 2026 05:42:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24009

From: Jan Kiszka <jan.kiszka@siemens.com>

Will allow initramfs hooks to determine whether UEFI secure boot is
enabled. The user is responsible for deploying cmp and mountpoint
binaries into the initramfs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../files/cip-initramfs-functions                | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions b/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions
index a4c1fed6..f14956d5 100644
--- a/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions
+++ b/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions
@@ -68,3 +68,19 @@ scan_for_partitions() {
     fi
     return 1
 }
+
+# check if system was securely booted via UEFI
+secure_boot_enabled() {
+    efivars=/sys/firmware/efi/efivars
+    if ! mountpoint -q $efivars; then
+        mount -t efivarfs none $efivars
+    fi
+
+    secure_boot="$efivars/SecureBoot-8be4df61-93ca-11d2-aa0d-00e098032b8c"
+    setup_mode="$efivars/SetupMode-8be4df61-93ca-11d2-aa0d-00e098032b8c"
+    if printf '\001' | cmp -s -i 4:0 $secure_boot &&
+       printf '\000' | cmp -s -i 4:0 $setup_mode; then
+        return 0
+    fi
+    return 1
+}
-- 
2.47.3


