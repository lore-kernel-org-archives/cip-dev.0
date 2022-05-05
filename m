Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BBDC4167D
	for <webhook@archiver.kernel.org>; Thu,  5 May 2022 16:43:38 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web09.13557.1651769015364938526
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 May 2022 09:43:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=T7BofaHw;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225,
 mailfrom: fm-294854-2022050516433373af63d24ec45f1f2f-s9br2h@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 2022050516433373af63d24ec45f1f2f
        for <cip-dev@lists.cip-project.org>;
        Thu, 05 May 2022 18:43:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=UcJxcVMrwFxw2A4GGhDOOvLkCcllYdRh/T10ps9vJrs=;
 b=T7BofaHwxKELgeoWwqZbv4qQb4IytN0PXJAWsSP4xAQN9jIxUwMH72DpgPtnOSHn6vxS1z
 5RtWI7tTYnuUOzJ6rOco2PLPq+/466fsdGI+zNBfAHaUBRSEZv1yOMfsSnMIxV784QpZx7XQ
 N+FPKGZiwAsE3U59XyobAmxanwvro=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH v2 07/13] efibootguard: Update to 0.11 release
Date: Thu,  5 May 2022 18:43:23 +0200
Message-Id: 
 <eb55d9d50c4e562a2c8704b7881539f2d5d7794c.1651769009.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1651769009.git.jan.kiszka@siemens.com>
References: <cover.1651769009.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 May 2022 16:43:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8261

From: Jan Kiszka <jan.kiszka@siemens.com>

This version bring the new unified kernel stub and script to generate
unified kernel images from that.

That script requires python3, so we need to expand the package
dependencies. As we package all tools into a single deb, and the target
usually requires bg_{print,set}env, python3 is now also pulled onto the
target. If that should be avoided, we will have to split packaging in
future.

One extra patch is needed that missed the release. It fixes building
under buster for arm64.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...bootguard_0.10.bb => efibootguard_0.11.bb} |  4 +--
 ...efile-Drop-nostdinc-for-EFI-binaries.patch | 28 +++++++++++++++++++
 .../0001-configure-Fix-aarch64-EFI-arch.patch | 28 -------------------
 .../efibootguard/files/debian/control.tmpl    |  2 +-
 .../files/debian/efibootguard.install         |  3 +-
 5 files changed, 33 insertions(+), 32 deletions(-)
 rename recipes-bsp/efibootguard/{efibootguard_0.10.bb => efibootguard_0.11.bb} (90%)
 create mode 100644 recipes-bsp/efibootguard/files/0001-Makefile-Drop-nostdinc-for-EFI-binaries.patch
 delete mode 100644 recipes-bsp/efibootguard/files/0001-configure-Fix-aarch64-EFI-arch.patch

diff --git a/recipes-bsp/efibootguard/efibootguard_0.10.bb b/recipes-bsp/efibootguard/efibootguard_0.11.bb
similarity index 90%
rename from recipes-bsp/efibootguard/efibootguard_0.10.bb
rename to recipes-bsp/efibootguard/efibootguard_0.11.bb
index bfc0ede..ef6cd9c 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.10.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.11.bb
@@ -19,9 +19,9 @@ MAINTAINER = "Jan Kiszka <jan.kiszka@siemens.com>"
 SRC_URI = " \
     https://github.com/siemens/efibootguard/archive/refs/tags/v${PV}.tar.gz;downloadfilename=efitbootguard-v${PV}.tar.gz \
     file://debian \
-    file://0001-configure-Fix-aarch64-EFI-arch.patch \
+    file://0001-Makefile-Drop-nostdinc-for-EFI-binaries.patch \
     "
-SRC_URI[sha256sum] = "4d58574a0bb8f1e56056ab0bcc2487d37e49fa147dc991e719c2ec8e20f88dd3"
+SRC_URI[sha256sum] = "12bd84ff63a34bef56e489b48d4f97955aa4d864eeff9ea2dea1d24a286d8ebe"
 
 PROVIDES = "${PN}"
 PROVIDES += "${PN}-dev"
