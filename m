Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D30C5DF6A
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 13:01:47 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12359.1786712503257494085
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Aug 2026 06:01:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=KyGd+kDl;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-20260814130139957fcd1b900002076f-biky21@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260814130139957fcd1b900002076f
        for <cip-dev@lists.cip-project.org>;
        Fri, 14 Aug 2026 15:01:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=byZTJ3un/3rBFuu4LZeTdspqUNPXEHxmUSo+1jQ9FBs=;
 b=KyGd+kDlUqt1Ddf2P8hv4O3dIM2soa3cyTauaCp/0QoQgiXAdKebdi05LyRuKDRhCDQ9vU
 ra4ti6F4UUhnVdxBBBMEHkV8dhv82XbOG0f446NKmQka6KeKSKnIpV3GYasxmC22wlvgB+vD
 xxs/su4xIsxRn4papCCnjXZWr2fOBW+Ub8qkv/rAHaxgk+eguHhuJDIhFFAm8bljJbFG6+YC
 /fOkQaOGHeIOtjP7T+RX4JqqMjaIYf5/8oT7e+grSfLbTEi+0tZhJ4PsWszhlUgy94VjG/VZ
 oz8Jt/Fu7qZiBKUF/anXVzaeAoqqmQZ06fOt0qfkyMGMTsIYVArWFDEw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
	Sven Bauer <svenbauer@siemens.com>,
	Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
Subject: [isar-cip-core][PATCH 1/4] optee: Update to 4.10.0
Date: Fri, 14 Aug 2026 15:01:36 +0200
Message-ID: <fa994249450529b72944d3c2ecf499fca2f36698.1786712498.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1786712498.git.jan.kiszka@siemens.com>
References: <cover.1786712498.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Aug 2026 13:01:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23937

From: Jan Kiszka <jan.kiszka@siemens.com>

This will ease the update of fTPM core sources as well in a separate
step.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...8.bb => optee-ftpm-qemu-arm64_4.10+v1.62r1-48-ge9fc7b8.bb} | 4 ++--
 ...9fc7b8.bb => optee-ftpm-ti-k3_4.10+v1.62r1-48-ge9fc7b8.bb} | 4 ++--
 ...e-os-qemu-arm64_4.8.0.bb => optee-os-qemu-arm64_4.10.0.bb} | 0
 ...os-qemu-arm64_4.8.0.inc => optee-os-qemu-arm64_4.10.0.inc} | 2 +-
 ...-arm64_4.8.0.bb => optee-os-tadevkit-qemu-arm64_4.10.0.bb} | 0
 ...evkit-ti-k3_4.8.0.bb => optee-os-tadevkit-ti-k3_4.10.0.bb} | 0
 .../{optee-os-ti-k3_4.8.0.bb => optee-os-ti-k3_4.10.0.bb}     | 0
 .../{optee-os-ti-k3_4.8.0.inc => optee-os-ti-k3_4.10.0.inc}   | 2 +-
 8 files changed, 6 insertions(+), 6 deletions(-)
 rename recipes-bsp/optee-ftpm/{optee-ftpm-qemu-arm64_4.8+v1.62r1-48-ge9fc7b8.bb => optee-ftpm-qemu-arm64_4.10+v1.62r1-48-ge9fc7b8.bb} (86%)
 rename recipes-bsp/optee-ftpm/{optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb => optee-ftpm-ti-k3_4.10+v1.62r1-48-ge9fc7b8.bb} (86%)
 rename recipes-bsp/optee-os/{optee-os-qemu-arm64_4.8.0.bb => optee-os-qemu-arm64_4.10.0.bb} (100%)
 rename recipes-bsp/optee-os/{optee-os-qemu-arm64_4.8.0.inc => optee-os-qemu-arm64_4.10.0.inc} (78%)
 rename recipes-bsp/optee-os/{optee-os-tadevkit-qemu-arm64_4.8.0.bb => optee-os-tadevkit-qemu-arm64_4.10.0.bb} (100%)
 rename recipes-bsp/optee-os/{optee-os-tadevkit-ti-k3_4.8.0.bb => optee-os-tadevkit-ti-k3_4.10.0.bb} (100%)
 rename recipes-bsp/optee-os/{optee-os-ti-k3_4.8.0.bb => optee-os-ti-k3_4.10.0.bb} (100%)
 rename recipes-bsp/optee-os/{optee-os-ti-k3_4.8.0.inc => optee-os-ti-k3_4.10.0.inc} (90%)

diff --git a/recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.8+v1.62r1-48-ge9fc7b8.bb b/recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.10+v1.62r1-48-ge9fc7b8.bb
similarity index 86%
rename from recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.8+v1.62r1-48-ge9fc7b8.bb
rename to recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.10+v1.62r1-48-ge9fc7b8.bb
index 0dacd504..7c6b2b1d 100644
--- a/recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.8+v1.62r1-48-ge9fc7b8.bb
+++ b/recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.10+v1.62r1-48-ge9fc7b8.bb
@@ -17,10 +17,10 @@ SRC_URI += " \
     https://github.com/OP-TEE/optee_ftpm/archive/${SRCREV}.tar.gz;downloadfilename=optee_ftpm-${SRCREV}.tar.gz \
     https://github.com/microsoft/ms-tpm-20-ref/archive/${SRCREV_ms-tpm}.tar.gz;name=ms-tpm;downloadfilename=ms-tpm-20-ref-${SRCREV_ms-tpm}.tar.gz \
     "
-SRCREV = "04cbc8a136e8fe6731a536f5fe145e2862feafd7"
+SRCREV = "a09269b15de635e1816fe832e26adfbfb44c5455"
 SRCREV_ms-tpm = "e9fc7b89d865536c46deb63f9c7d0121a3ded49c"
 
