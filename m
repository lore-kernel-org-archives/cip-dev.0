Return-Path: <srinuvasan.a@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B0FCD37AE
	for <webhook@archiver.kernel.org>; Wed,  4 Sep 2024 06:42:16 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.44036.1725432126356823399
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Sep 2024 23:42:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=srinuvasan.a@siemens.com header.s=fm1 header.b=I8lhgy7D;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1324425-20240904064202df172a0a8ccd6cddf5-pndf1t@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240904064202df172a0a8ccd6cddf5
        for <cip-dev@lists.cip-project.org>;
        Wed, 04 Sep 2024 08:42:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=srinuvasan.a@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=AWxgHylLOtSwnzxJzvjbtQHMr/eabBi88pR9lj8J3RU=;
 b=I8lhgy7DTlYcP9MSGybQiLF1xS/RgOgLY0v2qmrDJ0pNYMiFRDhuhCm1W0E7lD/RV0JVnD
 fNxHdRtOCSYKGQv2ZhVHMpPslJTLyAaeFFFXEo+UQruS3on2ju40zKCjfgbj9iofsGmFd4mC
 dsbiupqwwGI5pa6/hRX9kOzYIKFboYS/uALy//XXRKlDOSb/LiEkEPHa9ZCMmuzVas/urMnu
 5Hi1uv0305qsjb1k2Ar1MPwQ4pzJzE9Tyl9ppZIrbHNybkDn2gvjHOz7j2OxlAqzfEeXBnhV
 hNRi8dkMqzPg2cbDygb/pvObDZDIlcA5JFtowKlydWdn2W/Q4QI5DXgw==;
From: srinuvasan.a@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	srinuvasan <srinuvasan.a@siemens.com>
Subject: [PATCH][isar-cip-core] scripts/lib/wic/plugins/source: Use F-string instead of traditional .format() method
Date: Wed,  4 Sep 2024 12:12:23 +0530
Message-Id: <20240904064223.869919-1-srinuvasan.a@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1324425:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Sep 2024 06:42:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16844

From: srinuvasan <srinuvasan.a@siemens.com>

Use f string for string interpolation and formatting instead of traditional .format()
method.

f-strings are generally preferred due to their readability,simplicity and efficiency,
and moreover there is no functional changes apart from the optimization.

Signed-off-by: srinuvasan <srinuvasan.a@siemens.com>
---
 .../wic/plugins/source/efibootguard-boot.py   | 31 +++++--------------
 .../wic/plugins/source/efibootguard-efi.py    | 17 +++-------
 2 files changed, 12 insertions(+), 36 deletions(-)

diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index 2b06fd1..ad749fb 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -170,29 +170,16 @@ class EfibootguardBootPlugin(SourcePlugin):
             msger.error("Bitbake variable 'EFI_LIB_ARCH' not set, exiting\n")
             exit(1)
 
-        efistub = "{rootfs_path}/usr/lib/{libpath}/efibootguard/kernel-stub{efiarch}.efi"\
-            .format(rootfs_path=rootfs_path,
-                    libpath=libarch,
-                    efiarch=efiarch)
+        efistub = f'{rootfs_path}/usr/lib/{libarch}/efibootguard/kernel-stub{efiarch}.efi'
         uefi_kernel_name = "linux.efi"
-        uefi_kernel_file = "{deploy_dir}/{uefi_kernel_name}"\
-            .format(deploy_dir=deploy_dir, uefi_kernel_name=uefi_kernel_name)
-        kernel = "{deploy_dir}/{kernel_image}"\
-            .format(deploy_dir=deploy_dir, kernel_image=kernel_image)
-        initrd = "{deploy_dir}/{initrd_image}"\
-            .format(deploy_dir=deploy_dir, initrd_image=initrd_image)
-        cmd = 'bg_gen_unified_kernel {efistub} {kernel} {uefi_kernel_file} \
-            -c "{cmdline}" -i {initrd}'.format(
-                cmdline=cmdline,
-                kernel=kernel,
-                initrd=initrd,
-                efistub=efistub,
-                uefi_kernel_file=uefi_kernel_file)
+        uefi_kernel_file = f'{deploy_dir}/{uefi_kernel_name}'
+        kernel = f'{deploy_dir}/{kernel_image}'
+        initrd = f'{deploy_dir}/{initrd_image}'
+        cmd = f'bg_gen_unified_kernel {efistub} {kernel} {uefi_kernel_file} -c "{cmdline}" -i {initrd}'
         if dtb_files:
             for dtb in dtb_files:
