Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28655.1793860213684552316
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Nov 2026 22:30:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=tdYocOWV;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=
	1793860210;x=1795069810;bh=LAnS7SXT06uQWy/o9Jtb1qNB/k/sdUziR5VlwFibAas=;b=tdY
	ocOWV2okj2ajxc0YEYzTT0L/4DVvWZ+c6DYNqjAn5xcmEIye9UZ8Li5iZFVsnOeYwLhVgA0g3il5m
	oKuSv+81dyM2LFTR6nEOzBtRRMV3dT97U5utca+TlU/GTKfrkzG6HD3ixwA9u5M27UKiF1CRJv/iM
	jizqvVVSGrbhj0QHlyyOi3rd8ydmyyUCV/IXJ85XJVTM3QwhTBQz99mO3LkN82LiDgW8Q8KLbHWWE
	LW2P+mXV22IWKk7HLEYPUu9IO8os1UFF3PyZL8VV4zXuNo7h4nQNndaPuZPMzvMNhlgtQsJlDeue6
	lJpnYLmvtHwnQLOh3fpg4tplKfjL31A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 6A56UApp2312237; Thu, 5 Nov 2026 15:30:10 +0900
X-Iguazu-Qid: 2yAb07c3D61FJIs5yK
X-Iguazu-QSIG: v=2; s=1; t=1793860210; q=2yAb07c3D61FJIs5yK; m=l03/wboh7p3drQou7HmqRu4Qe9OyFTRdAAERAhahTIw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jKsqk0nDcz1xnh; Thu,  5 Nov 2026 15:30:09 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [isar-cip-core][PATCH] u-boot: Change the mirror URL to u-boot-project.org
Date: Thu,  5 Nov 2026 15:30:04 +0900
X-TSB-HOP2: ON
Message-Id: <1793860204-10428-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 05 Nov 2026 06:30:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24637
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

It is no longer possible to retrieve the U-Boot source from denx.de. This
change updates the mirror to u-boot-project.org.
Since the mirror has been updated, the hash value for the tarball has also
been changed.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 recipes-bsp/u-boot/u-boot-common-2026.01.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/recipes-bsp/u-boot/u-boot-common-2026.01.inc b/recipes-bsp/u-boot/u-boot-common-2026.01.inc
index 9038dc7..60dffe0 100644
--- a/recipes-bsp/u-boot/u-boot-common-2026.01.inc
+++ b/recipes-bsp/u-boot/u-boot-common-2026.01.inc
@@ -16,7 +16,7 @@ MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
 FILESPATH:append := ":${FILE_DIRNAME}/files"
 
 SRC_URI += " \
-    https://ftp.denx.de/pub/u-boot/u-boot-${PV}.tar.bz2 \
+    https://git.u-boot-project.org/u-boot/u-boot/-/archive/v${PV}/u-boot-v${PV}.tar.bz2 \
     file://0001-spl-Kconfig-Add-missing-SPL_LOAD_BLOCK-for-SYS_MMCSD.patch \
     file://0002-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch \
     file://0003-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch \
@@ -34,7 +34,7 @@ SRC_URI += " \
     file://0006-mmc-Call-back-to-optee-after-a-successful-mmc_init.patch \
     file://0007-mmc-Make-MMC-Device-not-found-a-debug-output.patch \
     file://rules.tmpl;subdir=debian"
-SRC_URI[sha256sum] = "b60d5865cefdbc75da8da4156c56c458e00de75a49b80c1a2e58a96e30ad0d54"
+SRC_URI[sha256sum] = "536c2204bb875236dcba41f5a5802090039a4b7a704dd284fcb9640e66a84a8a"
 
 SRC_URI:append:ftpm-stmm = " \
     file://ftpm-stmm.cfg"
@@ -42,7 +42,7 @@ SRC_URI:append:ftpm-stmm = " \
 SRC_URI:append:secureboot = " \
     file://secure-boot.cfg"
 
-S = "${WORKDIR}/u-boot-${PV}"
+S = "${WORKDIR}/u-boot-v${PV}"
 
 DEBIAN_BUILD_DEPENDS += ", libssl-dev:native, libssl-dev:${DISTRO_ARCH}, \
     libgnutls28-dev:native, libgnutls28-dev:${DISTRO_ARCH}"
-- 
2.55.0