-SRC_URI[sha256sum] = "7adfa71c4b49affef7d4db2436d8d6b93cdc3aaa9bdc9cf795c0bf7488a4cac6"
+SRC_URI[sha256sum] = "1ad448048fa8e507459fb24cc1e7e1a42099303a272c8804f8d62894090d047b"
 SRC_URI[ms-tpm.sha256sum] = "b77d092c0dde362adf6bc88a580ca7c8abe124d69bb734bf28f8904ae30494a4"
 
 S = "${WORKDIR}/optee_ftpm-${SRCREV}"
diff --git a/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb b/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.10+v1.62r1-48-ge9fc7b8.bb
similarity index 86%
rename from recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb
rename to recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.10+v1.62r1-48-ge9fc7b8.bb
index b28ea771..b43d6b44 100644
--- a/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb
+++ b/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.10+v1.62r1-48-ge9fc7b8.bb
@@ -15,10 +15,10 @@ SRC_URI += " \
     https://github.com/OP-TEE/optee_ftpm/archive/${SRCREV}.tar.gz;downloadfilename=optee_ftpm-${SRCREV}.tar.gz \
     https://github.com/microsoft/ms-tpm-20-ref/archive/${SRCREV_ms-tpm}.tar.gz;name=ms-tpm;downloadfilename=ms-tpm-20-ref-${SRCREV_ms-tpm}.tar.gz \
     "
-SRCREV = "04cbc8a136e8fe6731a536f5fe145e2862feafd7"
+SRCREV = "a09269b15de635e1816fe832e26adfbfb44c5455"
 SRCREV_ms-tpm = "e9fc7b89d865536c46deb63f9c7d0121a3ded49c"
 
-SRC_URI[sha256sum] = "7adfa71c4b49affef7d4db2436d8d6b93cdc3aaa9bdc9cf795c0bf7488a4cac6"
+SRC_URI[sha256sum] = "1ad448048fa8e507459fb24cc1e7e1a42099303a272c8804f8d62894090d047b"
 SRC_URI[ms-tpm.sha256sum] = "b77d092c0dde362adf6bc88a580ca7c8abe124d69bb734bf28f8904ae30494a4"
 
 S = "${WORKDIR}/optee_ftpm-${SRCREV}"
diff --git a/recipes-bsp/optee-os/optee-os-qemu-arm64_4.8.0.bb b/recipes-bsp/optee-os/optee-os-qemu-arm64_4.10.0.bb
similarity index 100%
rename from recipes-bsp/optee-os/optee-os-qemu-arm64_4.8.0.bb
rename to recipes-bsp/optee-os/optee-os-qemu-arm64_4.10.0.bb
diff --git a/recipes-bsp/optee-os/optee-os-qemu-arm64_4.8.0.inc b/recipes-bsp/optee-os/optee-os-qemu-arm64_4.10.0.inc
similarity index 78%
rename from recipes-bsp/optee-os/optee-os-qemu-arm64_4.8.0.inc
rename to recipes-bsp/optee-os/optee-os-qemu-arm64_4.10.0.inc
index bc684534..60ff87cf 100644
--- a/recipes-bsp/optee-os/optee-os-qemu-arm64_4.8.0.inc
+++ b/recipes-bsp/optee-os/optee-os-qemu-arm64_4.10.0.inc
@@ -11,7 +11,7 @@
 
 require optee-os-qemu.inc
 
-SRC_URI[sha256sum] = "5222cd553f5edb69ae4ec7cb99b2bfec2c47a47c0be1865b49744701918e8b4d"
+SRC_URI[sha256sum] = "18633691cb075ff2249422251f1cd77c30439a95b564b46682dea1fb6580a5af"
 
 OPTEE_NAME = "qemu-arm64"
 OPTEE_PLATFORM = "vexpress-qemu_armv8a"
diff --git a/recipes-bsp/optee-os/optee-os-tadevkit-qemu-arm64_4.8.0.bb b/recipes-bsp/optee-os/optee-os-tadevkit-qemu-arm64_4.10.0.bb
similarity index 100%
rename from recipes-bsp/optee-os/optee-os-tadevkit-qemu-arm64_4.8.0.bb
rename to recipes-bsp/optee-os/optee-os-tadevkit-qemu-arm64_4.10.0.bb
diff --git a/recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb b/recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.10.0.bb
similarity index 100%
rename from recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb
rename to recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.10.0.bb
diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb b/recipes-bsp/optee-os/optee-os-ti-k3_4.10.0.bb
similarity index 100%
rename from recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
rename to recipes-bsp/optee-os/optee-os-ti-k3_4.10.0.bb
diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc b/recipes-bsp/optee-os/optee-os-ti-k3_4.10.0.inc
similarity index 90%
rename from recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
rename to recipes-bsp/optee-os/optee-os-ti-k3_4.10.0.inc
index 4e99949d..a111364a 100644
--- a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
+++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.10.0.inc
@@ -13,7 +13,7 @@ SRC_URI += " \
     https://github.com/OP-TEE/optee_os/archive/${PV}.tar.gz;downloadfilename=optee-os-${PV}.tar.gz \
     "
 
-SRC_URI[sha256sum] = "5222cd553f5edb69ae4ec7cb99b2bfec2c47a47c0be1865b49744701918e8b4d"
+SRC_URI[sha256sum] = "18633691cb075ff2249422251f1cd77c30439a95b564b46682dea1fb6580a5af"
 
 S = "${WORKDIR}/optee_os-${PV}"
 
-- 
2.47.3