-                cmd += ' -d {deploy_dir}/{dtb_file}'.format(
-                    deploy_dir=deploy_dir,
-                    dtb_file=os.path.basename(dtb))
+                dtb_file=os.path.basename(dtb)
+                cmd += f' -d {deploy_dir}/{dtb_files}'
         exec_cmd(cmd, as_shell=True)
 
         cls._sign_file(signee=uefi_kernel_file, source_params=source_params)
@@ -206,9 +193,7 @@ class EfibootguardBootPlugin(SourcePlugin):
             msger.info("sign with script %s", sign_script)
             orig_signee = signee + ".unsigned"
             os.rename(signee, orig_signee)
-            sign_cmd = "{sign_script} {orig_signee} {signee}"\
-                .format(sign_script=sign_script, orig_signee=orig_signee,
-                        signee=signee)
+            sign_cmd = f'{sign_script} {orig_signee} {signee}'
             exec_cmd(sign_cmd)
         elif sign_script and not os.path.exists(sign_script):
             msger.error("Could not find script %s", sign_script)
diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
index 48f7523..c443d14 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
@@ -73,16 +73,14 @@ class EfibootguardEFIPlugin(SourcePlugin):
         creator.deploy_dir = deploy_dir
 
         distro_arch = get_bitbake_var("DISTRO_ARCH")
-        bootloader = "/usr/lib/{libpath}/efibootguard/efibootguard{efiarch}.efi".format(
-                        libpath=libarch,
-                        efiarch=efiarch)
+        bootloader = f'/usr/lib/{libarch}/efibootguard/efibootguard{efiarch}.efi'
         part_rootfs_dir = "%s/disk/%s.%s" % (cr_workdir,
                                              part.label,
                                              part.lineno)
         create_dir_cmd = "install -d %s/EFI/BOOT" % part_rootfs_dir
         exec_cmd(create_dir_cmd)
 
-        name = "boot{}.efi".format(efiarch)
+        name = f'boot{efiarch}.efi'
 
         signed_bootloader = cls._sign_file(name,
                                            bootloader,
@@ -116,11 +114,7 @@ class EfibootguardEFIPlugin(SourcePlugin):
         sign_script = source_params.get("signwith")
         if sign_script and os.path.exists(sign_script):
             work_name = name.replace(".efi", ".signed.efi")
-            sign_cmd = "{sign_script} {signee} \
-            {cr_workdir}/{work_name}".format(sign_script=sign_script,
-                                             signee=signee,
-                                             cr_workdir=cr_workdir,
-                                             work_name=work_name)
+            sign_cmd = f'{sign_script} {signee} {cr_workdir}/{work_name}'
             exec_cmd(sign_cmd)
         elif sign_script and not os.path.exists(sign_script):
             msger.error("Could not find script %s", sign_script)
@@ -128,9 +122,6 @@ class EfibootguardEFIPlugin(SourcePlugin):
         else:
             # if we do nothing copy the signee to the work directory
             work_name = name
-            cp_cmd = "cp {signee} {cr_workdir}/{work_name}".format(
-                signee=signee,
-                cr_workdir=cr_workdir,
-                work_name=work_name)
+            cp_cmd = f'cp {signee} {cr_workdir}/{work_name}'
             exec_cmd(cp_cmd)
         return work_name
-- 
2.39.2


