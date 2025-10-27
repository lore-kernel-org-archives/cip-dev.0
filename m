Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048BCCCF9F4
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 07:22:02 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.26593.1761549712735237161
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Oct 2025 00:21:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=nVK8Sxxs;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-2025102707215010828a69770002077e-qfl_2y@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2025102707215010828a69770002077e
        for <cip-dev@lists.cip-project.org>;
        Mon, 27 Oct 2025 08:21:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=qcZU4NZIu/d5Bg80o4mu+4wd5mOKudKe2wz8gp5XuxE=;
 b=nVK8SxxszmIYMhhYvv22NHHrtRqr7sqd5CrpIIb4P0qL8OB0lAPjn87ynDNtobEOGXdl5A
 gPl612atoluHy0IgBs/CWCqqDtgRnxAXhqhWZU33fi3c+rYoYsW0WQ1Fopz+I/zKfCWH3HTy
 13wRhvwvROPQbSR7EmZAvuemWypBS7zFBv6Rj0LNBWUUeJzm+QaKh73+wagrbUyR80l6ykgb
 NILIie9ISu5C0OvNsTCN9fyCo7NmZE9TVowpU83RLzCa9pIMFfjvUgoWB99bwaFxRmcC52hJ
 fHbrQUJO5v3PkQd+gl3MQ/kzwQrlwU2UHHVGkAjKIJw0UCW0Y55ySAng==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 13/19] qemu-arm64: Switch firmware provider to TF-A in fTPM/StMM mode
Date: Mon, 27 Oct 2025 08:21:42 +0100
Message-ID: <4a358bfa062d13bc84f6d4859c41919ec7ed9f5e.1761549708.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20237

From: Jan Kiszka <jan.kiszka@siemens.com>

QEMU needs to boot via TF-A in order to install OP-TEE which is holding
the fTPM and StMM TAs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas/opt/ebg-swu.yml                       | 6 ++++--
 recipes-bsp/u-boot/u-boot-qemu-common.inc | 5 +++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
index 5066040c..ce64670c 100644
--- a/kas/opt/ebg-swu.yml
+++ b/kas/opt/ebg-swu.yml
@@ -29,8 +29,10 @@ local_conf_header:
     # not needed for Debian 11 and later
     DISTRO_APT_SOURCES:append:qemu-amd64:buster = " conf/distro/debian-buster-backports.list"
     DISTRO_APT_PREFERENCES:append:qemu-amd64:buster = " conf/distro/preferences.ovmf-snakeoil.conf"
-    # Add U-Boot for qemu
-    IMAGER_BUILD_DEPS:append:qemu-arm64 = " u-boot-qemu-arm64"
+    # Add firmware for qemu
+    QEMU_ARM64_FIRMWARE = "u-boot-qemu-arm64"
+    QEMU_ARM64_FIRMWARE:ftpm-stmm = "trusted-firmware-a-qemu-arm64"
+    IMAGER_BUILD_DEPS:append:qemu-arm64 = " ${QEMU_ARM64_FIRMWARE}"
     IMAGER_BUILD_DEPS:append:qemu-arm = " u-boot-qemu-arm"
     IMAGER_BUILD_DEPS:append:qemu-riscv64 = " opensbi-qemu-riscv64"
   drop-ext4-images: |
diff --git a/recipes-bsp/u-boot/u-boot-qemu-common.inc b/recipes-bsp/u-boot/u-boot-qemu-common.inc
index f1a415b1..b63e878c 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-common.inc
+++ b/recipes-bsp/u-boot/u-boot-qemu-common.inc
@@ -20,6 +20,11 @@ do_prepare_build:append() {
     cat ${WORKDIR}/qemu-extra.cfg >> ${S}/configs/${U_BOOT_CONFIG}
 }
 
+python() {
+    if 'ftpm-stmm' in d.getVar('OVERRIDES').split(':'):
+        d.setVarFlag('do_deploy_firmware', 'noexec', '1')
+}
+
 do_deploy_firmware() {
     dpkg --fsys-tarfile "${WORKDIR}/u-boot-${MACHINE}_${PV}_${DISTRO_ARCH}.deb" | \
         tar xOf - "./usr/lib/u-boot/${MACHINE}/${U_BOOT_BIN}" \
-- 
2.51.0


