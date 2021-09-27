Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51326C433EF
	for <webhook@archiver.kernel.org>; Mon, 27 Sep 2021 08:38:09 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web08.28725.1632731887858109491
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Sep 2021 01:38:08 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 18R8c4sU027203
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 27 Sep 2021 10:38:05 +0200
Received: from md2dvrtc.fritz.box ([139.22.35.204])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 18R8c4M5028652;
	Mon, 27 Sep 2021 10:38:04 +0200
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH] scripts/wic/efibootguard-boot: Add
 missing whitespace
Date: Mon, 27 Sep 2021 10:38:03 +0200
Message-Id: <20210927083803.15507-1-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Sep 2021 08:38:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6750

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The generated Kernel commandline was incorrect concatenated.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/lib/wic/plugins/source/efibootguard-boot.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index b85cfca..882729a 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -99,7 +99,7 @@ class EfibootguardBootPlugin(SourcePlugin):
                 exit(1)
             root_dev = root_dev.replace(":", "=")
 
-            cmdline += " root=%s rw" % root_dev
+            cmdline += " root=%s rw " % root_dev
             boot_files.append(kernel_image)
             boot_files.append(initrd_image)
             cmdline += "initrd=%s" % initrd_image if initrd_image else ""
-- 
2.30.2


