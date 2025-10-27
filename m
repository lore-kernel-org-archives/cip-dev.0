Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481BCCCF9FB
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 07:22:02 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.26396.1761549712339758161
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Oct 2025 00:21:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=N9lI/A/l;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-294854-20251027072149a4fbff5d0000020714-9mhdyj@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20251027072149a4fbff5d0000020714
        for <cip-dev@lists.cip-project.org>;
        Mon, 27 Oct 2025 08:21:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=DG9tUNhGlUGjkBK+ddlIVX7uZz/eDjnSfBJYuXcfVFE=;
 b=N9lI/A/l0Mdb89S7D5AuEjzGSWQ8QoTPlRMV2Rcco470qfH9fyrA4RM3o6L9J1Hw5w32gs
 YpLFqa6nyYYCo9fLpO6OrXac5loQXuPyNLXDeYl53QuQQGZ3RNIIfvyxcraB1umAMOSyQ2Wj
 WFP7KWMk03i0bx4HELo8Nye+bh5ExN42q8MsDUqPdeU6kKW+zoFwwgDCkytpo5/hKrLSvePS
 cIvMNdUdJH98Db0w5y82l0K3aEr4ETgeBonDAmU4njL5XdfkBxKY1f7+7hSQkoeE9fhIxbYr
 VsEql42jjx2hLSlVqC+lMZJvuksHNSPEBLkiFiaVd1qR05C5127089mg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 03/19] qemu-arm64: Add recipe for optee-ftpm
Date: Mon, 27 Oct 2025 08:21:32 +0100
Message-ID: <7a952fd8a21652cb9c1b892e952a61e35d571837.1761549708.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20227

From: Jan Kiszka <jan.kiszka@siemens.com>

Given a QEMU with RPMB emulation (upcoming upstream feature), this will
be able to replace the virtual discrete TPM we currently use for
qemu-arm64.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...ftpm-qemu-arm64_4.8+v1.62r1-48-ge9fc7b8.bb | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.8+v1.62r1-48-ge9fc7b8.bb

diff --git a/recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.8+v1.62r1-48-ge9fc7b8.bb b/recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.8+v1.62r1-48-ge9fc7b8.bb
new file mode 100644
index 00000000..5c462c8e
--- /dev/null
+++ b/recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.8+v1.62r1-48-ge9fc7b8.bb
@@ -0,0 +1,30 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require recipes-bsp/optee-ftpm/optee-ftpm.inc
+
+SRC_URI += " \
+    https://github.com/OP-TEE/optee_ftpm/archive/${SRCREV}.tar.gz;downloadfilename=optee_ftpm-${SRCREV}.tar.gz \
+    https://github.com/microsoft/ms-tpm-20-ref/archive/${SRCREV_ms-tpm}.tar.gz;name=ms-tpm;downloadfilename=ms-tpm-20-ref-${SRCREV_ms-tpm}.tar.gz \
+    "
+SRCREV = "04cbc8a136e8fe6731a536f5fe145e2862feafd7"
+SRCREV_ms-tpm = "e9fc7b89d865536c46deb63f9c7d0121a3ded49c"
+
+SRC_URI[sha256sum] = "7adfa71c4b49affef7d4db2436d8d6b93cdc3aaa9bdc9cf795c0bf7488a4cac6"
+SRC_URI[ms-tpm.sha256sum] = "b77d092c0dde362adf6bc88a580ca7c8abe124d69bb734bf28f8904ae30494a4"
+
+S = "${WORKDIR}/optee_ftpm-${SRCREV}"
+MS_TPM_20_REF_DIR = "ms-tpm-20-ref-${SRCREV_ms-tpm}"
+
+OPTEE_NAME = "qemu-arm64"
+
+TA_CPU = "cortex-a53"
+TA_DEV_KIT_DIR = "/usr/lib/optee-os/${OPTEE_NAME}/export-ta_arm64"
-- 
2.51.0


