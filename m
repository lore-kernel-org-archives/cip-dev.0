Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39662CCF9F8
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 07:22:02 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.26399.1761549712415324354
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Oct 2025 00:21:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=fVNH/Vus;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-294854-202510270721505788afedeb0002078f-mzxupn@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202510270721505788afedeb0002078f
        for <cip-dev@lists.cip-project.org>;
        Mon, 27 Oct 2025 08:21:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=R39dC5SH+5NALFXUyKEub2ZtcFldzc/GYVuYsGgSaW4=;
 b=fVNH/VusErySeLX7JHu38Dx8rSlnMn7Wu/6XiZonavciLkz/03LJ2mwJ/ETkyI1fOBinQS
 u1czz/6OguTidENAb4d9w+myM6+wUbQvDfEJqo0C5yNaMioXY1iJBmYekRLXT8uLZZmqAgRJ
 8dfo3C4OA4o8nCsbkWk99Y3qbOGoeMxOkyl0ixvsTZ5ZzS1zA1KN1c9QnjFUqxtAUcoI612v
 3GjpjLhO3JJaS4uFpLxppLgH7b6tzuOny7YyN+hv9eVRa7ZXj/Ba/+PvadgT/1SBNduf8+sx
 JnVq2Az3X+pCN63onxMeYbKc9i/CqzQ4tHP4D3E2tLUEfRPlhCWmUYQg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 10/19] u-boot: Add optional support for fTPM/StMM
Date: Mon, 27 Oct 2025 08:21:39 +0100
Message-ID: <d52d3e491f263b9483973ea2d34d8afcb462cc2e.1761549708.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1761549708.git.jan.kiszka@siemens.com>
References: <cover.1761549708.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Oct 2025 07:22:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20229

From: Jan Kiszka <jan.kiszka@siemens.com>

Switch on support for fTPM and StMM in U-Boot when the corresponding
override is set.

This requires a patch to fix a build breakage of QEMU targets when
OP-TEE support is enabled. It will be available with v2026.01.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../files/0003-test-Fix-optee-unit-test.patch | 134 ++++++++++++++++++
 recipes-bsp/u-boot/files/ftpm-stmm.cfg        |   5 +
 recipes-bsp/u-boot/files/secure-boot.cfg      |   3 +-
 recipes-bsp/u-boot/u-boot-common-2025.07.inc  |  11 ++
 4 files changed, 152 insertions(+), 1 deletion(-)
 create mode 100644 recipes-bsp/u-boot/files/0003-test-Fix-optee-unit-test.patch
 create mode 100644 recipes-bsp/u-boot/files/ftpm-stmm.cfg

