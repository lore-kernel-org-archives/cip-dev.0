Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AB2D43344
	for <webhook@archiver.kernel.org>; Thu,  7 Nov 2024 10:58:14 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.69033.1730977083816661210
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Nov 2024 02:58:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=DxabcE5r;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-2024110710580091f4ffe1e87a2cf34a-bwftcw@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2024110710580091f4ffe1e87a2cf34a
        for <cip-dev@lists.cip-project.org>;
        Thu, 07 Nov 2024 11:58:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=3mj10dz889tlSKJb66BWEHwBYR6Uhe65ywoAoyieqvY=;
 b=DxabcE5rvRpzbBUxp85eG2Zl3CYDb0RuI9U9KaEY2uaAm0TdxRGFr6dBviRkMQGRTpeObk
 y2nmW3t0xcHv+EVzvylleMqqUaObf9HZvc6umbhlLVs5ueYtSjbkBDhziqrQyeh3TTEIrbx8
 UWlyXMT9RH96S/IYjM1LL/nPGH5V2bicxLgXE1qIMHDEC7AekWrcr4u5ysdtH7Vkq7oAQDrN
 K7UOD5s36kaf2cj4fGqre+DX3L6sryG2MfUmzkbKdz5POzrWGmt8t5Cbu2Y7MmTZfuNLSSlZ
 /x4EJduDQ0j2O9Nw4tBdlepPn1d2uroeRxqVK1sT/rXWQwXNAsnPB2ZQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Cedric Hombourger <cedric.hombourger@siemens.com>,
	Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
Subject: [isar-cip-core][PATCH 1/9] Provide recipe to rebuild gnu-efi 3.0.18 for fixing armhf bug
Date: Thu,  7 Nov 2024 11:57:49 +0100
Message-ID: <49baabb6f460de97658e4d51c9d7006134f2581f.1730977077.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1730977077.git.jan.kiszka@siemens.com>
References: <cover.1730977077.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Nov 2024 10:58:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17207

From: Jan Kiszka <jan.kiszka@siemens.com>

This allows to rebuild gnu-efi from testing/unstable in order to address
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1086705. With this
version, the kernel stub of EFI Boot Guard is built correctly again, and
the system boots.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../efibootguard/efibootguard_0.18-1+cip.bb   |  4 +
 .../0001-ARM32-Split-headers-and-code.patch   | 93 +++++++++++++++++++
 recipes-devtools/gnu-efi/gnu-efi_latest.bb    | 25 +++++
 3 files changed, 122 insertions(+)
 create mode 100644 recipes-devtools/gnu-efi/files/0001-ARM32-Split-headers-and-code.patch
 create mode 100644 recipes-devtools/gnu-efi/gnu-efi_latest.bb

diff --git a/recipes-bsp/efibootguard/efibootguard_0.18-1+cip.bb b/recipes-bsp/efibootguard/efibootguard_0.18-1+cip.bb
index 931bc8ea..63373119 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.18-1+cip.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.18-1+cip.bb
@@ -35,6 +35,10 @@ PATCHTOOL = "git"
 inherit dpkg
 
 DEPENDS = "python-shtab"
