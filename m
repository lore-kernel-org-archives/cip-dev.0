Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4591CCA47B
	for <webhook@archiver.kernel.org>; Mon, 11 Jul 2022 19:41:04 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web12.184.1657568462866071667
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Jul 2022 12:41:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=OHUaNdtW;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226,
 mailfrom: fm-294854-202207111941000f06b00d5c9191c6b6-4omhgn@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 202207111941000f06b00d5c9191c6b6
        for <cip-dev@lists.cip-project.org>;
        Mon, 11 Jul 2022 21:41:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=+0qdV1irPjEJgpg18P2NJykefnMTsMaA4R7E193Z0fE=;
 b=OHUaNdtWN7fJ19Z+WDtUG1TUDfmWZGZ7aqUlNQa4hHGDUZD6ulXpPUU8N+Poeo+NpI100Y
 AxO9ip2sW6eRI6Nnlq5y8hI4fb/UCGk5t6zDJBKYdir5i9oR3TYK/KcZ+wKKoR/0lLD1TFf2
 WAIif2ks+6w4TOFpgVbesXH42JHfU=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Christian Storm <christian.storm@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 3/7] efibootguard: Update to release 0.12
Date: Mon, 11 Jul 2022 21:40:54 +0200
Message-Id: 
 <4e7ea3e468760b19ab3a48faf8acae1a0849a41c.1657568458.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1657568458.git.jan.kiszka@siemens.com>
References: <cover.1657568458.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Jul 2022 19:41:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8744

From: Jan Kiszka <jan.kiszka@siemens.com>

Allows to drop our patch. And it's the precondition to add ARM support.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...bootguard_0.11.bb => efibootguard_0.12.bb} |  5 ++--
 ...efile-Drop-nostdinc-for-EFI-binaries.patch | 28 -------------------
 2 files changed, 2 insertions(+), 31 deletions(-)
 rename recipes-bsp/efibootguard/{efibootguard_0.11.bb => efibootguard_0.12.bb} (85%)
 delete mode 100644 recipes-bsp/efibootguard/files/0001-Makefile-Drop-nostdinc-for-EFI-binaries.patch

diff --git a/recipes-bsp/efibootguard/efibootguard_0.11.bb b/recipes-bsp/efibootguard/efibootguard_0.12.bb
similarity index 85%
rename from recipes-bsp/efibootguard/efibootguard_0.11.bb
rename to recipes-bsp/efibootguard/efibootguard_0.12.bb
index ef6cd9c..88dc2ed 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.11.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.12.bb
@@ -19,15 +19,14 @@ MAINTAINER = "Jan Kiszka <jan.kiszka@siemens.com>"
 SRC_URI = " \
     https://github.com/siemens/efibootguard/archive/refs/tags/v${PV}.tar.gz;downloadfilename=efitbootguard-v${PV}.tar.gz \
     file://debian \
-    file://0001-Makefile-Drop-nostdinc-for-EFI-binaries.patch \
     "
-SRC_URI[sha256sum] = "12bd84ff63a34bef56e489b48d4f97955aa4d864eeff9ea2dea1d24a286d8ebe"
+SRC_URI[sha256sum] = "fd670f7a60a605c68ed411a9ab83ac680fbc9a9b5a8fd7b417c049f6cba5b6dc"
 
 PROVIDES = "${PN}"
 PROVIDES += "${PN}-dev"
 
 DEPENDS = "python3-shtab"
-BUILD_DEB_DEPENDS = "dh-exec,gnu-efi,libpci-dev,check,pkg-config,python3-shtab"
+BUILD_DEB_DEPENDS = "dh-exec,autoconf-archive,gnu-efi,libpci-dev,check,pkg-config,python3-shtab"
 BUILD_DEB_DEPENDS_append_amd64 = ",libc6-dev-i386"
 BUILD_DEB_DEPENDS_append_i386 = ",libc6-dev-i386"
 
diff --git a/recipes-bsp/efibootguard/files/0001-Makefile-Drop-nostdinc-for-EFI-binaries.patch b/recipes-bsp/efibootguard/files/0001-Makefile-Drop-nostdinc-for-EFI-binaries.patch
deleted file mode 100644
index 8cc1654..0000000
--- a/recipes-bsp/efibootguard/files/0001-Makefile-Drop-nostdinc-for-EFI-binaries.patch
+++ /dev/null
@@ -1,28 +0,0 @@
-From daf4cb61bec56dac628be83b95a7072c184eabcd Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Wed, 4 May 2022 11:52:53 +0200
-Subject: [PATCH] Makefile: Drop -nostdinc for EFI binaries
-
-Not needed, also systemd-boot does not use it, and it actually triggers
-a build failure on Debian 10, possibly on other distros as well.
-
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
----
- Makefile.am | 1 -
- 1 file changed, 1 deletion(-)
-
-diff --git a/Makefile.am b/Makefile.am
-index f0daa15..7398b85 100644
---- a/Makefile.am
-+++ b/Makefile.am
-@@ -191,7 +191,6 @@ efi_cflags = \
- 	-Wall \
- 	-Wextra \
- 	-std=gnu99 \
--	-nostdinc \
- 	-ggdb -O0 \
- 	-fpic \
- 	-fshort-wchar \
--- 
-2.34.1
-
-- 
2.35.3


