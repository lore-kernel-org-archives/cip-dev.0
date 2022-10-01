X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web08.3148.1664599997241516709
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Sep 2022 21:53:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=Et6lX8sm;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-72506-20221001045314a77ce579b1b5a3fa6e-ywgrtu@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20221001045314a77ce579b1b5a3fa6e
        for <cip-dev@lists.cip-project.org>;
        Sat, 01 Oct 2022 06:53:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=inNbYHfVKh25R0qg2ZFi/UIAlEG4tTzUuQF2Vcm2JTc=;
 b=Et6lX8smKefdmAI6qmwuScyKzcJZYvpjJliTz0J67UrSIe8ILUeAbWlbdouxs6cFTjX9Zi
 AcOydAEnEr6laeebcgaHKDd/2F/WuPU8Xssqj82VuBRvjv1QyuwxX2a7PBwty8hdUoAYGPvR
 Nm7Z6qAOjXblRTG4viZjoNKkULkaY=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 1/1] use qualified path for CIP_IMAGE_OPTIONS
Date: Sat,  1 Oct 2022 06:52:57 +0200
Message-Id: <20221001045257.441816-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

When using the cip-core layer in another layer that has a slightly
different directory structure, bitbake is not able to resolve the
included files.

To fix this, we simply add the full path to the file so bitbake is able
to locate it independent of the downstream layer configuration.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 kas/opt/ebg-swu.yml  | 2 +-
 kas/opt/swupdate.yml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
index 8b3ffec..78227f1 100644
--- a/kas/opt/ebg-swu.yml
+++ b/kas/opt/ebg-swu.yml
@@ -20,7 +20,7 @@ local_conf_header:
     SWUPDATE_BOOTLOADER = "efibootguard"
     IMAGE_INSTALL_remove = "u-boot-script"
   ebg_swu_image_options: |
-    CIP_IMAGE_OPTIONS_append = " efibootguard.inc image-uuid.inc"
+    CIP_IMAGE_OPTIONS_append = " recipes-core/images/efibootguard.inc recipes-core/images/image-uuid.inc"
   initramfs: |
     INITRAMFS_INSTALL_append = " initramfs-abrootfs-hook"
   firmware-binaries: |
diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index 8ba03c9..e32ce20 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -16,7 +16,7 @@ header:
 
 local_conf_header:
   image-option-swupdate: |
-    CIP_IMAGE_OPTIONS_append = " swupdate.inc"
+    CIP_IMAGE_OPTIONS_append = " recipes-core/images/swupdate.inc"
 
   wic-swu: |
     IMAGE_CLASSES += "squashfs"
-- 
2.30.2


