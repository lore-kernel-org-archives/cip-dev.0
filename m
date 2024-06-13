Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A140FC41513
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 09:16:41 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.3964.1718270199690338944
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jun 2024 02:16:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=cAAe4dtM;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20240613091637e985df6e6a60623a01-v5uyzp@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240613091637e985df6e6a60623a01
        for <cip-dev@lists.cip-project.org>;
        Thu, 13 Jun 2024 11:16:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=58xVTOATdz6SDUvL4Nz7AEODe8f/YxGAWqDnesrKTx0=;
 b=cAAe4dtMrJ8zpcW6KEQsrBKhq4jK5uOKATwb3ml1cfpD/KU6P4NlUrx6zHmpZYsqXBGde5
 Fzb6V4nWLGZrczipGUPqRGdWPfsh7u6i1xuUK/wyYFznHTAwt/GAvhyNwkHZee4DnjB1E6Mn
 edjasJsUp/cND3w5U7pRmGaf29jss=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v4 1/2] wic/plugins/efibootguard*: Take --size and --fixed-size into account
Date: Thu, 13 Jun 2024 11:16:18 +0200
Message-ID: <20240613091636.1156475-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240613091636.1156475-1-Quirin.Gylstorff@siemens.com>
References: <20240613091636.1156475-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jun 2024 09:16:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16198

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes the issue that wic arguments --size and --fixed-size
are not correctly interpreted.

This fixes issue #104.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../wic/plugins/source/efibootguard-boot.py   | 34 ++++---------------
 .../wic/plugins/source/efibootguard-efi.py    | 30 ++--------------
 2 files changed, 9 insertions(+), 55 deletions(-)

diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index 4e3aefb..2b06fd1 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -136,40 +136,20 @@ class EfibootguardBootPlugin(SourcePlugin):
                 msger.error("file %s not found in directory %s",
                             boot_file, kernel_dir)
                 exit(1)
-        cls._create_img(part_rootfs_dir, part, cr_workdir)
+        cls._create_img(part_rootfs_dir, part, cr_workdir,
+                        native_sysroot, oe_builddir)
 
     @classmethod
-    def _create_img(cls, part_rootfs_dir, part, cr_workdir):
-            # Write label as utf-16le to EFILABEL file
+    def _create_img(cls, part_rootfs_dir, part, cr_workdir,
+                    native_sysroot, oe_builddir):
+        # Write label as utf-16le to EFILABEL file
         with open("%s/EFILABEL" % part_rootfs_dir, 'wb') as filedescriptor:
             filedescriptor.write(part.label.upper().encode("utf-16le"))
 
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
-        # dosfs image, created by mkdosfs
         bootimg = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
 
-        dosfs_cmd = "mkdosfs -F 16 -S 512 -n %s -C %s %d -i %s" % \
-            (part.label.upper(), bootimg, blocks, part.fsuuid)
-        exec_cmd(dosfs_cmd)
-
-        mcopy_cmd = "mcopy -v -i %s -s %s/* ::/" % (bootimg, part_rootfs_dir)
-        exec_cmd(mcopy_cmd, True)
-
-        chmod_cmd = "chmod 644 %s" % bootimg
-        exec_cmd(chmod_cmd)
-
+        part.prepare_rootfs_msdos(bootimg, cr_workdir, oe_builddir,
+                                  part_rootfs_dir, native_sysroot, None)
         du_cmd = "du -Lbks %s" % bootimg
         bootimg_size = int(exec_cmd(du_cmd).split()[0])
 
diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
index e82e990..48f7523 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
@@ -100,35 +100,9 @@ class EfibootguardEFIPlugin(SourcePlugin):
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
-
-        # dosfs image, created by mkdosfs
         efi_part_image = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
-
-        dosfs_cmd = "mkdosfs -S 512 -n %s -C %s %d -i %s" % \
-            (part.label.upper(), efi_part_image, blocks, part.fsuuid)
-        exec_cmd(dosfs_cmd)
-
-        # mtools for buster have problems with resursive mcopy.
-        # Therefore, create the target dir via mmd first.
-        mmd_cmd = "mmd -i %s ::/EFI ::/EFI/BOOT" % (efi_part_image)
-        exec_cmd(mmd_cmd, True)
-        mcopy_cmd = "mcopy -v -i %s -s %s/EFI/BOOT/* ::/EFI/BOOT" % \
-            (efi_part_image, part_rootfs_dir)
-        exec_cmd(mcopy_cmd, True)
-
-        chmod_cmd = "chmod 644 %s" % efi_part_image
-        exec_cmd(chmod_cmd)
+        part.prepare_rootfs_msdos(efi_part_image, cr_workdir, oe_builddir,
+                                  part_rootfs_dir, native_sysroot, None)
 
         du_cmd = "du -Lbks %s" % efi_part_image
         efi_part_image_size = int(exec_cmd(du_cmd).split()[0])
-- 
2.43.0


