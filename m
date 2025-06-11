Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C60BC678DC
	for <webhook@archiver.kernel.org>; Wed, 11 Jun 2025 13:23:48 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web11.7642.1749648220540202511
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Jun 2025 06:23:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=VM3dh6k1;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-51332-202506111323323e55d91627ab8e3e4c-3kdc9i@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202506111323323e55d91627ab8e3e4c
        for <cip-dev@lists.cip-project.org>;
        Wed, 11 Jun 2025 15:23:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=jd5/hWbeVvrht1QMh8QGyCJgo/6X7b/Fbh60phv1HeQ=;
 b=VM3dh6k1ZPHtC1PGkvCrkIGx0KjrCOiU2i7hNNnaItpt754Fi/fTJmxYTIJ0Gt7G2nDV7r
 7PUHC7ugHJ+TRqN0rITrpUzkCqw1A5uCsxjhT0VeYAsBuKWg/jogyXS4aHgpoTE4kOxOWf8e
 DJxl3vWshMhebDgqoadxzYq8cqyfWB+AlM1EmGiTUyJKRCEkyfJWRnKtDDRn+2hIXZHF97yd
 ROBuhTVjhitmhM8XF3Ev2616e4y+00TNNokyIGmguLC3QWIr3YW/tUocwHtuHeudvSs2A0kh
 5ftogkPXIiL0gOrDp/omKQDNlKwF+wmvoecyGtcUsU4MEMBO2FnRoNZg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] fix: overlay-hook: add missing dependency to e2fsprogs
Date: Wed, 11 Jun 2025 15:23:15 +0200
Message-ID: <20250611132331.175158-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Jun 2025 13:23:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19028

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The overlay-hook uses the e2fsck and mke2fs but has no
dependency to e2fsprogs.

This failed the qemu-riscv64 build.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb
index ec7f85b..a5b39d9 100644
--- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb
+++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb
@@ -42,7 +42,7 @@ TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
     INITRAMFS_OVERLAY_MOUNT_OPTION \
     INITRAMFS_OVERLAY_RECOVERY_SCRIPT"
 
-DEBIAN_DEPENDS .= ", awk, coreutils, util-linux"
+DEBIAN_DEPENDS .= ", awk, coreutils, util-linux, e2fsprogs"
 
 HOOK_ADD_MODULES = "overlay"
 HOOK_COPY_EXECS = "mountpoint awk e2fsck mke2fs"
-- 
2.47.0


