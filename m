Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF67C5DF69
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 13:01:47 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12238.1786712503256607902
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Aug 2026 06:01:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=FDYZ51lT;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-20260814130139777e9e77940002071d-lenruj@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260814130139777e9e77940002071d
        for <cip-dev@lists.cip-project.org>;
        Fri, 14 Aug 2026 15:01:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=2iBcmmSkEDkxvju/I1yMMR0Nt+whLMmQCiljtdL9cks=;
 b=FDYZ51lTQseaV+MKSThJ0NunyzegIyNVbXFI3bAKPnvswy5v4Cx/gx8niMtFi+pljMFg6k
 W+eKLUNpVwQp5GWiC9GU/n/PsL2zcfLl9AkS1IZVGiESoYLupxLkgKaOj4BpvvBhnISigcWN
 NHeM4fT3qG8P3XyQOZguIuEZPZC7VE7dVZ2RtlzrpF+MyYvyssIN0WfYu5CsHbB/neaUcarC
 LsXi7KWk3QjjnwFZEhY3iUuqEWLfKJTddR9+XcnfLOvJxW+syIiIIwLxysXreGxo80y5JWRR
 oEHMCXNhCDCJHX9XHBEgCFmenFi0jYrqvzo+lIdRFgQkwOsRNZOgt1Ig==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
	Sven Bauer <svenbauer@siemens.com>,
	Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
Subject: [isar-cip-core][PATCH 2/4] optee-ftpm: Factor out common recipe bits of qemu-arm64 and ti-k3 targets
Date: Fri, 14 Aug 2026 15:01:37 +0200
Message-ID: <a6cba1d1cbe1d691eda7c651a9872216f5a533ba.1786712498.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23940

From: Jan Kiszka <jan.kiszka@siemens.com>

As long as both are in sync, it's easier to maintain this way.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...-ftpm-qemu-arm64_4.10+v1.62r1-48-ge9fc7b8.bb | 17 +----------------
 ...optee-ftpm-ti-k3_4.10+v1.62r1-48-ge9fc7b8.bb | 17 +----------------
 ... => optee-ftpm_4.10+v1.62r1-48-ge9fc7b8.inc} |  5 -----
 3 files changed, 2 insertions(+), 37 deletions(-)
 copy recipes-bsp/optee-ftpm/{optee-ftpm-qemu-arm64_4.10+v1.62r1-48-ge9fc7b8.bb => optee-ftpm_4.10+v1.62r1-48-ge9fc7b8.inc} (88%)

diff --git a/recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.10+v1.62r1-48-ge9fc7b8.bb b/recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.10+v1.62r1-48-ge9fc7b8.bb
index 7c6b2b1d..da832475 100644
--- a/recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.10+v1.62r1-48-ge9fc7b8.bb
+++ b/recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.10+v1.62r1-48-ge9fc7b8.bb
@@ -9,22 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-inherit optee-ftpm
-
-MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
-
-SRC_URI += " \
-    https://github.com/OP-TEE/optee_ftpm/archive/${SRCREV}.tar.gz;downloadfilename=optee_ftpm-${SRCREV}.tar.gz \
-    https://github.com/microsoft/ms-tpm-20-ref/archive/${SRCREV_ms-tpm}.tar.gz;name=ms-tpm;downloadfilename=ms-tpm-20-ref-${SRCREV_ms-tpm}.tar.gz \
-    "
-SRCREV = "a09269b15de635e1816fe832e26adfbfb44c5455"
-SRCREV_ms-tpm = "e9fc7b89d865536c46deb63f9c7d0121a3ded49c"
-
-SRC_URI[sha256sum] = "1ad448048fa8e507459fb24cc1e7e1a42099303a272c8804f8d62894090d047b"
-SRC_URI[ms-tpm.sha256sum] = "b77d092c0dde362adf6bc88a580ca7c8abe124d69bb734bf28f8904ae30494a4"
-
-S = "${WORKDIR}/optee_ftpm-${SRCREV}"
-MS_TPM_20_REF_DIR = "ms-tpm-20-ref-${SRCREV_ms-tpm}"
+require optee-ftpm_${PV}.inc
 
 OPTEE_NAME = "qemu-arm64"
 
diff --git a/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.10+v1.62r1-48-ge9fc7b8.bb b/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.10+v1.62r1-48-ge9fc7b8.bb
index b43d6b44..7e7921a0 100644
--- a/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.10+v1.62r1-48-ge9fc7b8.bb
+++ b/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.10+v1.62r1-48-ge9fc7b8.bb
@@ -7,22 +7,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-inherit optee-ftpm
-
-MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
-
-SRC_URI += " \
-    https://github.com/OP-TEE/optee_ftpm/archive/${SRCREV}.tar.gz;downloadfilename=optee_ftpm-${SRCREV}.tar.gz \
-    https://github.com/microsoft/ms-tpm-20-ref/archive/${SRCREV_ms-tpm}.tar.gz;name=ms-tpm;downloadfilename=ms-tpm-20-ref-${SRCREV_ms-tpm}.tar.gz \
-    "
-SRCREV = "a09269b15de635e1816fe832e26adfbfb44c5455"
-SRCREV_ms-tpm = "e9fc7b89d865536c46deb63f9c7d0121a3ded49c"
-
-SRC_URI[sha256sum] = "1ad448048fa8e507459fb24cc1e7e1a42099303a272c8804f8d62894090d047b"
-SRC_URI[ms-tpm.sha256sum] = "b77d092c0dde362adf6bc88a580ca7c8abe124d69bb734bf28f8904ae30494a4"
-
-S = "${WORKDIR}/optee_ftpm-${SRCREV}"
-MS_TPM_20_REF_DIR = "ms-tpm-20-ref-${SRCREV_ms-tpm}"
+require recipes-bsp/optee-ftpm/optee-ftpm_${PV}.inc
 
 OPTEE_NAME = "ti-k3"
 
diff --git a/recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.10+v1.62r1-48-ge9fc7b8.bb b/recipes-bsp/optee-ftpm/optee-ftpm_4.10+v1.62r1-48-ge9fc7b8.inc
similarity index 88%
copy from recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.10+v1.62r1-48-ge9fc7b8.bb
copy to recipes-bsp/optee-ftpm/optee-ftpm_4.10+v1.62r1-48-ge9fc7b8.inc
index 7c6b2b1d..232508f6 100644
--- a/recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.10+v1.62r1-48-ge9fc7b8.bb
+++ b/recipes-bsp/optee-ftpm/optee-ftpm_4.10+v1.62r1-48-ge9fc7b8.inc
@@ -25,8 +25,3 @@ SRC_URI[ms-tpm.sha256sum] = "b77d092c0dde362adf6bc88a580ca7c8abe124d69bb734bf28f
 
 S = "${WORKDIR}/optee_ftpm-${SRCREV}"
 MS_TPM_20_REF_DIR = "ms-tpm-20-ref-${SRCREV_ms-tpm}"
-
-OPTEE_NAME = "qemu-arm64"
-
-TA_CPU = "cortex-a53"
-TA_DEV_KIT_DIR = "/usr/lib/optee-os/${OPTEE_NAME}/export-ta_arm64"
-- 
2.47.3


