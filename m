Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA04EC4345F
	for <webhook@archiver.kernel.org>; Fri,  3 May 2024 14:54:29 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.15165.1714748061313825871
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 May 2024 07:54:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=AG4Rv97q;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20240503145417d6d2c49dffbf7dc835-_vlgic@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240503145417d6d2c49dffbf7dc835
        for <cip-dev@lists.cip-project.org>;
        Fri, 03 May 2024 16:54:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=IR+pbCElAI4WdlCqjPI5uU616Z9cRIXqlK92A4Bnyfo=;
 b=AG4Rv97qIKP2ahsYWh/d4Gx02zTtCqG6CmiG8RC7fVmzPZgOUfeNvcS5E46x7dnsfvtJeR
 HWzdOIaHYeWKBO83IcwPb5XfzBo1YjecsIq/EHEL+yyT1tVGivSUvGSnVVQQre5oUXM7A8sy
 aMVmG0xFjeWhJd7h5QQxPBsmm1l4Y=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2] wic/plugins/efibootguard*: Take --size and --fixed-size into account
Date: Fri,  3 May 2024 16:53:58 +0200
Message-ID: <20240503145416.663757-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 May 2024 14:54:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15822

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes the issue that wic arguments --size and --fixed-size
are not correctly interpreted.

This fixes issue #104.

[1]: https://github.com/ilbers/isar/blob/26e9653eb5e096e8b367ebd73054b2fd2310e9bc/scripts/lib/wic/partition.py#L104

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
I tested it with qemu-amd64 and qemu-arm64
Changes v2:
 - replace size calculation with part.prepare_rootfs_msdos

 .../wic/plugins/source/efibootguard-boot.py   | 37 +++++--------------
 .../wic/plugins/source/efibootguard-efi.py    | 30 +--------------
 2 files changed, 11 insertions(+), 56 deletions(-)

diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index 4e3aefb..1101f38 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -136,40 +136,21 @@ class EfibootguardBootPlugin(SourcePlugin):
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
-
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
+        # create a fat16 partition with a sector size of 512
+        part.mkfs_extraopts += '-S 512 -F 16'
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


