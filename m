Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FF3C433F5
	for <webhook@archiver.kernel.org>; Wed, 24 Nov 2021 15:17:48 +0000 (UTC)
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web08.48.1637767067531839510
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Nov 2021 07:17:48 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.28, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AOFHjaT022263
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 16:17:45 +0100
Received: from md2dvrtc.fritz.box ([139.22.38.174])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AOFHiVr005533;
	Wed, 24 Nov 2021 16:17:45 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 2/2] README: Add information about
 start-qemu-defaults with menu config
Date: Wed, 24 Nov 2021 16:17:44 +0100
Message-Id: <20211124151744.949054-3-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124151744.949054-1-Quirin.Gylstorff@siemens.com>
References: <20211124151744.949054-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 15:17:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7004

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 README.md                | 6 ++++--
 doc/README.secureboot.md | 7 +++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/README.md b/README.md
index 53ef679..bd707a4 100644
--- a/README.md
+++ b/README.md
@@ -38,8 +38,10 @@ Run, e.g.,
 
     ./start-qemu.sh x86
 
-when having built a QEMU AMD64 image. A security image for QEMU can be started
-like this:
+when having built a QEMU AMD64 image. Using the image configuration menu will
+initialize variables used by start-qemu.sh with fitting defaults.
+
+A security image for QEMU can be started like this:
 
     TARGET_IMAGE=cip-core-image-security ./start-qemu.sh x86
 
diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index b5056f2..3c2d524 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -181,6 +181,13 @@ SECURE_BOOT=y \
 ./start-qemu.sh amd64
 ```
 
+The image configuration menu will set default values for start-qemu.sh for secureboot
+and the following command is sufficient:
+
+```
+./start-qemu.sh amd64
+```
+
 The default `OVMF_VARS.snakeoil_4M.fd` boot to the EFI shell. To boot Linux enter the following command:
 ```
 FS0:\EFI\BOOT\bootx64.efi
-- 
2.30.2