diff --git a/recipes-bsp/efibootguard/files/0001-Makefile-Drop-nostdinc-for-EFI-binaries.patch b/recipes-bsp/efibootguard/files/0001-Makefile-Drop-nostdinc-for-EFI-binaries.patch
new file mode 100644
index 0000000..8cc1654
--- /dev/null
+++ b/recipes-bsp/efibootguard/files/0001-Makefile-Drop-nostdinc-for-EFI-binaries.patch
@@ -0,0 +1,28 @@
+From daf4cb61bec56dac628be83b95a7072c184eabcd Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Wed, 4 May 2022 11:52:53 +0200
+Subject: [PATCH] Makefile: Drop -nostdinc for EFI binaries
+
+Not needed, also systemd-boot does not use it, and it actually triggers
+a build failure on Debian 10, possibly on other distros as well.
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ Makefile.am | 1 -
+ 1 file changed, 1 deletion(-)
+
+diff --git a/Makefile.am b/Makefile.am
+index f0daa15..7398b85 100644
+--- a/Makefile.am
++++ b/Makefile.am
+@@ -191,7 +191,6 @@ efi_cflags = \
+ 	-Wall \
+ 	-Wextra \
+ 	-std=gnu99 \
+-	-nostdinc \
+ 	-ggdb -O0 \
+ 	-fpic \
+ 	-fshort-wchar \
+-- 
+2.34.1
+
diff --git a/recipes-bsp/efibootguard/files/0001-configure-Fix-aarch64-EFI-arch.patch b/recipes-bsp/efibootguard/files/0001-configure-Fix-aarch64-EFI-arch.patch
deleted file mode 100644
index ee05e94..0000000
--- a/recipes-bsp/efibootguard/files/0001-configure-Fix-aarch64-EFI-arch.patch
+++ /dev/null
@@ -1,28 +0,0 @@
-From 3f11612fbcbd1c17988d634ecdaecf1ec241f6e0 Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Mon, 21 Mar 2022 07:02:28 +0100
-Subject: [PATCH] configure: Fix aarch64 EFI arch
-
-It's aa64 here according to the UEFI spec.
-
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
----
- configure.ac | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/configure.ac b/configure.ac
-index a1a83e9..09d06d7 100644
---- a/configure.ac
-+++ b/configure.ac
-@@ -102,7 +102,7 @@ AM_COND_IF(ARCH_X86_64, [
- 	   MACHINE_TYPE_NAME=x64])
- 
- AM_COND_IF(ARCH_AARCH64, [
--	   MACHINE_TYPE_NAME=aarch64])
-+	   MACHINE_TYPE_NAME=aa64])
- 
- AC_SUBST([ARCH])
- AC_SUBST([MACHINE_TYPE_NAME])
--- 
-2.34.1
-
diff --git a/recipes-bsp/efibootguard/files/debian/control.tmpl b/recipes-bsp/efibootguard/files/debian/control.tmpl
index 54b1994..f8bdd8a 100644
--- a/recipes-bsp/efibootguard/files/debian/control.tmpl
+++ b/recipes-bsp/efibootguard/files/debian/control.tmpl
@@ -7,7 +7,7 @@ Homepage: ${HOMEPAGE}
 Maintainer: ${MAINTAINER}
 
 Package: ${PN}
-Depends: ${shlibs:Depends}
+Depends: ${shlibs:Depends}, python3
 Section: base
 Architecture: ${DISTRO_ARCH}
 Priority: required
diff --git a/recipes-bsp/efibootguard/files/debian/efibootguard.install b/recipes-bsp/efibootguard/files/debian/efibootguard.install
index 910e153..d3ea007 100755
--- a/recipes-bsp/efibootguard/files/debian/efibootguard.install
+++ b/recipes-bsp/efibootguard/files/debian/efibootguard.install
@@ -1,6 +1,7 @@
 #!/usr/bin/dh-exec
 bg_setenv usr/bin
 bg_printenv usr/bin
-efibootguard*.efi usr/share/efibootguard
+tools/bg_gen_unified_kernel usr/bin
+*.efi usr/share/efibootguard
 completion/bash/bg_printenv.bash => usr/share/bash-completion/completions/bg_printenv
 completion/bash/bg_setenv.bash => usr/share/bash-completion/completions/bg_setenv
-- 
2.34.1


