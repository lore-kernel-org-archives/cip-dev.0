Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A595FC4345F
	for <webhook@archiver.kernel.org>; Fri,  3 May 2024 08:59:57 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.8242.1714726793989878016
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 May 2024 01:59:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=YD2BZsUB;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20240503085951fb62dcefc3a4820a30-uqilwj@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240503085951fb62dcefc3a4820a30
        for <cip-dev@lists.cip-project.org>;
        Fri, 03 May 2024 10:59:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=hIlu2juGfzbJLyEk99yvQ81M0wnnsCQxa6TXCVVCGy4=;
 b=YD2BZsUByWVv9sBaPmYzpkePdCkCfJqlidCdZdu4UvrvgQotNWDJszhUCv4ZjyJnoubJfh
 SiuLRSsrm313KFxpELzOxVoJLiB/mdaU/ps9XKidpoTBsZOAY69EchvAComZpcPrsl/RvWRJ
 8Uew+jbepvplUKnsOeG8+ZilRd/lQ=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH] wic/plugins/efibootguard*: Take --size and --fixed-size into account
Date: Fri,  3 May 2024 10:59:00 +0200
Message-ID: <20240503085950.667611-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 May 2024 08:59:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15813

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes the issue that wic arguments --size and --fixed-size
are not correctly interpreted.

part.get_extra_block_count is removed as it is already take into
account by part.get_rootfs_size[1].

This fixes issue #104.

[1]: https://github.com/ilbers/isar/blob/26e9653eb5e096e8b367ebd73054b2fd2310e9bc/scripts/lib/wic/partition.py#L104

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../wic/plugins/source/efibootguard-boot.py   | 20 ++++++-------------
 .../wic/plugins/source/efibootguard-efi.py    | 20 ++++++++-----------
 2 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index 4e3aefb..c8d6a19 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -143,25 +143,17 @@ class EfibootguardBootPlugin(SourcePlugin):
             # Write label as utf-16le to EFILABEL file
         with open("%s/EFILABEL" % part_rootfs_dir, 'wb') as filedescriptor:
             filedescriptor.write(part.label.upper().encode("utf-16le"))
+        du_cmd = "du --apparent-size --block-size=1K --summarize %s" % part_rootfs_dir
+        rootfs_size_kb = int(exec_cmd(du_cmd).split()[0])
 
-        du_cmd = "du --apparent-size -ks %s" % part_rootfs_dir
-        blocks = int(exec_cmd(du_cmd).split()[0])
-
-        extra_blocks = part.get_extra_block_count(blocks)
-        if extra_blocks < BOOTDD_EXTRA_SPACE:
-            extra_blocks = BOOTDD_EXTRA_SPACE
-
-        blocks += extra_blocks
-        blocks = blocks + (16 - (blocks % 16))
-
-        msger.debug("Added %d extra blocks to %s to get to %d total blocks",
-                    extra_blocks, part.mountpoint, blocks)
-
+        adjusted_rootfs_size = part.get_rootfs_size(rootfs_size_kb)
         # dosfs image, created by mkdosfs
         bootimg = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
 
+        # create a fat16 partition with a sector size of 512
+        # block size is always 1k
         dosfs_cmd = "mkdosfs -F 16 -S 512 -n %s -C %s %d -i %s" % \
-            (part.label.upper(), bootimg, blocks, part.fsuuid)
+            (part.label.upper(), bootimg, adjusted_rootfs_size, part.fsuuid)
         exec_cmd(dosfs_cmd)
 
         mcopy_cmd = "mcopy -v -i %s -s %s/* ::/" % (bootimg, part_rootfs_dir)
diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
index e82e990..1796eb1 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
@@ -100,23 +100,19 @@ class EfibootguardEFIPlugin(SourcePlugin):
                                                name)
         exec_cmd(cp_to_deploy_cmd, True)
 
-        du_cmd = "du --apparent-size -ks %s" % part_rootfs_dir
-        blocks = int(exec_cmd(du_cmd).split()[0])
-
-        extra_blocks = part.get_extra_block_count(blocks)
-        if extra_blocks < BOOTDD_EXTRA_SPACE:
-            extra_blocks = BOOTDD_EXTRA_SPACE
-        blocks += extra_blocks
-        blocks = blocks + (16 - (blocks % 16))
-
-        msger.debug("Added %d extra blocks to %s to get to %d total blocks",
-                    extra_blocks, part.mountpoint, blocks)
+        du_cmd = "du --apparent-size --block-size=1k --summarize %s" % part_rootfs_dir
+        rootfs_size_kb = int(exec_cmd(du_cmd).split()[0])
 
+        #  get_rootfs_size use kb as input
+        adjusted_rootfs_size = part.get_rootfs_size(rootfs_size_kb)
         # dosfs image, created by mkdosfs
         efi_part_image = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
 
+        # create a fat partition with a sector size of 512
+        # mkdosfs selects automatically the allocation type table
+        # block size is always 1k
         dosfs_cmd = "mkdosfs -S 512 -n %s -C %s %d -i %s" % \
-            (part.label.upper(), efi_part_image, blocks, part.fsuuid)
+            (part.label.upper(), efi_part_image, adjusted_rootfs_size, part.fsuuid)
         exec_cmd(dosfs_cmd)
 
         # mtools for buster have problems with resursive mcopy.
-- 
2.43.0