+
+DEPENDS:trixie = "gnu-efi"
+DEPENDS:sid    = "gnu-efi"
+
 # needed for buster, bullseye could use compat >= 13
 python() {
     arch = d.getVar('DISTRO_ARCH')
diff --git a/recipes-devtools/gnu-efi/files/0001-ARM32-Split-headers-and-code.patch b/recipes-devtools/gnu-efi/files/0001-ARM32-Split-headers-and-code.patch
new file mode 100644
index 00000000..2f15d246
--- /dev/null
+++ b/recipes-devtools/gnu-efi/files/0001-ARM32-Split-headers-and-code.patch
@@ -0,0 +1,93 @@
+From 24a4cd0e5653fd84b004c00c808c45cc3fb7a7e2 Mon Sep 17 00:00:00 2001
+From: Callum Farmer <gmbr3@opensuse.org>
+Date: Mon, 23 Sep 2024 16:51:49 +0100
+Subject: [PATCH] ARM32: Split headers and code
+
+* Force code to be at known dest of 4096
+* Move _start into .text
+* Load the _start symbol address and then minus 4096 to get the load
+  address
+
+Signed-off-by: Callum Farmer <gmbr3@opensuse.org>
+---
+ gnuefi/crt0-efi-arm.S  | 21 +++++++++++----------
+ gnuefi/elf_arm_efi.lds |  1 +
+ 2 files changed, 12 insertions(+), 10 deletions(-)
+
+diff --git a/gnuefi/crt0-efi-arm.S b/gnuefi/crt0-efi-arm.S
+index 9c2c467..ad02ca1 100644
+--- a/gnuefi/crt0-efi-arm.S
++++ b/gnuefi/crt0-efi-arm.S
+@@ -45,11 +45,11 @@ optional_header:
+ 	.2byte	0x10b				// PE32+ format
+ 	.byte	0x02				// MajorLinkerVersion
+ 	.byte	0x14				// MinorLinkerVersion
+-	.4byte	_etext - _start		// SizeOfCode
++	.4byte	_text_size - ImageBase		// SizeOfCode
+ 	.4byte	_alldata_size - ImageBase		// SizeOfInitializedData
+ 	.4byte	0				// SizeOfUninitializedData
+-	.4byte	_start - ImageBase		// AddressOfEntryPoint
+-	.4byte	_start - ImageBase		// BaseOfCode
++	.4byte	_text - ImageBase		// AddressOfEntryPoint
++	.4byte	_text - ImageBase		// BaseOfCode
+ 	.4byte	_reloc - ImageBase		// BaseOfData
+ 
+ extra_header_fields:
+@@ -67,7 +67,7 @@ extra_header_fields:
+ 	.4byte	_image_end - ImageBase		// SizeOfImage
+ 
+ 	// Everything before the kernel image is considered part of the header
+-	.4byte	_start - ImageBase		// SizeOfHeaders
++	.4byte	_text - ImageBase		// SizeOfHeaders
+ 	.4byte	0				// CheckSum
+ 	.2byte	EFI_SUBSYSTEM			// Subsystem
+ 	.2byte	0				// DllCharacteristics
+@@ -100,10 +100,10 @@ extra_header_fields:
+ section_table:
+ 
+ 	.ascii	".text\0\0\0"
+-	.4byte	_evtext - _start // VirtualSize
+-	.4byte	_start - ImageBase	// VirtualAddress
+-	.4byte	_etext - _start		// SizeOfRawData
+-	.4byte	_start - ImageBase	// PointerToRawData
++	.4byte	_text_vsize - ImageBase // VirtualSize
++	.4byte	_text - ImageBase	// VirtualAddress
++	.4byte	_text_size - ImageBase		// SizeOfRawData
++	.4byte	_text - ImageBase	// PointerToRawData
+ 	.4byte	0		// PointerToRelocations (0 for executables)
+ 	.4byte	0		// PointerToLineNumbers (0 for executables)
+ 	.2byte	0		// NumberOfRelocations  (0 for executables)
+@@ -148,7 +148,7 @@ section_table:
+ 	.2byte	0			// NumberOfLineNumbers
+ 	.4byte	0x40000040		// Characteristics (section flags)
+ 
+-.balign 256
++.text
+ .globl	_start
+ .type _start,%function
+ _start:
+@@ -159,7 +159,8 @@ _start:
+ 	adr		r1, .L_DYNAMIC
+ 	ldr		r0, [r1]
+ 	add		r1, r0, r1
+-	adr		r0, ImageBase
++	adr		r0, _start
++	sub		r0, r0, #0x1000
+ 	bl		_relocate
+ 	teq		r0, #0
+ 	bne		0f
+diff --git a/gnuefi/elf_arm_efi.lds b/gnuefi/elf_arm_efi.lds
+index afe17af..b7e3fb1 100644
+--- a/gnuefi/elf_arm_efi.lds
++++ b/gnuefi/elf_arm_efi.lds
+@@ -5,6 +5,7 @@ SECTIONS
+ {
+   .text 0 : {
+     *(.text.head)
++    . = 0x1000;
+     _text = .;
+     *(.text)
+     *(.text.*)
+-- 
+2.43.0
+
diff --git a/recipes-devtools/gnu-efi/gnu-efi_latest.bb b/recipes-devtools/gnu-efi/gnu-efi_latest.bb
new file mode 100644
index 00000000..2272a2b9
--- /dev/null
+++ b/recipes-devtools/gnu-efi/gnu-efi_latest.bb
@@ -0,0 +1,25 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg
+
+CHANGELOG_V="<orig-version>+cip"
+
+SRC_URI = "apt://${BPN}"
+SRC_URI += "file://0001-ARM32-Split-headers-and-code.patch;apply=no"
+
+do_prepare_build() {
+	deb_add_changelog
+
+	cd ${S}
+	quilt import -f ${WORKDIR}/*.patch
+	quilt push -a
+}
-- 
2.43.0


