Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2574DC61DBD
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 15:21:10 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15101.1787757660459649039
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2026 08:21:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=bsPe4hHM;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-202608261520578762a948e6000207ec-mychna@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202608261520578762a948e6000207ec
        for <cip-dev@lists.cip-project.org>;
        Wed, 26 Aug 2026 17:20:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=jcgZKxdtW93DQt8Y+XRyBVzqJDrO2mOIn8ht3uul1yg=;
 b=bsPe4hHMpbZz2lXvCwP17Q9nm8fm6KFBPDRN+VfPfIwna01v9vh3wLmTHTctLO1NlVwffG
 q2rFP5iXQ+KQh6kUzC4y+ixABjkOgeIjYWwPbOXw8+Qr1QL770v2t+wvUvbokmsV52KBtpIq
 ztRGkVZP51Nu0x/GsotkX32On91+NeG8joMw02xf+Bw+5RKVGn2ycyLH1izxxHOGLThbX3qp
 DeQjMrz/InJsD7wPUOtsKG+HKK4XGGBMRaXd65arduVTcxC9S/bSgZVfDcLCo9kDBODFq5f6
 vsmmag5QOBAZmUNxk4i5E3Sk3/JnDo/43Di4z/SCI2MNLFmvXudElgeA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v2 1/7] secure-boot-efi-keys: Add recipe to create EFI certificates
Date: Wed, 26 Aug 2026 17:20:49 +0200
Message-ID: <121612bb4bd7cf2f08c83f39d439d7382f0667ee.1787757655.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1787757655.git.jan.kiszka@siemens.com>
References: <cover.1787757655.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Aug 2026 15:21:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24023

From: Jan Kiszka <jan.kiszka@siemens.com>

This recipe allows to derive the PK, KEK and db values from a single
signing key as we are using for demonstration/testing purposes and
simple scenarios. The recipe provides abstract "secure-boot-efi-certs"
which could also be offered by an alternative recipe/package that picks
up differently generated certificates and/or a proper hierarchy.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../single-key-to-efi-certs_0.1.bb            | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb

diff --git a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
new file mode 100644
index 00000000..01d27041
--- /dev/null
+++ b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
@@ -0,0 +1,41 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg
+
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+DESCRIPTION = "Generate EFI certificates from single secure boot key"
+
+PROVIDES += "secure-boot-efi-certs"
+DEBIAN_PROVIDES = "secure-boot-efi-certs"
+
+DEPENDS = "secure-boot-secrets"
+DEBIAN_BUILD_DEPENDS .= ", secure-boot-secrets, efitools"
+
+do_prepare_build() {
+    deb_debianize
+
+    cat <<EOF > ${S}/debian/${BPN}.install
+db.auth usr/share/secure-boot-efi-certs
+KEK.auth usr/share/secure-boot-efi-certs
+PK.auth usr/share/secure-boot-efi-certs
+EOF
+
+    cat <<EOF >> ${S}/debian/rules
+
+override_dh_auto_build:
+	cert-to-efi-sig-list /usr/share/secure-boot-secrets/secure-boot.pem PK.esl
+	sign-efi-sig-list -k /usr/share/secure-boot-secrets/secure-boot.key \
+	    -c /usr/share/secure-boot-secrets/secure-boot.pem PK PK.esl PK.auth
+	cp PK.auth KEK.auth
+	cp PK.auth db.auth
+EOF
+}
-- 
2.47.3


