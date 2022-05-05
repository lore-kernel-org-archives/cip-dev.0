Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80E7C4167B
	for <webhook@archiver.kernel.org>; Thu,  5 May 2022 16:43:38 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.13542.1651769016786053283
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 May 2022 09:43:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=DcrRxyoL;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-294854-202205051643347f59f8fd054e1c9528-r1uomi@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 202205051643347f59f8fd054e1c9528
        for <cip-dev@lists.cip-project.org>;
        Thu, 05 May 2022 18:43:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=HT3kh+C44U3cSEYIRuapZjdcINaVRBiHj3Xia/tPa6k=;
 b=DcrRxyoLlIZ+OB1j1el6DYURQBsCGtL/Pvif2VMP8WXWCiBfUCimqPKgNv9sSW0l6bz9m5
 EvbVqg9CeKHUFbUUPt5L/yWFKumRN9uVEYjDO4s7imz9Vagq8E+vBWFI1twEPnE8fqhcuZDl
 r03KAvKUqK3sMd09cog/H8wNJou2c=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH v2 09/13] efibootguard: Use new unified kernel
 image generation
Date: Thu,  5 May 2022 18:43:25 +0200
Message-Id: 
 <05dd963af0588e60dced70d901073a8021cb3ed6.1651769009.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1651769009.git.jan.kiszka@siemens.com>
References: <cover.1651769009.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 May 2022 16:43:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8265

From: Jan Kiszka <jan.kiszka@siemens.com>

Switch to the unified kernel image and its generator script that EFI
Boot Guard now provides. So far this only simplifies the generation
process. But it will also allow to use the more advanced device tree
embedding of the EBG linux-stub later on.

As the linux-stub uses LINUX_EFI_INITRD_MEDIA_GUID for loading the
initrd, we need to restrict support to CIP kernel 5.10 as this feature
was only introduced with 5.8.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig                                       |  2 +-
 .../wic/plugins/source/efibootguard-boot.py   | 27 +++++--------------
 2 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/Kconfig b/Kconfig
index 8032ede..135794d 100644
--- a/Kconfig
+++ b/Kconfig
@@ -127,7 +127,7 @@ config KAS_INCLUDE_TESTING
 	string
 	default "kas/opt/test.yml" if IMAGE_TESTING
 
-if IMAGE_FLASH
+if IMAGE_FLASH && !KERNEL_4_4 && !KERNEL_4_19
 
 config IMAGE_SWUPDATE
 	bool "SWUpdate support for root partition"
diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index 9267033..47c6884 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -113,7 +113,7 @@ class EfibootguardBootPlugin(SourcePlugin):
             % (
                 part.label.upper(),
                 boot_image,
-                '-a "%s"' % cmdline,
+                '-a "%s"' % cmdline if unified_kernel != 'y' else '',
                 source_params.get("revision", 1),
                 wdog_timeout
             )
@@ -181,15 +181,9 @@ class EfibootguardBootPlugin(SourcePlugin):
             "i386": "ia32"
         }
         rootfs_path = rootfs_dir.get('ROOTFS_DIR')
-        os_release_file = "{root}/etc/os-release".format(root=rootfs_path)
-        efistub = "{rootfs_path}/usr/lib/systemd/boot/efi/linux{efiarch}.efi.stub"\
+        efistub = "{rootfs_path}/usr/share/efibootguard/kernel-stub{efiarch}.efi"\
             .format(rootfs_path=rootfs_path,
                     efiarch=distro_to_efi_arch[get_bitbake_var("DISTRO_ARCH")])
-        msger.debug("osrelease path: %s", os_release_file)
-        kernel_cmdline_file = "{cr_workdir}/kernel-command-line-file.txt"\
-            .format(cr_workdir=cr_workdir)
-        with open(kernel_cmdline_file, "w") as cmd_fd:
-            cmd_fd.write(cmdline)
         uefi_kernel_name = "linux.efi"
         uefi_kernel_file = "{deploy_dir}/{uefi_kernel_name}"\
             .format(deploy_dir=deploy_dir, uefi_kernel_name=uefi_kernel_name)
@@ -197,23 +191,14 @@ class EfibootguardBootPlugin(SourcePlugin):
             .format(deploy_dir=deploy_dir, kernel_image=kernel_image)
         initrd = "{deploy_dir}/{initrd_image}"\
             .format(deploy_dir=deploy_dir, initrd_image=initrd_image)
-        objcopy_cmd = 'objcopy \
-            --add-section .osrel={os_release_file} \
-            --change-section-vma .osrel=0x20000 \
-            --add-section .cmdline={kernel_cmdline_file} \
-            --change-section-vma .cmdline=0x30000 \
-            --add-section .linux={kernel} \
-            --change-section-vma .linux=0x2000000 \
-            --add-section .initrd={initrd} \
-            --change-section-vma .initrd=0x3000000 \
-            {efistub} {uefi_kernel_file}'.format(
-                os_release_file=os_release_file,
-                kernel_cmdline_file=kernel_cmdline_file,
+        cmd = 'bg_gen_unified_kernel {efistub} {kernel} {uefi_kernel_file} \
+            -c "{cmdline}" -i {initrd}'.format(
+                cmdline=cmdline,
                 kernel=kernel,
                 initrd=initrd,
                 efistub=efistub,
                 uefi_kernel_file=uefi_kernel_file)
-        exec_cmd(objcopy_cmd)
+        exec_cmd(cmd, as_shell=True)
 
         cls._sign_file(signee=uefi_kernel_file, source_params=source_params)
 
-- 
2.34.1


