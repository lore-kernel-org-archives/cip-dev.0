Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1259C636CC
	for <webhook@archiver.kernel.org>; Tue, 14 Feb 2023 02:36:21 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.10351.1676278678311127073
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Feb 2023 00:57:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=P9AKzIur;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-72506-20230213085756031f953d393185a2cb-yysr89@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230213085756031f953d393185a2cb
        for <cip-dev@lists.cip-project.org>;
        Mon, 13 Feb 2023 09:57:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=OA4BkfKnthy0ts9YN0+J1KiCSQhII3v/6ma+ZAAgdS0=;
 b=P9AKzIurqedRAGFnZmAPCkDu7pZqR4kgT8aY2CJS5jr8sn7oguq9cgvjQcFWghxK4by6fJ
 0STT+I6mbajqvSw0NqzF/1LRjcnYiPzcRUQn3YWhl1AXmH+/7EFpDLg5gkUIUlIUNE8DD8zf
 FMzin0yvvD8o16mCdxZLVFmnB5cPM=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: daniel.bovensiepen@siemens.com,
	jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 2/3] fix efibootguard for riscv64
Date: Mon, 13 Feb 2023 08:57:40 +0000
Message-Id: <20230213085741.1242658-2-felix.moessbauer@siemens.com>
In-Reply-To: <20230213085741.1242658-1-felix.moessbauer@siemens.com>
References: <20230213085741.1242658-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Feb 2023 02:36:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10693

This commit backports an upstream patch for efibootguard that
fixes the riscv64 install location. As it is not yet in an
EBG release, we add it as a patch here. No internal logic of EBG is
changed, hence no dedicated release is needed.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 recipes-bsp/efibootguard/efibootguard_0.13.bb |  3 ++
 ...01-add-machine-type-name-for-riscv64.patch | 39 +++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 recipes-bsp/efibootguard/files/0001-add-machine-type-name-for-riscv64.patch

diff --git a/recipes-bsp/efibootguard/efibootguard_0.13.bb b/recipes-bsp/efibootguard/efibootguard_0.13.bb
index 3279854..d6101df 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.13.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.13.bb
@@ -21,6 +21,9 @@ SRC_URI = " \
     file://debian \
     "
 SRC_URI[sha256sum] = "639a6d8f687cb099b2e9b01eb08ad1494267fe26b5d903b4d405d0737feb989b"
+# add riscv64 support
+SRC_URI += "file://0001-add-machine-type-name-for-riscv64.patch"
+CHANGELOG_V = "<orig-version>+cip"
 
 PROVIDES = "${PN}"
 PROVIDES += "${PN}-dev"
diff --git a/recipes-bsp/efibootguard/files/0001-add-machine-type-name-for-riscv64.patch b/recipes-bsp/efibootguard/files/0001-add-machine-type-name-for-riscv64.patch
new file mode 100644
index 0000000..adc7962
--- /dev/null
+++ b/recipes-bsp/efibootguard/files/0001-add-machine-type-name-for-riscv64.patch
@@ -0,0 +1,39 @@
+From 391dd5e04b17be6f5184afb2de4853795f1d5620 Mon Sep 17 00:00:00 2001
+From: Felix Moessbauer <felix.moessbauer@siemens.com>
+Date: Tue, 31 Jan 2023 09:27:31 +0100
+Subject: [PATCH 1/1] add machine type name for riscv64
+
+By adding the machine type name, the generated efi binary for
+riscv64 is suffixed with the corresponding efi machine name.
+
+Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ configure.ac | 4 ++++
+ 1 file changed, 4 insertions(+)
+
+diff --git a/configure.ac b/configure.ac
+index d8f9d3a..90d70b0 100644
+--- a/configure.ac
++++ b/configure.ac
+@@ -87,6 +87,7 @@ SET_ARCH(X86_64, x86_64*)
+ SET_ARCH(IA64, ia64*)
+ SET_ARCH(AARCH64, aarch64*)
+ SET_ARCH(ARM, arm*)
++SET_ARCH(RISCV64, riscv64*)
+ 
+ ARCH=$(echo $host | sed "s/\(-\).*$//")
+ 
+@@ -103,6 +104,9 @@ AM_COND_IF(ARCH_AARCH64, [
+ AM_COND_IF(ARCH_ARM, [
+ 	   MACHINE_TYPE_NAME=arm])
+ 
++AM_COND_IF(ARCH_RISCV64, [
++	   MACHINE_TYPE_NAME=riscv64])
++
+ AC_SUBST([ARCH])
+ AC_SUBST([MACHINE_TYPE_NAME])
+ AM_CONDITIONAL([ARCH_IS_X86], [test "$ARCH" = "ia32" -o "$ARCH" = "x86_64"])
+-- 
+2.30.2
+
-- 
2.34.1


