Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E83C41535
	for <webhook@archiver.kernel.org>; Wed,  4 May 2022 19:46:09 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web12.2025.1651693566883225914
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 May 2022 12:46:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=Ay8BB1kv;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228,
 mailfrom: fm-294854-20220504194604c66676ea623273c2e9-lyhcxb@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20220504194604c66676ea623273c2e9
        for <cip-dev@lists.cip-project.org>;
        Wed, 04 May 2022 21:46:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=UcJxcVMrwFxw2A4GGhDOOvLkCcllYdRh/T10ps9vJrs=;
 b=Ay8BB1kvylbK24SRJgJ+HjMKP8nSBNdQcPEBt3RLmbFv17iAyD3f1PyyjWNJHOGEn7881+
 x0cOfNBRpuYqPGY28wiAwG0VtsZtJhIkJXwA37F6xdwT/SNzpqeTM1y70pUQPh8RvDWKvgfR
 JWS2lgtWB/veTO5idZQX/6TRhovo0=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 07/12] efibootguard: Update to 0.11 release
Date: Wed,  4 May 2022 21:45:55 +0200
Message-Id: 
 <eb55d9d50c4e562a2c8704b7881539f2d5d7794c.1651693560.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1651693560.git.jan.kiszka@siemens.com>
References: <cover.1651693560.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 May 2022 19:46:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8247

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


