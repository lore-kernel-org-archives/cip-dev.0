Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF9EC53200
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 12:40:49 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18378.1784896845992992709
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2026 05:40:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=LdrsOXKS;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20260724124043628d884b340002072d-d2cqun@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260724124043628d884b340002072d
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Jul 2026 14:40:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=mv1aOHjs/zcMm7tWThOi6DpbK0W3EQQ6iOvBSjM51ls=;
 b=LdrsOXKSxv/BWR9HKGY8eD+JpS7rPbHbgvHeeGAwqjApq2tQfJndeXiIIEDhmeNhhPMnMW
 DZZa+Hs+MsSx16DsO8/UjSlIof9JClxowV0K7V51NYKbODt6xT6gG7TVtiuOk83+zUCXOwDh
 zyB8adfDpYKy4Iwy2qgRbwZDj4VgHsub6xuRx5VdNQEra2qIvff9ADn5ukhzrYvAkuIeKWNu
 CzyVgn3WUzp8y9bNO+4ypcPKWfjj4ZLIBYEBST3V1YSkIvMFenieayU41XJM9KRl6/dv+QHk
 0VS/tlCA0txbC2yseBXxu4jIU26b7hiIlZApTY+2w2mMtjDt1d3RaM1A==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	christoph.steiger@siemens.com,
	clara.kowalsky@siemens.com
Subject: [RFC cip-dev][isar-cip-core][PATCH 09/14] Add class cis-hardening for post rootfs generation fixups
Date: Fri, 24 Jul 2026 14:39:11 +0200
Message-ID: <20260724124038.3633611-10-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
References: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jul 2026 12:40:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23746

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The kernel hardening can disable squashfs even when we build images that
use it. Add a conflict detection that is conditionally prepended to the
do_image_squashfs function. This makes sure we always catch the fact
that a squashfs image is built and can provide a clear error during
build, instead of not booting later on.

Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/cis-hardening.bbclass | 31 ++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 classes-recipe/cis-hardening.bbclass

diff --git a/classes-recipe/cis-hardening.bbclass b/classes-recipe/cis-hardening.bbclass
new file mode 100644
index 0000000..baf3e82
--- /dev/null
+++ b/classes-recipe/cis-hardening.bbclass
@@ -0,0 +1,31 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Felix Moessbauer <felix.moessbauer@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+# The config file is generated during install, hence
+# change permissions after all installs are settled
+apply_sshd_hardening[weight] = "1"
+apply_sshd_hardening() {
+    CIS_SSHD=/usr/share/cip-cis-rules/configuration/cis-5.2.1.sh
+    if [ -f "${ROOTFSDIR}/${CIS_SSHD}" ] && [ -f "${ROOTFSDIR}/usr/share/openssh/sshd_config" ]; then
+        sudo chroot "${ROOTFSDIR}" ${CIS_SSHD}
+    fi
+}
+ROOTFS_POSTPROCESS_COMMAND += "apply_sshd_hardening"
+
+python detect_squashfs_conflict() {
+    hardening_cfg = "{}/{}-hardening.kernel.cfg".format(d.getVar("DEPLOY_DIR_IMAGE"), d.getVar("DISTRO"))
+    with open(hardening_cfg) as f:
+        lines = list(map(lambda l: l.strip(), set(f.readlines())))
+
+    if "# CONFIG_SQUASHFS is not set" in lines:
+        bb.fatal("CIS kernel hardening disables squashfs, but squashfs is selected as image fs. Consider disabling the hardening option for squashfs or using an alternative fs.")
+}
+
+do_image_squashfs[prefuncs] += "detect_squashfs_conflict"
-- 
2.53.0


