Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D319C3ABA3
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 11:42:09 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.46072.1745840524905758872
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Apr 2025 04:42:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=C0R7NywQ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-20250428114202eff78e24f8145f2e45-9swxw2@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250428114202eff78e24f8145f2e45
        for <cip-dev@lists.cip-project.org>;
        Mon, 28 Apr 2025 13:42:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=pBALwn4vew7fCjKftrR3T6mL+qvYvWvgwmlrMlTLWic=;
 b=C0R7NywQwNWHzC60xam4/3FUmUMAt5BEmRuTRxbEB/pzdxy2+ukhiSYZ/svyEbiZYy6jCF
 4sKCh4pRFyFLJbGrti2Vv2xMWx8QVQyMGNjnN0spqgkrYYycayVasC2cUgy2jC/4js1FJSS3
 uai7RXEhw29oR+lr/0cYnoxaM5AnsO2VhoNnIB1Lkt4Bsn6+cmmL7D3OPVRL2HlI8nLFwEMX
 PGdLhdalYqJvi6woagulSu04Nk7/VPU4fJGsxURYdfa5dbsxTR8z+S3QZG13whZMnUraRMEg
 Jpe1XPx/iAOE/DKogL2xfLFqjfhWVYog6k3eIiGrZ3NIibW6SRjI2WOg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] wic: Allow to set the binary name of the unfied-kernel-image
Date: Mon, 28 Apr 2025 13:41:39 +0200
Message-ID: <20250428114201.3210740-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 11:42:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18698

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows in case of a unified kernel(UKI) image based installer
to differ between the installer UKI and the target UKI.

It also allows the build of multiple images for the same target
architecture or update file.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/lib/wic/plugins/source/efibootguard-boot.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index 8b1097f..310d2cb 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -178,7 +178,7 @@ class EfibootguardBootPlugin(SourcePlugin):
             .format(rootfs_path=rootfs_path,
                     libpath=libarch,
                     efiarch=efiarch)
-        uefi_kernel_name = "linux.efi"
+        uefi_kernel_name = get_bitbake_var('UNIFIED_KERNEL_IMAGE_NAME') or 'linux.efi'
         uefi_kernel_file = "{deploy_dir}/{uefi_kernel_name}"\
             .format(deploy_dir=deploy_dir, uefi_kernel_name=uefi_kernel_name)
         kernel = "{deploy_dir}/{kernel_image}"\
-- 
2.47.0


