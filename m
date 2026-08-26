Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E843AC5DF97
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 15:21:10 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15248.1787757660756067335
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2026 08:21:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=RGVR/4gk;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-2026082615205753060cc7660002071e-k0wkq2@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2026082615205753060cc7660002071e
        for <cip-dev@lists.cip-project.org>;
        Wed, 26 Aug 2026 17:20:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=uZZe6NBGaqq4TKsqdndLle1zk7X5pTqg9PKOVHiGMlY=;
 b=RGVR/4gkdckOEnuezdd+5qUzLoxmD2mkTy1CJ7CUqi+/vX4eKbfULili0ekDZ+NkRTjnH8
 vh9bBevPXfCHNYIeiBNLyWtdzArXgBF+YXRsrbZKMr+9+guPgQQhfAm3k3eWrbVjrpM50qU1
 mEPBM6JDIwx40qZR8MFhcIgJ9aNjdfp+e2tXU/cJAREjN0hGPH8a1Cy/FSYg3OtxrhDlLAYR
 h8QSgLR3fRNAHSu6YtIZXFfkJvjOaNRgHo7ZnBmlWoYVvTmz9gFYhKIdZDtSKZryy9IHiHse
 VVgn0gFkrCLwum/X0DHaSg5hhGBIXohuC56xqP++PmThROUX2yWVMOjw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v2 2/7] cip-initramfs-functions: Add secure_boot_enabled helper
Date: Wed, 26 Aug 2026 17:20:50 +0200
Message-ID: <4745d18be23117143b072a73c607b4c0d95b781d.1787757655.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1787757655.git.jan.kiszka@siemens.com>
References: <cover.1787757655.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Aug 2026 15:21:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24029

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


