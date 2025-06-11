Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96965C71137
	for <webhook@archiver.kernel.org>; Wed, 11 Jun 2025 16:27:58 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.1266.1749659269921649176
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Jun 2025 09:27:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=FjXPuJbW;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-20250611162746c9cbe4ccb8456fb1ab-lyoyw_@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250611162746c9cbe4ccb8456fb1ab
        for <cip-dev@lists.cip-project.org>;
        Wed, 11 Jun 2025 18:27:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=iU41/TIL3Ktu2vfeJkqTtxQJ+4WyllkKdhDKC9eapIg=;
 b=FjXPuJbWqBYEaS9v8xwt8Wjf7snutOqyxw81C6oaX0y4fzHmmtXyk50aMkM8KizqEeBgl6
 7JbTlSn80p1lteoiS18GsiVvHrbKL93NcNwBnz99XJ1IT0QVTrABawRQAA5eSOTxCqDX7MNV
 lmvt4lcCmo9lAIfLfgLewJm2bzy29uWmnMexVlXmboY81f7CwWQWe0Sgz8QMkv3Z2NdURptx
 1xRirAADjqH3SHdOYJfws2nLeT+dJdmaDtUkZo/3uIOqJlFe1jvgRfykwyLtzETvlMyKM7A6
 z0vrV474r2UFimhoCtkltfrCwzjN0o1c9VxJg+qZvSVW4SoD2R7IL0DA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2] fix: overlay-hook: add missing dependency to e2fsprogs
Date: Wed, 11 Jun 2025 18:26:13 +0200
Message-ID: <20250611162745.741481-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Jun 2025 16:27:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19033

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The overlay-hook uses the e2fsck and mke2fs but has no
dependency to e2fsprogs.

This failed the qemu-riscv64 build as e2fsprogs are no longer required
in trixie, see
https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/commit/debian/control?h=debian/master&id=af35afe3dac341134e0a38c3c80d745efb80658d

Fixes: 8644fb16dbc45baae23941f001c5c5d4701fae87 (initramfs-overlay-hook: Check file system of INITRAMFS_OVERLAY_STORAGE_DEVICE)

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
Changes v2:
 - Add fixes information and reason why it failed in trixie

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


