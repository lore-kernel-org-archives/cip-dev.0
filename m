Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BB5C36002
	for <webhook@archiver.kernel.org>; Mon, 24 Mar 2025 13:00:22 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.38742.1742821213305931835
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Mar 2025 06:00:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm2 header.b=W8mPhvLv;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1321639-20250324130010b509f2ed703f83451b-1s1kej@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250324130010b509f2ed703f83451b
        for <cip-dev@lists.cip-project.org>;
        Mon, 24 Mar 2025 14:00:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=rpA6ueUKXZKYCobyLj6aXKfGiQCkuqiCJ85XqKDR/cA=;
 b=W8mPhvLvoycw9oERv+3Fbf/fZlbBxHk8wIisJEUPcXprKPmBw+BI/dT4L5P7jMpTYxx7yC
 KffM4qp0AvdJahU/n02qe3FP13FILdniAN1ZdNVRYGN9EGsp7MX74XxBviQ4o8VfUH+JArwv
 5bgoU0jdA6qc/TNagjBAPXy3lPjjyqrQFKkdAl3krkFYZEpwrDW7Yf/omWUCgLrkjmr9sBfO
 B3f2eMqSOntp7eCqm/AXzk4yB/xG6n8qOHcpK89xktwg4juEyCar5xhKKEYted4aXn9bbaHp
 tD8rP68gMq65+Lk6bs+MrZ0WGUSTHS1+++wvrlDIWoQXrjJgIJTbTlHA==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Felix Moessbauer <felix.moessbauer@siemens.com>,
	cedric.hombourger@siemens.com,
	quirin.gylstorff@siemens.com
Subject: [isar-cip-core][PATCH 1/1] ebg-efi: add support to deploy additional files on boot partition
Date: Mon, 24 Mar 2025 13:59:42 +0100
Message-ID: <20250324125942.3548370-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Mar 2025 13:00:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18347

Some embedded systems (like the RPi 4b) cannot directly boot EFI.
Instead, they use a staged approach where a first stage loader then
loads the EFI provider, which then boots the efi target. For that, both
the first-stage loader, as well as additional config files need to be
added to the initial boot partition.

The bootimg-efi-isar already supports this for both grub and
systemd-boot by adding files to the IMAGE_EFI_BOOT_FILES bitbake
variable. We now add the same support to the EBG wic plugin, by copying
the code 1:1 to efibootguard-efi.py.

Note, that by design these files are only copied to the ebg boot
partition, but not to the A/B kernel partitions. While we are not yet
EFI bootet, only a single partition is scanned by the firmware loader.
Once we bootet EFI, there is no need for the additional files anymore.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
Hi, this only adds the infrastructure, but unfortunately we don't have
any in-tree user yet. I'm hesitant to add one, as these targets are not
official CIP targets. The code has been tested locally and is
really just a 1:1 copy. If you have ideas how to test it in CIP, please
let me know.

Best regards,
Felix Moessbauer
Siemens AG

 .../wic/plugins/source/efibootguard-efi.py    | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
index 48f7523..cce948e 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
@@ -29,9 +29,12 @@
 
 import logging
 import os
+import re
+from glob import glob
 
 msger = logging.getLogger('wic')
 
+from wic import WicError
 from wic.pluginbase import SourcePlugin
 from wic.misc import exec_cmd, get_bitbake_var, BOOTDD_EXTRA_SPACE
 
@@ -42,6 +45,51 @@ class EfibootguardEFIPlugin(SourcePlugin):
 
     name = 'efibootguard-efi'
 
+    @classmethod
+    def _deploy_additional_boot_files(cls, boot_files, kernel_dir, part_rootfs_dir):
+        # based on bootimg-efi-isar.py to get consistent behavior
+        # list of tuples (src_name, dst_name)
+        deploy_files = []
+        for src_entry in re.findall(r'[\w;\-\./\*]+', boot_files):
+            if ';' in src_entry:
+                dst_entry = tuple(src_entry.split(';'))
+                if not dst_entry[0] or not dst_entry[1]:
+                    raise WicError('Malformed boot file entry: %s' % src_entry)
+            else:
+                dst_entry = (src_entry, src_entry)
+
+            msger.debug('Destination entry: %r', dst_entry)
+            deploy_files.append(dst_entry)
+
+            install_task = []
+            for deploy_entry in deploy_files:
+                src, dst = deploy_entry
+                if '*' in src:
+                    # by default install files under their basename
+                    entry_name_fn = os.path.basename
+                    if dst != src:
+                        # unless a target name was given, then treat name
+                        # as a directory and append a basename
+                        entry_name_fn = lambda name: \
+                                        os.path.join(dst,
+                                                     os.path.basename(name))
+
+                    srcs = glob(os.path.join(kernel_dir, src))
+
+                    msger.debug('Globbed sources: %s', ', '.join(srcs))
+                    for entry in srcs:
+                        src = os.path.relpath(entry, kernel_dir)
+                        entry_dst_name = entry_name_fn(entry)
+                        install_task.append((src, entry_dst_name))
+                else:
+                    install_task.append((src, dst))
+
+            for src_path, dst_path in install_task:
+                install_cmd = "install -m 0644 -D %s %s" \
+                              % (os.path.join(kernel_dir, src_path),
+                                 os.path.join(part_rootfs_dir, dst_path))
+                exec_cmd(install_cmd)
+
     @classmethod
     def do_prepare_partition(cls, part, source_params, creator, cr_workdir,
                              oe_builddir, deploy_dir, kernel_dir,
@@ -100,6 +148,10 @@ class EfibootguardEFIPlugin(SourcePlugin):
                                                name)
         exec_cmd(cp_to_deploy_cmd, True)
 
+        boot_files = get_bitbake_var("IMAGE_EFI_BOOT_FILES")
+        if boot_files:
+            cls._deploy_additional_boot_files(boot_files, kernel_dir, part_rootfs_dir)
+
         efi_part_image = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
         part.prepare_rootfs_msdos(efi_part_image, cr_workdir, oe_builddir,
                                   part_rootfs_dir, native_sysroot, None)
-- 
2.49.0


