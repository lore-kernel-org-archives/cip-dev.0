Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042ACC41535
	for <webhook@archiver.kernel.org>; Thu,  5 May 2022 16:43:39 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.13631.1651769016660078234
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 May 2022 09:43:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=SNHHWeXV;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227,
 mailfrom: fm-294854-20220505164333fde87e1c517949beec-gc6eky@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 20220505164333fde87e1c517949beec
        for <cip-dev@lists.cip-project.org>;
        Thu, 05 May 2022 18:43:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=GMYuwS6GwjNy1ZPgnPQaz/t4z5Q9duHYsZMC4y68xFk=;
 b=SNHHWeXVf8vdNRXNdWqw4vcGjPDQdI4uEyjy491w07X0aVNdgakzZ7KfJaCLBFZtL6aVYd
 qcCBlU6zgVxk8MnJGfH6iVGWJliz3ZGO6gpnhE0fOqMiTuAqMRBDqiUaP/X0mn5DmcKFS6aG
 DQdd02v+wjawmHd43vLW41hAy2BHc=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH v2 08/13] efibootguard: Fix empty command line
 case
Date: Thu,  5 May 2022 18:43:24 +0200
Message-Id: 
 <9e8df37239f072c7cc8e832cb0beccc8025a1f2d.1651769009.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1651769009.git.jan.kiszka@siemens.com>
References: <cover.1651769009.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 May 2022 16:43:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8267

From: Jan Kiszka <jan.kiszka@siemens.com>

We crash in case of an empty command line with non-unified kernel images
right now. Just avoid cmdline==None, will also make upcoming changes
simpler.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/lib/wic/plugins/source/efibootguard-boot.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index 909e629..9267033 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -80,7 +80,7 @@ class EfibootguardBootPlugin(SourcePlugin):
 
         boot_files = source_params.get("files", "").split(' ')
         unified_kernel = source_params.get("unified-kernel") or 'y'
-        cmdline = bootloader.append
+        cmdline = bootloader.append or ''
         if unified_kernel == 'y':
             boot_image = cls._create_unified_kernel_image(rootfs_dir,
                                                           cr_workdir,
@@ -113,7 +113,7 @@ class EfibootguardBootPlugin(SourcePlugin):
             % (
                 part.label.upper(),
                 boot_image,
-                '-a "%s"' % cmdline if cmdline else "",
+                '-a "%s"' % cmdline,
                 source_params.get("revision", 1),
                 wdog_timeout
             )
-- 
2.34.1


