Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B964C47258
	for <webhook@archiver.kernel.org>; Tue, 23 Jan 2024 21:14:14 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.6372.1706044451608212165
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Jan 2024 13:14:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=BGPM5bwy;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-2024012321140827791fc7db33e0c156-esu5fo@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2024012321140827791fc7db33e0c156
        for <cip-dev@lists.cip-project.org>;
        Tue, 23 Jan 2024 22:14:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=c+oTOej2/tVYsv9mNH+pDHaAvkCbf1W9Mgwn4JAGsQg=;
 b=BGPM5bwyTfv9BEkG+DY8MF1KFbfNPuAAhsGPy9IcGR0hZiEaf1gXMxGiePTk4qKx1a0R19
 gznFQtSOlriyPXPFsMdvnOxAiNAKtNMLn5Rl3bQHJdIbEsGV4nkuEiK4+XRutyduHgXJQXrN
 /c+D878SQPlV1p8UUZZG62hnhnLek=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3] efibootguard: Update to 0.16-2
Date: Tue, 23 Jan 2024 22:12:27 +0100
Message-ID: <20240123211406.2154661-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Jan 2024 21:14:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14451

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This is the official tag version from debian which removes the
native flag from the python3-shtab dependency.

Also remove the patch debian-patches/0002-d-control-remove-native-from-python3-shtab.patch

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ...16-1+cip.bb => efibootguard_0.16-2+cip.bb} |  2 +-
 ...rol-remove-native-from-python3-shtab.patch | 28 -------------------
 2 files changed, 1 insertion(+), 29 deletions(-)
 rename recipes-bsp/efibootguard/{efibootguard_0.16-1+cip.bb => efibootguard_0.16-2+cip.bb} (96%)
 delete mode 100644 recipes-bsp/efibootguard/files/debian-patches/0002-d-control-remove-native-from-python3-shtab.patch

diff --git a/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb b/recipes-bsp/efibootguard/efibootguard_0.16-2+cip.bb
similarity index 96%
rename from recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
rename to recipes-bsp/efibootguard/efibootguard_0.16-2+cip.bb
index 93114c3..b6bb2bd 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.16-2+cip.bb
@@ -24,7 +24,7 @@ SRC_URI = " \
     file://debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch \
     "
 SRC_URI[tarball.sha256sum] = "d6d37c59aed17489d02b4f0b63db16994dfb8f9f70f54be4d65c366f58c6be9d"
-SRCREV_debian = "eacf94e767136a0257850ea0c888d234cb8cace4"
+SRCREV_debian = "74b34b5a3bbdedb628bd75422d6a8bfef70ab58a"
 
 PROVIDES = "libebgenv-dev libebgenv0 efibootguard"
 
diff --git a/recipes-bsp/efibootguard/files/debian-patches/0002-d-control-remove-native-from-python3-shtab.patch b/recipes-bsp/efibootguard/files/debian-patches/0002-d-control-remove-native-from-python3-shtab.patch
deleted file mode 100644
index 42204a5..0000000
--- a/recipes-bsp/efibootguard/files/debian-patches/0002-d-control-remove-native-from-python3-shtab.patch
+++ /dev/null
@@ -1,28 +0,0 @@
-From c599480bdec0ed57922d100dceb5c94d04755694 Mon Sep 17 00:00:00 2001
-From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
-Date: Wed, 15 Feb 2023 10:47:38 +0100
-Subject: [PATCH 2/2] d/control: remove :native from python3-shtab
-
-This fixes the cross build for qemu-arm and qemu-arm64.
-
-Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
----
- debian/control | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/debian/control b/debian/control
-index 8b92019..53e2b66 100644
---- a/debian/control
-+++ b/debian/control
-@@ -9,7 +9,7 @@ Build-Depends: debhelper,
-  help2man,
-  libpci-dev,
-  pkg-config,
-- python3-shtab:native,
-+ python3-shtab,
-  zlib1g-dev
- Standards-Version: 4.6.1
- Homepage: https://github.com/siemens/efibootguard
--- 
-2.39.2
-
-- 
2.43.0


