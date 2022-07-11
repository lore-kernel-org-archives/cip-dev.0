Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AB4C3F2D4
	for <webhook@archiver.kernel.org>; Mon, 11 Jul 2022 19:41:04 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web09.158.1657568462358557290
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Jul 2022 12:41:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=E/RHcv72;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226,
 mailfrom: fm-294854-202207111941001e9cf057363a2d90f8-2ii7qp@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 202207111941001e9cf057363a2d90f8
        for <cip-dev@lists.cip-project.org>;
        Mon, 11 Jul 2022 21:41:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=polFVpu3zLUceiWsvVzYwuK2YTntasdySnNYZBiX1DI=;
 b=E/RHcv72UgKlK1GB/Hq9G9NkeRX0fTdwm3X/6M5V7dkpRhL0sYiN/wk90qkAOXAm7fbzaF
 hlEBYPzWYIlKypgj38b/3BVl+lb287PQtqacW0AKYKV6/ekp+2sBzJpOgCIc00YSaiIlgbtA
 ss0+wnOL3aL3t2YDbLmx+LMw+7jA8=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Christian Storm <christian.storm@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 2/7] efibootguard: Do not rely on mcopy to
 perform recursive copies
Date: Mon, 11 Jul 2022 21:40:53 +0200
Message-Id: 
 <f08b660fa76e52b3c91b8e308281690e0af2e86b.1657568458.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1657568458.git.jan.kiszka@siemens.com>
References: <cover.1657568458.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Jul 2022 19:41:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8741

From: Jan Kiszka <jan.kiszka@siemens.com>

This is broken for old buster on ARM (or over qemu-user for ARM).

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/lib/wic/plugins/source/efibootguard-efi.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
index e1411cb..140b734 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
@@ -98,7 +98,11 @@ class EfibootguardEFIPlugin(SourcePlugin):
             (part.label.upper(), efi_part_image, blocks)
         exec_cmd(dosfs_cmd)
 
-        mcopy_cmd = "mcopy -v -i %s -s %s/* ::/" % \
+        # mtools for buster have problems with resursive mcopy.
+        # Therefore, create the target dir via mmd first.
+        mmd_cmd = "mmd -i %s ::/EFI ::/EFI/BOOT" % (efi_part_image)
+        exec_cmd(mmd_cmd, True)
+        mcopy_cmd = "mcopy -v -i %s -s %s/EFI/BOOT/* ::/EFI/BOOT" % \
             (efi_part_image, part_rootfs_dir)
         exec_cmd(mcopy_cmd, True)
 
-- 
2.35.3


