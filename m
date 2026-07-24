Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1925BC53215
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 12:40:50 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18376.1784896844247059719
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2026 05:40:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=f1Xw+IUX;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20260724124042fee291f22d00020747-t3xfdf@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260724124042fee291f22d00020747
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Jul 2026 14:40:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=angXJ60g2WOi7yAY5fa1nnWGVUXvVQ3Sjsu7Y2jRads=;
 b=f1Xw+IUXAAZX/Z4mrVCLOz7Qdm+PAPE1Tcxf7kYhfEDMTsMLBf+5CFDNjBYr4NEhymq2dd
 zcEIn9PudiNUKZK1YuX2ZwwvCStA7vUQBzdjaK8dRX+RdU+SlbMVxuGYDbJDrmwl+FiqNNZq
 YOtspuFYc7lBlcPelCITiarqoZr5nxUtRKYPiaL6NpC0SIVjqSdINbunmmY2ueBxofAAfpYO
 2ggOjlFNhc1v0nhGm8l4uz/1U5VmA+llIu+1mHF2dOtBwloqFUYru99wfFVmZNWcUYCP5EZA
 MeUOFVjsawOGLU2S6UPBBZv1LkhlZF0OYU+yGFNdP3prqkEDLATrsakw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	christoph.steiger@siemens.com,
	clara.kowalsky@siemens.com
Subject: [RFC cip-dev][isar-cip-core][PATCH 06/14] Apply hardening configuration to the kernel
Date: Fri, 24 Jul 2026 14:39:08 +0200
Message-ID: <20260724124038.3633611-7-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
References: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jul 2026 12:40:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23742

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Use the provided kernel hardening configuration options in the kernel
build.

Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/kernel-hardening.inc | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 recipes-kernel/linux/kernel-hardening.inc

diff --git a/recipes-kernel/linux/kernel-hardening.inc b/recipes-kernel/linux/kernel-hardening.inc
new file mode 100644
index 0000000..2b22fca
--- /dev/null
+++ b/recipes-kernel/linux/kernel-hardening.inc
@@ -0,0 +1,16 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+
+OVERRIDES:append = "${@'kernel-hardening' if bb.utils.to_boolean(d.getVar('CIP_CIS_HARDENING')) else ''}"
+
+KERNEL_CONFIG_FRAGMENTS:kernel-hardening += "hardening.kernel.cfg"
+
+do_dpkg_source[depends] += "${@'cip-cis-rules-config:do_deploy_hardening' if bb.utils.to_boolean(d.getVar('CIP_CIS_HARDENING')) else ''}"
+
+do_dpkg_source:prepend:kernel-hardening() {
+    cp ${DEPLOY_DIR_IMAGE}/${DISTRO}-hardening.kernel.cfg ${WORKDIR}/hardening.kernel.cfg
+}
-- 
2.53.0