diff --git a/recipes-bsp/u-boot/files/0003-test-Fix-optee-unit-test.patch b/recipes-bsp/u-boot/files/0003-test-Fix-optee-unit-test.patch
new file mode 100644
index 00000000..ed928f64
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0003-test-Fix-optee-unit-test.patch
@@ -0,0 +1,134 @@
+From a7ff306c8ea79743552992638b8d228818cd9975 Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Mon, 15 Sep 2025 07:50:26 +0200
+Subject: [PATCH 3/3] test: Fix optee unit test
+
+This was apparently not built for several years: Since a2535243e011,
+optee_copy_fdt_nodes implicitly works against the U-Boot dt. We
+therefore have to tweak its reference before using the function and
+restore things afterwards.
+
+If it had been built, actually trying it out would have failed next: We
+need CONFIG_OPTEE_LIB to actually build the function that is primarily
+being tested here. And we need to re-initialize target fdt, now that the
+tests may run in random order.
+
+Fixes: a2535243e011 ("lib: optee: migration optee_copy_fdt_nodes for OF_LIVE support")
+Fixes: ba2feaf41435 ("test: Split optee tests into three functions")
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ test/optee/Kconfig |  1 +
+ test/optee/optee.c | 42 +++++++++++++++++++++++++++++++-----------
+ 2 files changed, 32 insertions(+), 11 deletions(-)
+
+diff --git a/test/optee/Kconfig b/test/optee/Kconfig
+index 63e2cbf79c7..ebf8d07c41c 100644
+--- a/test/optee/Kconfig
++++ b/test/optee/Kconfig
+@@ -1,6 +1,7 @@
+ config UT_OPTEE
+ 	bool "Enable OP-TEE Unit Tests"
+ 	depends on OF_CONTROL && OPTEE
++	select OPTEE_LIB
+ 	default y
+ 	help
+ 	  This enables the 'ut optee' command which runs a series of unit
+diff --git a/test/optee/optee.c b/test/optee/optee.c
+index 658621fa2fa..7e1c8d04a11 100644
+--- a/test/optee/optee.c
++++ b/test/optee/optee.c
+@@ -5,16 +5,20 @@
+ 
+ #include <command.h>
+ #include <errno.h>
++#include <fdtdec.h>
+ #include <fdt_support.h>
+ #include <log.h>
+ #include <malloc.h>
+ #include <tee/optee.h>
++#include <asm/global_data.h>
+ 
+ #include <linux/sizes.h>
+ 
+ #include <test/ut.h>
+ #include <test/optee.h>
+ 
++DECLARE_GLOBAL_DATA_PTR;
++
+ /* 4k ought to be enough for anybody */
+ #define FDT_COPY_SIZE	(4 * SZ_1K)
+ 
+@@ -40,14 +44,6 @@ static int optee_test_init(struct unit_test_state *uts)
+ 	if (!fdt)
+ 		return ret;
+ 
+-	/*
+-	 * Resize the FDT to 4k so that we have room to operate on
+-	 *
+-	 * (and relocate it since the memory might be mapped
+-	 * read-only)
+-	 */
+-	ut_assertok(fdt_open_into(fdt_base, fdt, FDT_COPY_SIZE));
+-
+ 	return 0;
+ }
+ OPTEE_TEST_INIT(optee_test_init, 0);
+@@ -127,9 +123,21 @@ static int optee_fdt_protected_memory(struct unit_test_state *uts)
+ static int optee_fdt_copy_empty(struct unit_test_state *uts)
+ {
+ 	void *fdt_no_optee = &__dtb_test_optee_no_optee_begin;
++	const void *fdt_blob = gd->fdt_blob;
++
++	/*
++	 * Resize the FDT to 4k so that we have room to operate on
++	 *
++	 * (and relocate it since the memory might be mapped
++	 * read-only)
++	 */
++	ut_assertok(fdt_open_into(&__dtb_test_optee_base_begin, fdt,
++				  FDT_COPY_SIZE));
+ 
+ 	/* This should still run successfully */
+-	ut_assertok(optee_copy_fdt_nodes(fdt_no_optee, fdt));
++	gd->fdt_blob = fdt_no_optee;
++	ut_assertok(optee_copy_fdt_nodes(fdt));
++	gd->fdt_blob = fdt_blob;
+ 
+ 	expect_success = false;
+ 	ut_assertok(optee_fdt_firmware(uts));
+@@ -143,8 +151,14 @@ OPTEE_TEST(optee_fdt_copy_empty, 0);
+ static int optee_fdt_copy_prefilled(struct unit_test_state *uts)
+ {
+ 	void *fdt_optee = &__dtb_test_optee_optee_begin;
++	const void *fdt_blob = gd->fdt_blob;
+ 
+-	ut_assertok(optee_copy_fdt_nodes(fdt_optee, fdt));
++	ut_assertok(fdt_open_into(&__dtb_test_optee_base_begin, fdt,
++				  FDT_COPY_SIZE));
++
++	gd->fdt_blob = fdt_optee;
++	ut_assertok(optee_copy_fdt_nodes(fdt));
++	gd->fdt_blob = fdt_blob;
+ 
+ 	expect_success = true;
+ 	ut_assertok(optee_fdt_firmware(uts));
+@@ -158,9 +172,15 @@ OPTEE_TEST(optee_fdt_copy_prefilled, 0);
+ static int optee_fdt_copy_already_filled(struct unit_test_state *uts)
+ {
+ 	void *fdt_optee = &__dtb_test_optee_optee_begin;
++	const void *fdt_blob = gd->fdt_blob;
++
++	ut_assertok(fdt_open_into(&__dtb_test_optee_base_begin, fdt,
++				  FDT_COPY_SIZE));
+ 
+ 	ut_assertok(fdt_open_into(fdt_optee, fdt, FDT_COPY_SIZE));
+-	ut_assertok(optee_copy_fdt_nodes(fdt_optee, fdt));
++	gd->fdt_blob = fdt_optee;
++	ut_assertok(optee_copy_fdt_nodes(fdt));
++	gd->fdt_blob = fdt_blob;
+ 
+ 	expect_success = true;
+ 	ut_assertok(optee_fdt_firmware(uts));
+-- 
+2.51.0
+
diff --git a/recipes-bsp/u-boot/files/ftpm-stmm.cfg b/recipes-bsp/u-boot/files/ftpm-stmm.cfg
new file mode 100644
index 00000000..af5da938
--- /dev/null
+++ b/recipes-bsp/u-boot/files/ftpm-stmm.cfg
@@ -0,0 +1,5 @@
+### Enable OPTEE, fTPM and StMM
+CONFIG_TEE=y
+CONFIG_OPTEE=y
+CONFIG_CMD_OPTEE_RPMB=y
+CONFIG_EFI_MM_COMM_TEE=y
diff --git a/recipes-bsp/u-boot/files/secure-boot.cfg b/recipes-bsp/u-boot/files/secure-boot.cfg
index 9d8b047e..694356f7 100644
--- a/recipes-bsp/u-boot/files/secure-boot.cfg
+++ b/recipes-bsp/u-boot/files/secure-boot.cfg
@@ -11,7 +11,8 @@ CONFIG_BOOTCOMMAND="bootflow scan -lb; echo 'EFI Boot failed!'; sleep 1000; rese
 CONFIG_HUSH_PARSER=y
 CONFIG_EFI_PARTITION=y
 CONFIG_FS_FAT=y
-CONFIG_EFI_VARIABLES_PRESEED=y
 CONFIG_EFI_SECURE_BOOT=y
+# overruled by CONFIG_EFI_MM_COMM_TEE where available
+CONFIG_EFI_VARIABLES_PRESEED=y
 # workaround for v2025.07
 CONFIG_CMD_DHCP=y
diff --git a/recipes-bsp/u-boot/u-boot-common-2025.07.inc b/recipes-bsp/u-boot/u-boot-common-2025.07.inc
index f9dde598..96c7ee96 100644
--- a/recipes-bsp/u-boot/u-boot-common-2025.07.inc
+++ b/recipes-bsp/u-boot/u-boot-common-2025.07.inc
@@ -18,9 +18,13 @@ SRC_URI += " \
     file://0001-tools-Do-not-generate-logo-when-cross-building.patch \
     file://0001-Kconfig-Convert-SYS_EARLY_PCI_INIT-to-Kconfig.patch \
     file://0002-qemu_arm-Select-CONFIG_SYS_EARLY_PCI_INIT.patch \
+    file://0003-test-Fix-optee-unit-test.patch \
     file://rules.tmpl;subdir=debian"
 SRC_URI[sha256sum] = "0f933f6c5a426895bf306e93e6ac53c60870e4b54cda56d95211bec99e63bec7"
 
+SRC_URI:append:ftpm-stmm = " \
+    file://ftpm-stmm.cfg"
+
 SRC_URI:append:secureboot = " \
     file://secure-boot.cfg"
 
@@ -37,11 +41,18 @@ STATIC_KEYS_BUILD_DEPENDS:append:bookworm = ", pesign"
 STATIC_KEYS_DEPENDS = "secure-boot-secrets"
 
 SECURE_BOOT_BUILD_DEPENDS = "${STATIC_KEYS_BUILD_DEPENDS}"
+SECURE_BOOT_BUILD_DEPENDS:ftpm-stmm = ""
 SECURE_BOOT_DEPENDS = "${STATIC_KEYS_DEPENDS}"
+SECURE_BOOT_DEPENDS:ftpm-stmm = ""
 
 DEBIAN_BUILD_DEPENDS:append:secureboot = "${SECURE_BOOT_BUILD_DEPENDS}"
 DEPENDS:append:secureboot = "${SECURE_BOOT_DEPENDS}"
 
+do_prepare_build:append:ftpm-stmm() {
+    sed -ni '/### Enable OPTEE, fTPM and StMM/q;p' ${S}/configs/${U_BOOT_CONFIG}
+    cat ${WORKDIR}/ftpm-stmm.cfg >> ${S}/configs/${U_BOOT_CONFIG}
+}
+
 do_prepare_build:append:secureboot() {
     sed -ni '/### Secure boot config/q;p' ${S}/configs/${U_BOOT_CONFIG}
     cat ${WORKDIR}/secure-boot.cfg >> ${S}/configs/${U_BOOT_CONFIG}
-- 
2.51.0


