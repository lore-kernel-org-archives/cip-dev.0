Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF20FC433EF
	for <webhook@archiver.kernel.org>; Tue, 24 May 2022 14:58:07 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web12.10491.1653404282056904515
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 May 2022 07:58:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1
 header.b=H6S1Gmvm;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226,
 mailfrom: fm-51332-2022052414575885d4a5d62672e61aa7-7ivols@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 2022052414575885d4a5d62672e61aa7
        for <cip-dev@lists.cip-project.org>;
        Tue, 24 May 2022 16:57:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=SwhShsZAOxV3WQ/IMiaUlEep3FmyJYN51ZEplPJcOjU=;
 b=H6S1GmvmaOQkDR4EGVSxYzPcGYvYlstQ3O+lZ+PrXfc60ihMIwFUAvOx2trDos7SBQUyfC
 Vos8TrvffD7D+DDvDFUjGAEeLUoaBIuRNNvchvcQcOMM7qyJPB807hM8ASDyIqwXhAVG7Vsl
 QvYqejgN/NfwpQX8JSe3xNpMUbCr0=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] efibootguard-efi: Use correct search
 path for the efibinary
Date: Tue, 24 May 2022 16:57:57 +0200
Message-Id: <20220524145757.1704927-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 May 2022 14:58:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8429

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes the build error:
```
ERROR: _exec_cmd: cp /usr/share/efibootguard/efibootguardx64.efi /tmp/tmp.1Y4utA1zC2/sentron-product-sentron-sentron.wic/tmp.wic.ampnawp6/bootx64.efi returned '1' instead of 0
output: cp: cannot stat '/usr/share/efibootguard/efibootguardx64.efi': No such file or directory
```

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/lib/wic/plugins/source/efibootguard-efi.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
index e1411cb..a01e484 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
@@ -59,8 +59,10 @@ class EfibootguardEFIPlugin(SourcePlugin):
         }
 
         distro_arch = get_bitbake_var("DISTRO_ARCH")
-        bootloader = "/usr/share/efibootguard/efibootguard{}.efi".format(
-            distro_to_efi_arch[distro_arch])
+        rootfs_path = rootfs_dir.get('ROOTFS_DIR')
+        bootloader = "{rootfs_path}/usr/share/efibootguard/efibootguard{efiarch}.efi".format(
+            rootfs_path=rootfs_path,
+            efiarch=distro_to_efi_arch[distro_arch])
         part_rootfs_dir = "%s/disk/%s.%s" % (cr_workdir,
                                              part.label,
                                              part.lineno)
-- 
2.35.1


